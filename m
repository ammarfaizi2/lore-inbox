Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265434AbUBPIr2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 03:47:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265463AbUBPIr2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 03:47:28 -0500
Received: from zero.aec.at ([193.170.194.10]:29451 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S265434AbUBPIrZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 03:47:25 -0500
To: lepton <lepton@mail.goldenhope.com.cn>
cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG]linux-2.4.24 with k8 numa support panic when init scsi
References: <1ncMn-H9-7@gated-at.bofh.it> <1ncMn-H9-9@gated-at.bofh.it>
	<1ncMm-H9-5@gated-at.bofh.it> <1ndIo-1yd-1@gated-at.bofh.it>
	<1pI5B-23P-3@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
In-Reply-To: <1pI5B-23P-3@gated-at.bofh.it> (lepton@mail.goldenhope.com.cn's
 message of "Mon, 16 Feb 2004 05:00:19 +0100")
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.2 (gnu/linux)
Date: Mon, 16 Feb 2004 05:28:03 +0100
Message-ID: <m3znbjk5rg.fsf@averell.firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

lepton <lepton@mail.goldenhope.com.cn> writes:

> I have do some test on weekend. The result is:
>
> 1. Compiling kernel with gcc 3.2:
>    2.4.20 2.4.21: can boot, can mount reiserfs filesystem
>    2.4.22: can boot, can mount reiserfs filesystem, but will panic
>    when reboot. It is perhaps because of "reboot=triple" ? 

Possible.

>    2.4.23: panic when init scsi, like before.

It could be a problem with the SCSI driver. I don't have any other reports
of this.

>    2.4.24: can boot, can mount reiserfs filesystem, but will panic when
>    reboot.

> 2. Compiling kernel with gcc 3.3
>    2.4.20: can not compile.... 
>    2.4.21: can boot, can mount reiserfs filesystem
>    2.4.22: can boot, can mount reiserfs filesystem, but will panic when
>    reboot.
>    2.4.23: panic when init scsi, like before
>    2.4.24: panic when init scsi, like before
>
> 3. when panic, reboot=bios or reboot=triple both can not work.

Of course they don't help for SCSI panics, just possible for reboot
problems.

>    2.4.24 changes a little from 2.4.23, so it is strange system will
>    panic in 2.4.23 and don't panic in 2.4.24 when using gcc 3.2
>    Perhaps there is some random error?

Yes, it looks very strange. I don't have a good explanation. Especially
since the behaviour changes with the compiler. It's probably some 
random memory corruption somewhere.

I will look into the reboot crashes with non standard options. 

Regarding the original reboot issues it seems to be related to C stepping 
CPUs (we never had any with B stepping).

Anyways, the reboot problem is probably not fatal for you so I guess
you can just use 2.4.24 compiled with gcc 3.2 for now.

-Andi

