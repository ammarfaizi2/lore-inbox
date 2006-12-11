Return-Path: <linux-kernel-owner+w=401wt.eu-S1762933AbWLKThM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762933AbWLKThM (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 14:37:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763021AbWLKThM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 14:37:12 -0500
Received: from MAIL.13thfloor.at ([213.145.232.33]:45746 "EHLO
	MAIL.13thfloor.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763018AbWLKThK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 14:37:10 -0500
Date: Mon, 11 Dec 2006 20:37:09 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: Andy Whitcroft <apw@shadowen.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Olaf Hering <olaf@aepfle.de>,
       Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Steve Fox <drfickle@us.ibm.com>
Subject: Re: 2.6.19-git13: uts banner changes break SLES9 (at least)
Message-ID: <20061211193709.GD7256@MAIL.13thfloor.at>
Mail-Followup-To: Andy Whitcroft <apw@shadowen.org>,
	Linus Torvalds <torvalds@osdl.org>, Olaf Hering <olaf@aepfle.de>,
	Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, Steve Fox <drfickle@us.ibm.com>
References: <457D750C.9060807@shadowen.org> <20061211163333.GA17947@aepfle.de> <Pine.LNX.4.64.0612110840240.12500@woody.osdl.org> <Pine.LNX.4.64.0612110852010.12500@woody.osdl.org> <20061211180414.GA18833@aepfle.de> <20061211181813.GB18963@aepfle.de> <Pine.LNX.4.64.0612111022140.12500@woody.osdl.org> <20061211182908.GC7256@MAIL.13thfloor.at> <Pine.LNX.4.64.0612111040160.12500@woody.osdl.org> <457DAF99.4050106@shadowen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <457DAF99.4050106@shadowen.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2006 at 07:20:57PM +0000, Andy Whitcroft wrote:
> Linus Torvalds wrote:
> >
> >On Mon, 11 Dec 2006, Herbert Poetzl wrote:
> >>cool!
> >>
> >>should definitely work for all 'known' cases
> >
> >No it doesn't.

well, the 'method' not the actual patch, i.e.
you should be as lucky as before, if the banner
string is not touched at all, and the version
entry does duplicate the parts ...

> >Do a
> >
> >	git grep '".*Linux version .*"'
> >
> >on the kernel, and see just how CRAP that "get_kernel_version" test is, 
> >and has always been.
> >
> >But let's hope that CIFS is never compiled into a SLES kernel. Because 
> >this isn't worth fixing at that point, and the SLES people should just fix 
> >their piece of crap initrd script.
> >
> >And next time somebody says "random vmlinux binary" to me, I'll blacklist 
> >their email address. You shouldn't do initrd for "random binaries". Just 
> >pass the release name somewhere (maybe in the name of the binary, for 
> >example, and if the name doesn't have a version in it, tough titties).
> >
> >		Linus
> >-
> >To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> >the body of a message to majordomo@vger.kernel.org
> >More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >Please read the FAQ at  http://www.tux.org/lkml/
> 
> I am afraid to report that this second version also fails for me, as you 
> point out CIFS can break us if defined.  In fact we used to get away 
> with this on my test system due to ordering magic luck, I presume the 
> move to __initdata has triggered this.  Much as I agree that this is 
> wrong we are still going to break people with this.

maybe it would make sense (in SLES) to have that
a special elf section, which is carefully added
to the beginning of the compiled kernel, right
after what is left of the initialization/boot code?

not sure that is mainline stuff though ...

best,
Herbert

> Before:
> 
> Module list:	sym53c8xx reiserfs
> Kernel version:	2.6.19-git12-autokern1 (powerpc)
> Kernel image:	/boot/vmlinuz-autobench
> Initrd image:	/boot/initrd-autobench.img.new
> Shared libs:	lib/ld-2.3.3.so lib/libc.so.6 lib/libselinux.so.1
> Cannot determine dependencies of module sym53c8xx. Is modules.dep up to 
> date?
> Modules:	
> none
> 5735 blocks
> 
> After:
> 
> Module list:	sym53c8xx reiserfs
> Kernel version:	 (powerpc)
> Kernel image:	/boot/vmlinuz-autobench
> Initrd image:	/boot/initrd-autobench.img.new
> No modules found for kernel
> 
> -apw
