Return-Path: <linux-kernel-owner+w=401wt.eu-S937591AbWLKTVJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937591AbWLKTVJ (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 14:21:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937595AbWLKTVJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 14:21:09 -0500
Received: from hellhawk.shadowen.org ([80.68.90.175]:2364 "EHLO
	hellhawk.shadowen.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937591AbWLKTVG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 14:21:06 -0500
Message-ID: <457DAF99.4050106@shadowen.org>
Date: Mon, 11 Dec 2006 19:20:57 +0000
From: Andy Whitcroft <apw@shadowen.org>
User-Agent: Icedove 1.5.0.8 (X11/20061116)
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Herbert Poetzl <herbert@13thfloor.at>, Olaf Hering <olaf@aepfle.de>,
       Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Steve Fox <drfickle@us.ibm.com>
Subject: Re: 2.6.19-git13: uts banner changes break SLES9 (at least)
References: <457D750C.9060807@shadowen.org> <20061211163333.GA17947@aepfle.de> <Pine.LNX.4.64.0612110840240.12500@woody.osdl.org> <Pine.LNX.4.64.0612110852010.12500@woody.osdl.org> <20061211180414.GA18833@aepfle.de> <20061211181813.GB18963@aepfle.de> <Pine.LNX.4.64.0612111022140.12500@woody.osdl.org> <20061211182908.GC7256@MAIL.13thfloor.at> <Pine.LNX.4.64.0612111040160.12500@woody.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0612111040160.12500@woody.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Mon, 11 Dec 2006, Herbert Poetzl wrote:
>> cool!
>>
>> should definitely work for all 'known' cases
> 
> No it doesn't.
> 
> Do a
> 
> 	git grep '".*Linux version .*"'
> 
> on the kernel, and see just how CRAP that "get_kernel_version" test is, 
> and has always been.
> 
> But let's hope that CIFS is never compiled into a SLES kernel. Because 
> this isn't worth fixing at that point, and the SLES people should just fix 
> their piece of crap initrd script.
> 
> And next time somebody says "random vmlinux binary" to me, I'll blacklist 
> their email address. You shouldn't do initrd for "random binaries". Just 
> pass the release name somewhere (maybe in the name of the binary, for 
> example, and if the name doesn't have a version in it, tough titties).
> 
> 		Linus
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

I am afraid to report that this second version also fails for me, as you 
point out CIFS can break us if defined.  In fact we used to get away 
with this on my test system due to ordering magic luck, I presume the 
move to __initdata has triggered this.  Much as I agree that this is 
wrong we are still going to break people with this.

Before:

Module list:	sym53c8xx reiserfs
Kernel version:	2.6.19-git12-autokern1 (powerpc)
Kernel image:	/boot/vmlinuz-autobench
Initrd image:	/boot/initrd-autobench.img.new
Shared libs:	lib/ld-2.3.3.so lib/libc.so.6 lib/libselinux.so.1
Cannot determine dependencies of module sym53c8xx. Is modules.dep up to 
date?
Modules:	
none
5735 blocks

After:

Module list:	sym53c8xx reiserfs
Kernel version:	 (powerpc)
Kernel image:	/boot/vmlinuz-autobench
Initrd image:	/boot/initrd-autobench.img.new
No modules found for kernel

-apw
