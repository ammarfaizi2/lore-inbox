Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262036AbSJEE7I>; Sat, 5 Oct 2002 00:59:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262041AbSJEE7I>; Sat, 5 Oct 2002 00:59:08 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:24580 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S262036AbSJEE7H>;
	Sat, 5 Oct 2002 00:59:07 -0400
Message-ID: <3D9E72C8.1070203@pobox.com>
Date: Sat, 05 Oct 2002 01:04:08 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Adrian Bunk <bunk@fs.tum.de>, linux-kernel@vger.kernel.org,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: Why does x86_64 support a SuSE-specific ioctl?
References: <Pine.NEB.4.44.0210041654570.11119-100000@mimas.fachschaften.tu-muenchen.de.suse.lists.linux.kernel> <p73adltqz9g.fsf@oldwotan.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> Adrian Bunk <bunk@fs.tum.de> writes:
> 
>>TIOCGDEV is (as the comment above indicates) in neither 2.4.20-pre9 nor in
>>2.5.40 and I'm wondering why the x86_64 kernel supports a SuSE-specific
>>i386 ioctl?
> 
> 
> Why not? 
> 
> I resubmitted the TIOCGDEV patch to Marcelo now, which implements it 
> for the console device.
[...]
> diff -urN linux-2.4.18.tmp/include/asm-arm/ioctls.h linux-2.4.18.SuSE/include/asm-arm/ioctls.h
> --- linux-2.4.18.tmp/include/asm-arm/ioctls.h	Fri Feb  9 01:32:44 2001
> +++ linux-2.4.18.SuSE/include/asm-arm/ioctls.h	Sat May  4 11:37:56 2002
> @@ -49,6 +49,7 @@
>  #define TIOCGSID	0x5429  /* Return the session ID of FD */
>  #define TIOCGPTN	_IOR('T',0x30, unsigned int) /* Get Pty Number (of pty-mux device) */
>  #define TIOCSPTLCK	_IOW('T',0x31, int)  /* Lock/unlock Pty */
> +#define TIOCGDEV	_IOR('T',0x32, unsigned int) /* Get real dev no below /dev/console */
>  
>  #define FIONCLEX	0x5450  /* these numbers need to be adjusted. */
>  #define FIOCLEX		0x5451


"Why not?" is not a very good argument for merging code into the kernel :)

It seems like a good idea to -not- add this ioctl, because
* if 2.4.x and 2.5.x don't have it, there obviously isn't a huge need 
for it, so why add one more ioctl we will have to maintain binary 
compatibility for
* "real dev" doesn't necessary have meaning in all contexts, IIRC
* viro might have a cow at the use of kdev_t_to_nr...  is that required 
for compatibility with some existing apps?  It seems like you want to 
_decompose_ a number into major/minor, to be an interface that 
withstands the test of time

