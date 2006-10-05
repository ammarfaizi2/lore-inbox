Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751043AbWJEGPK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751043AbWJEGPK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 02:15:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751497AbWJEGPK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 02:15:10 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:57293 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751043AbWJEGPI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 02:15:08 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andrew Morton <akpm@osdl.org>
Cc: vgoyal@in.ibm.com,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Reloc Kernel List <fastboot@lists.osdl.org>, ak@suse.de,
       horms@verge.net.au, lace@jankratochvil.net, hpa@zytor.com,
       magnus.damm@gmail.com, lwang@redhat.com, dzickus@redhat.com,
       maneesh@in.ibm.com
Subject: Re: [PATCH 12/12] i386 boot: Add an ELF header to bzImage
References: <20061003170032.GA30036@in.ibm.com>
	<20061003172511.GL3164@in.ibm.com>
	<20061003201340.afa7bfce.akpm@osdl.org>
	<m1vemzbe4c.fsf@ebiederm.dsl.xmission.com>
	<20061004214403.e7d9f23b.akpm@osdl.org>
Date: Thu, 05 Oct 2006 00:13:12 -0600
In-Reply-To: <20061004214403.e7d9f23b.akpm@osdl.org> (Andrew Morton's message
	of "Wed, 4 Oct 2006 21:44:03 -0700")
Message-ID: <m1ejtnb893.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> I tested it with Vivek's fix (below) and it still dies immediately.
>
> The grub record is
>
> title new (2.6.19-rc1)
>         root (hd0,5)
>         kernel /boot/bzImage-2.6.19-rc1 ro root=LABEL=/ rhgb vga=0x263
>         initrd /boot/initrd-2.6.19-rc1.img
>
> various binares are at http://userweb.kernel.org/~akpm/reloc/

Thanks.   

The fix was actually to remove a conflict with the other ELF notes we
are starting to generate (in the Xen context) so we can get our act
together that way.  I had no reason to suspect it would have had any
connection with your boot failure. 

I examined your bzImage and it does not have a multiboot signature,
in the first 8k.

I pointed my grub at your bzImage and it booted as far as searching
for init.  The only differences were I don't have video mode 0x263
so when prompted for something supported I told it to use video mode
0 instead.  My boot partition is (hd0,0) and is just boot, so
I changed the grub configuration to:

title Andrew
         root (hd0,0)
         kernel /bzImage-2.6.19-rc1 ro root=LABEL=/ rhgb vga=0x263
         initrd /initrd-2.6.19-rc1.img

So it feels like a subtle interaction with your hardware, or firmware.
Do things work better if you don't specify a vga=xxx mode?

This is a weird problem.

Eric
