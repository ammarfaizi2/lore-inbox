Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312385AbSDCTfo>; Wed, 3 Apr 2002 14:35:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312381AbSDCTfh>; Wed, 3 Apr 2002 14:35:37 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:17675 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S312385AbSDCTe5>; Wed, 3 Apr 2002 14:34:57 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] x86 Boot enhancements, boot protocol 2.04 7/9
Date: 3 Apr 2002 11:34:36 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a8flgc$ms2$1@cesium.transmeta.com>
In-Reply-To: <m1ofh0spik.fsf@frodo.biederman.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <m1ofh0spik.fsf@frodo.biederman.org>
By author:    ebiederm@xmission.com (Eric W. Biederman)
In newsgroup: linux.dev.kernel
> 
> +0240/4	2.04+	real_base	0x90000
> +0244/4	2.04+	real_memsz	Memory used @ 0x90000
> +0248/4	2.04+	real_filesz	Precomputed data for @ 0x90000
> 
[...]
> +
> +  low_base, low_memsz, low_filesz, 
> +  real_base, real_memsz, real_filesz, 
> +  high_base, high_memsz, high_filesz:
> +	Up to this point building a zImage or a bzImage has been a very lossy
> +	process.  The introduction of these six variables attempts to
> +	rectify that situation.  They document exactly which pieces
> +	of memory, the kernel uses during the boot process, and they
> +	indicate exactly how large the various data segments of the
> +	kernel are.  It is now possible to create a lossless
> +	transformation to and from a static ELF executable.
> +
> +	For a bzImage the low program segment describes the memory
> +	from 4KB - 572KB the kernel decompressors uses as a temorary
> +	buffer.  For a zImage the low program segment describes the
> +	memory from 4KB - 572KB where the compressed kernel is loaded. 
> +
> +	For a bzImage the high program segment describes the memory
> +	from 1MB on where the compressed kernel is loaded, where
> +	decompression takes place, where the kernel initially runs,
> +	and where the kernels bss segment is.  For a zImage the high
> +	program segment describes the memory from 1MB on where the
> +	kernel is decompressed to, where the kernel initial runs, and
> +	where the kernels bss segment is located.
> +
> +	The real program segment describes the memory from 572KB
> +	(0x90000) to 640KB (0xa0000) that the real mode kernel uses.
> +	This region may be moved lower in memory if the BIOS has
> +	reserved region for some other purpose.  When doing so
> +	the following considerations should be applied.
> +	
> +		For a zImage you may move the real mode kernel now
> +		lower than low_base + low_memsz.
> +
> +		For a bzImage if you move real_base below (low_base +
> +		low_memsz) the following are the values of the other
> +		variables.
> +			low_memsz -= (low_base + low_memsz) - real_base
> +			high_memsz += (low_base + low_memsz) - real_base
> +		
> +	
> +	With this information it becomes safe to to statically
> +	relocate the real mode kernel as well as dynamically relocate
> +	it.  real_base should not be > 0x90000.
> +
>  

Whereas this is technically correct, it is dangerously misleading.
Please rephrase this to remove any unnecessary references to the
legacy address 0x90000.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
