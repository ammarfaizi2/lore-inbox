Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269881AbUJMWVu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269881AbUJMWVu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 18:21:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269889AbUJMWVI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 18:21:08 -0400
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:29893 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S269883AbUJMWSj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 18:18:39 -0400
Message-ID: <416DA951.2090104@rtr.ca>
Date: Wed, 13 Oct 2004 18:16:49 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Mark Lord <lsml@rtr.ca>, Linux Kernel <linux-kernel@vger.kernel.org>,
       linux-scsi@vger.kernel.org
Subject: Re: [PATCH] QStor SATA/RAID driver for 2.6.9-rc3
References: <4161A06D.8010601@rtr.ca> <4165B233.9080405@rtr.ca> <416D8A4E.5030106@pobox.com>
In-Reply-To: <416D8A4E.5030106@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 >>
 >> Right now that's not as easy as it could be, due to the specialized
 >> libata struct parameters required, but I think it could be harmonized.
 >
 >
 >I recall this but don't see it in my inbox anymore... did I adequately respond?

Well, that makes two of us that have lost the original.  :)

No response from you yet, and I don't want to waste the effort
on patches if they'll be rejected outright, thus the initial query:

The change would be as follows:  Export ata_scsi_simulate(),
and replace the first two parameters (struct ata_port, struct ata_device)
with a pointer to the 512-byte drive IDENTIFY response data.

That way, ata_scsi_simulate() becomes usable from drivers (like qstor)
that are not libata based.  The identify data parameter would, of course,
also be propogated down into all of the associated helper functions
that get invoked by ata_scsi_simulate() and pals.

At present, this will work, since those routines are only interested
in the identify data today, but I don't know about any future plans
there might be for it all.

Of course, even to use this, QStor will still have to create fake
identify blocks for each RAID device..

Cheers
-- 
Mark Lord
(hdparm keeper & the original "Linux IDE Guy")
