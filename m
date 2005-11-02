Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965294AbVKBW7R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965294AbVKBW7R (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 17:59:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965332AbVKBW7R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 17:59:17 -0500
Received: from xproxy.gmail.com ([66.249.82.200]:25882 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965294AbVKBW7Q convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 17:59:16 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bQEUww1envYex0HDRarEEMrp7JmUGDWu+/NO2AYZ3cGadOYJBdyUGvCr3AlZjLsWx0NjAkgH3tgll7/LtgokF81lT2+PH4aqHf5ANUT9tzysfQJpUHA4hbSL7AkeGsVAXllfKEK53NhgweYG/mNUsEnwl5OLWDoCvcJeor3EyN0=
Message-ID: <b1bc6a000511021459h1a2f5089q3b37b56460b7799d@mail.gmail.com>
Date: Wed, 2 Nov 2005 15:59:16 -0700
From: adam radford <aradford@gmail.com>
To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: Re: 3ware 9550SX problems - mke2fs incredibly slow writing last third of inode tables
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <BEDEA151E8B1D6CEDD295442@192.168.100.25>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <BEDEA151E8B1D6CEDD295442@192.168.100.25>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/30/05, Alex Bligh - linux-kernel <linux-kernel@alex.org.uk> wrote:

> All seems to go well until I try and do mke2fs. This appears to work,
> and tries to write the inode tables. However, at (about) 3400 inodes
> (of 11176), it slows to a crawl, writing one table every 10 seconds.
> strace shows it is still running, and no errors are being reported.
> However, it seems very sick.

Do you have cache turned on or off?  If it's off, try turning it on.

>
> No debug messages indicating any errors.
>
> The only other clue as to what may be wrong is in the boot sequence.
> I see lots of bad LUN messages (detail below). However, it does appear
> to be detecting the disks right in the end.
>
> Anyone got any ideas?
>
>
> Oct 30 20:09:09 localhost kernel: [ 138.688249]
> /dev/scsi/host4/bus0/target0/lun0: p1 < p5 >
> Oct 30 20:09:09 localhost kernel: [ 138.712496] Attached scsi disk sdb at
> scsi4, channel 0, id 0, lun 0
> Oct 30 20:09:09 localhost kernel: [ 138.712814] scsi: On host 4 channel 0
> id 0
> only 511 (max_scsi_report_luns) of 214715501 luns reported, try increasing
> max_scsi_report_luns.
> Oct 30 20:09:09 localhost kernel: [ 138.712817] scsi: host 4 channel 0 id 0
> lun 0x383438203636202d has a LUN larger than currently supported.

There were some changes to scsi_scan.c between 2.6.12 and 2.6.14 that
seem to have fixed this issue.  Reproduce with 2.6.14.

-Adam
