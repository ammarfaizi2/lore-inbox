Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261815AbUDIF4v (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Apr 2004 01:56:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261850AbUDIF4v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Apr 2004 01:56:51 -0400
Received: from hierophant.serpentine.com ([66.92.13.71]:39628 "EHLO
	pelerin.serpentine.com") by vger.kernel.org with ESMTP
	id S261815AbUDIF4u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Apr 2004 01:56:50 -0400
Subject: Re: initramfs howto?
From: "Bryan O'Sullivan" <bos@serpentine.com>
To: Chris Meadors <clubneon@hereintown.net>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <1081451826.238.23.camel@clubneon.priv.hereintown.net>
References: <1081451826.238.23.camel@clubneon.priv.hereintown.net>
Content-Type: text/plain
Message-Id: <1081490209.28834.19.camel@camp4.serpentine.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 08 Apr 2004 22:56:49 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-04-08 at 12:17, Chris Meadors wrote:

> Then I cpio'd up the
> tree, gzip'd it, and put it where I told grub to find it:
>  "initrd (hd0,0)/boot/test/initramfs.cpio.gz"

Did you use a newc-format cpio archive?  Sounds like yes, but I want to
be sure.

> When I boot the kernel associated with that initrd line, it says that it
> found a compressed image at block 0.  But then panics saying it can't
> mount the root filesystem.

You need a patch to force the kernel not to bother trying to mount a
root filesystem.  This has been floating around for a while somewhere. 
If you don't use this patch, the kernel won't fall through to initramfs
and panics instead, as you are seeing.

Ooh, I see that Olaf Hering has a recent variant of this patch which is
in -aa kernels.  Andrew, can you consider dropping this into -mc or -mm,
please?  It won't break normal operation, but will relieve the pain of
the not-yet-battle-scarred.  It's less fugly than the earlier dev=0:0
patch.  Maybe.

http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.6/2.6.5-rc3-aa1/initramfs-search-for-init

	<b

