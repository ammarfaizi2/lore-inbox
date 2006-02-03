Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751057AbWBCSHL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751057AbWBCSHL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 13:07:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751298AbWBCSHL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 13:07:11 -0500
Received: from kepler.fjfi.cvut.cz ([147.32.6.11]:11151 "EHLO
	kepler.fjfi.cvut.cz") by vger.kernel.org with ESMTP
	id S1751057AbWBCSHJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 13:07:09 -0500
Date: Fri, 3 Feb 2006 19:07:01 +0100 (CET)
From: Martin Drab <drab@kepler.fjfi.cvut.cz>
To: "Salyzyn, Mark" <mark_salyzyn@adaptec.com>
cc: Phillip Susi <psusi@cfl.rr.com>, Bill Davidsen <davidsen@tmr.com>,
       Cynbe ru Taren <cynbe@muq.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: RAID5 unusably unstable through 2.6.14
In-Reply-To: <547AF3BD0F3F0B4CBDC379BAC7E4189F021C9924@otce2k03.adaptec.com>
Message-ID: <Pine.LNX.4.60.0602031851460.24081@kepler.fjfi.cvut.cz>
References: <547AF3BD0F3F0B4CBDC379BAC7E4189F021C9924@otce2k03.adaptec.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Feb 2006, Salyzyn, Mark wrote:

> Martin Drab [mailto:drab@kepler.fjfi.cvut.cz] sez:
> > no access was possible at all to that block device entirely.
> 
> Then 'we' are missing an offline message (from SCSI/block or from a
> check of the controller's array status).

Besides, when the disk goes offline, which is what happened to me before 
due to the bad setting of the AAC_MAX_32BIT_SGBCOUNT constant in 
aacraid.h, kernel adequately responses with messages saying something like 
this:

[  278.705813] scsi0 (0:0): rejecting I/O to offline device
[  278.708685] Buffer I/O error on device sda2, logical block 1
[  278.711589] lost page write due to I/O error on sda2

As you may see in my first report of the event when I've witnessed the 
real situation of the array going offline, see the whole report here:

	http://lkml.org/lkml/2005/7/5/194

However this time, it was different. I am a 100% positive that no such 
messages appeared whatsoever. Only these:

      sd 0:0:0:0: SCSI error: return code = 0x8000002
      sda: Current: sense key: Hardware Error
          Additional sense: Internal target failure
      Info fld=0x0
      end_request: I/O error, dev sda, sector <some sector number>

Nothing else.

Martin
