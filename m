Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261512AbSJZUkf>; Sat, 26 Oct 2002 16:40:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261514AbSJZUkf>; Sat, 26 Oct 2002 16:40:35 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:32005 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261512AbSJZUke>; Sat, 26 Oct 2002 16:40:34 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC] [PATCH] 2.5.44 bootloader fix
Date: 26 Oct 2002 13:46:42 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <apeuvi$t5k$1@cesium.transmeta.com>
References: <m1pttxlebr.fsf@frodo.biederman.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <m1pttxlebr.fsf@frodo.biederman.org>
By author:    ebiederm@xmission.com (Eric W. Biederman)
In newsgroup: linux.dev.kernel
> 
> What I am proposing is an interface change.  The only known bootloader
> this does not fix is gujin and the fix of loading segments earlier is
> trivial, and fully backwards compatible.  The advantage of this patch
> is that no future changes to the kernel's gdt will affect bootloaders.
> 

Please detail how the interface changes.  It is not at all clear from
the code.

> @@ -101,7 +96,8 @@
>  	popl %eax	# hcount
>  	movl $0x100000,%edi
>  	cli		# make sure we don't get interrupted
> -	ljmp $(__KERNEL_CS), $0x1000 # and jump to the move routine
> +	movl $0x1000, %ebp
> +	jmpl *%ebp	# and jump to the move routine
>  
>  /*
>   * Routine (template) for moving the decompressed kernel in place,

Why are you avoiding to set __SETUP_CS here?

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
