Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264639AbUGZAH0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264639AbUGZAH0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jul 2004 20:07:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264643AbUGZAHZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jul 2004 20:07:25 -0400
Received: from main.gmane.org ([80.91.224.249]:42698 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S264639AbUGZAHY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jul 2004 20:07:24 -0400
X-Injected-Via-Gmane: http://gmane.org/
Mail-Followup-To: linux-kernel@vger.kernel.org
To: linux-kernel@vger.kernel.org
From: Benjamin Rutt <rutt.4+news@osu.edu>
Subject: Re: clearing filesystem cache for I/O benchmarks
Date: Sun, 25 Jul 2004 20:07:21 -0400
Message-ID: <87smbfr5qe.fsf@osu.edu>
References: <87vfgeuyf5.fsf@osu.edu> <1090647090.8775.19.camel@kryten.internal.splhi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: dhcp065-025-157-254.columbus.rr.com
Mail-Copies-To: nobody
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3.50 (gnu/linux)
Cancel-Lock: sha1:TJcv3Xtwh6oxcfRdE3W3KASomCs=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Wright <timw@splhi.com> writes:

> Take a look at the code in hdparm tool that handles the '-f' option.
>
> Basically calling ioctl(fd, BLKFLSBUF, o) where fd is a file descriptor
> opened on the block device on which your filesystem resides should be
> enough to clear the cache.

Thanks, that looks pretty useful, at least to force the I/O to make it
outside the kernel.  I'm still getting cache hits for some read tests
though, no doubt due to cache near the physical disks and/or
controllers.  Correct me if I'm wrong, but this ioctl doesn't appear
to go out and tell disks to clear their caches.

I think I'll use the BLKFLSBUF in any case in my tests though, as it
doesn't seem to take very long to execute.  It can't hurt, and should
complement the act of reading through a large dummy file, which should
take care of the disk/controller caches.
-- 
Benjamin Rutt

