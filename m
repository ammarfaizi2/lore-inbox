Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261765AbUBVWNe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 17:13:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261767AbUBVWNe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 17:13:34 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:58248 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261765AbUBVWNb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 17:13:31 -0500
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: BOOT_CS
References: <c16rdh$gtk$1@terminus.zytor.com>
	<m1znbbjgfz.fsf@ebiederm.dsl.xmission.com>
	<40390759.2020201@zytor.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 22 Feb 2004 15:05:46 -0700
In-Reply-To: <40390759.2020201@zytor.com>
Message-ID: <m165dykbwl.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H. Peter Anvin" <hpa@zytor.com> writes:

> Eric W. Biederman wrote:
> > hpa@zytor.com (H. Peter Anvin) writes:
> >
> >>Anyone happen to know of any legitimate reason not to reload %cs in
> >> head.S?
> > Other than the fact it is strongly rude and error prone to depend on
> > the contents of a global descriptor table you did not setup?
> >
> 
> We already do that, as you might have noticed (we set all the data registers to
> __BOOT_DS; CS is the only that is changed.)

Right and it would be a cleanup not to touch __BOOT_DS.  We have
already reloaded it in  arch/i386/boot/compressed/head.S anyway.

> > That is almost nice.  Care to export where the bottom of the page
> > tables or even better where the bottom of the kernel is for those
> > folks who want to place their ramdisk as low in memory as possible?
> >
> 
> The problem is that you don't know until it's too late, since it can depend on
> dynamic factors.  This is part of why your insistence of putting the ramdisk in
> the "most incorrect" position is simply wrong.

Nope.  On other architectures where the bootloader has access to
vmlinux this works just fine, all dynamic factors can be contained in
the bss.  We don't go very long before we reserve memory after all.
It is only on x86 where there is not enough information that it is
problematic. 

Putting the ramdisk right after the kernel (text + data + bss) is the
"most correct" position.  Anything else is likely to break when the
firmware changes.  This has already happened 2 or 3 times on x86.

When putting the ramdisk right after the kernel if anything breaks you
will notice it immediately, and the kernel will be fixed.

If I truly put an initrd at the top of memory the kernel would not
even be able to read the ramdisk.

Eric
