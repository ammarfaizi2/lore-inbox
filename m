Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131501AbRCNUIH>; Wed, 14 Mar 2001 15:08:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131510AbRCNUH5>; Wed, 14 Mar 2001 15:07:57 -0500
Received: from gear.torque.net ([204.138.244.1]:23824 "EHLO gear.torque.net")
	by vger.kernel.org with ESMTP id <S131501AbRCNUHr>;
	Wed, 14 Mar 2001 15:07:47 -0500
Message-ID: <3AAFCFC1.B51C00D@torque.net>
Date: Wed, 14 Mar 2001 15:08:33 -0500
From: Douglas Gilbert <dougg@torque.net>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, david@2gen.com
Subject: Re: Problems with SCSI on 2.4.X
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

david@2gen.com wrote:

> I'm having some problems using SCSI-generic (sg loaded as module) to
> access my scanner on linux 2.4 (using SANE).
>
> [snip output showing timeouts]

This is most likely caused by a bug in SANE 1.0.3 and 
1.0.4 which sets timeouts on commands to 10 seconds 
rather than 10 minutes. The SANE code detects the new 
sg driver in lk 2.4.x and mistakenly shortens the 
timeout. This has been fixed in SANE's CVS (and 
RedHat's 7.1 beta (fisher)). 

Fix for SANE 1.0.4 : in file
sane-backends-1.0.4/sanei/sanei_scsi.c change line 1893 
from:
      req->sgdata.sg3.hdr.timeout = 10000;
to
      req->sgdata.sg3.hdr.timeout = 10 * 60 * 1000;


If you look at the FAQ on the sg web site 
( http://www.torque.net/sg ) under the SANE entry you will
find the same information ...

Doug Gilbert
