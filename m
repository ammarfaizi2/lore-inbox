Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315415AbSEBUqd>; Thu, 2 May 2002 16:46:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315416AbSEBUqc>; Thu, 2 May 2002 16:46:32 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:34822 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S315415AbSEBUqa>; Thu, 2 May 2002 16:46:30 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 2.5.12] x86 Boot enhancements, boot protocol 2.04 9/11
Date: 2 May 2002 13:45:28 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <aas8h8$qrh$1@cesium.transmeta.com>
In-Reply-To: <m11ycuzk4q.fsf@frodo.biederman.org> <m1adriy4im.fsf_-_@frodo.biederman.org> <m16626y4et.fsf_-_@frodo.biederman.org> <m11ycuy48d.fsf_-_@frodo.biederman.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <m11ycuy48d.fsf_-_@frodo.biederman.org>
By author:    ebiederm@xmission.com (Eric W. Biederman)
In newsgroup: linux.dev.kernel
>  
>  For backwards compatibility, if the setup_sects field contains 0, the
>  real value is 4.
> @@ -180,8 +199,14 @@
>    loadflags, heap_end_ptr:
>  	If the protocol version is 2.01 or higher, enter the
>  	offset limit of the setup heap into heap_end_ptr and set the
> -	0x80 bit (CAN_USE_HEAP) of loadflags.  heap_end_ptr appears to
> -	be relative to the start of setup (offset 0x0200).
> +	0x80 bit (CAN_USE_HEAP) of loadflags.  heap_end_ptr is
> +	relative to the start of setup (offset 0x0200).
> +
> +	If the protocol version is 2.04 or higher set the 0x40 bit
> +	(STAY_PUT).  This explictly tells the real mode code that you
> +	don't expect it to relocate itself to 0x90000.  No earlier
> +	protocols versions look at this bit so it is safe to set it
> +	unconditionally.
>  

Hang on here... this is bullsh*t.  The real-mode code should not be
relocated if the cmd_line_ptr field is set.  If you don't want to pass
a command line, set cmd_line_ptr to an empty string "".  There should
be no need for an additional protocol here; in fact, having two
protocols only means the boot loader has to do both, in effect, so
what's the point?!?

> +	With boot protocol 2.04 and above the initrd can be loaded
> +	as low as kern_base + kern_memsz.

It's still a bad idea, for several reasons:

a) Adds to the number of configurations that have to be tested, for
   absolutely no good reason.

b) It may be OK for the Linux kernel proper, but it is *NOT*
   acceptable for some other programs that use the Linux boot
   protocol.

	-hpa

 
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
