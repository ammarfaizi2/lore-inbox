Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750753AbWJEENx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750753AbWJEENx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 00:13:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750759AbWJEENx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 00:13:53 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:49796 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750753AbWJEENw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 00:13:52 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: vgoyal@in.ibm.com, Andrew Morton <akpm@osdl.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Reloc Kernel List <fastboot@lists.osdl.org>, ak@suse.de,
       horms@verge.net.au, lace@jankratochvil.net, magnus.damm@gmail.com,
       lwang@redhat.com, dzickus@redhat.com, maneesh@in.ibm.com
Subject: Re: [PATCH 12/12] i386 boot: Add an ELF header to bzImage
References: <20061003170032.GA30036@in.ibm.com>
	<20061003172511.GL3164@in.ibm.com>
	<20061003201340.afa7bfce.akpm@osdl.org>
	<20061004042850.GA27149@in.ibm.com> <45233B58.1050208@zytor.com>
	<m1sli4cxr2.fsf@ebiederm.dsl.xmission.com>
	<4523D0AF.5000907@zytor.com>
Date: Wed, 04 Oct 2006 22:12:11 -0600
In-Reply-To: <4523D0AF.5000907@zytor.com> (H. Peter Anvin's message of "Wed,
	04 Oct 2006 08:18:07 -0700")
Message-ID: <m1u02jbdus.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H. Peter Anvin" <hpa@zytor.com> writes:

> Well, it doesn't help if what you end up with for some bootloader is a
> nonfunctioning kernel.

I agree.  We need to look at what is happening closely.  
However just because we have some initial glitches doesn't mean we
shouldn't give up.

With grub you can say:
kernel --type=biglinux /path/to/bzImage

As I read the code it won't necessarily force the type of kernel image
grub will use but it will refuse to boot if it doesn't recognize 
the kernel as the type specified.

The code for grub is in stage2/boot.c:load_image().  It tries a few
other formats before it tests for the linux magic number but
it won't recognize an ELF format executable unless it is a mutliboot
or a BSD executable.

Eric
