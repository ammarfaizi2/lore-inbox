Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269940AbRHELFo>; Sun, 5 Aug 2001 07:05:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269941AbRHELFe>; Sun, 5 Aug 2001 07:05:34 -0400
Received: from nathan.polyware.nl ([193.67.144.241]:53775 "EHLO
	nathan.polyware.nl") by vger.kernel.org with ESMTP
	id <S269940AbRHELFO>; Sun, 5 Aug 2001 07:05:14 -0400
Date: Sun, 5 Aug 2001 13:04:59 +0200
From: Pauline Middelink <middelink@polyware.nl>
To: Constantine Gavrilov <const-g@optibase.com>
Cc: middelink@polyware.nl, linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Use kernel module instead Big Physical Area patch
Message-ID: <20010805130459.A25594@polyware.nl>
Mail-Followup-To: Pauline Middelink <middelin@polyware.nl>,
	Constantine Gavrilov <const-g@optibase.com>, middelink@polyware.nl,
	linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3B6D2539.3060906@optibase.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B6D2539.3060906@optibase.com>; from const-g@optibase.com on Sun, Aug 05, 2001 at 01:51:37PM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 05 Aug 2001 around 13:51:37 +0300, Constantine Gavrilov wrote:
> Hi,
> 
> I wrote a small kernel module that defines and exports bfree() and 
> bmalloc() functions. The idea is to use this kernel module as a 
> replacement for big physcial area kernel patch.

Ahum, but this is _not_ a kernel replacement for the bigphysarea
patch. If also requires the patch to be integrated in the main-stream
kernel. Following your reasoning you could just as well get Linus
to accept the bigphysarea patch and voila, all the problems you
describe are gone.

> For example, zoran kernel driver relies on the big physical area API for 
> v4l (used for video-in-a-window) to work. While the driver will compile 
> and load with a non-patched kernel, v4l will not work reliably without 
> big physical area support since the chip needs about 2megs of contiguous 
> memory to display in a window. This means one really has to use a 
> patched kernel.

Check, or load the zoran module very early in the boot process.

> This module removes this requirement and allows v4l to work reliably 
                                                  ^^^ zoran driver

> with a non-patched kernel. The idea is to load the module from initrd or 
> right after boot. I have used __get_free_pages() and mem_map_reserve() 
> to pre-allocate the memory.

Wasn't it easier to just take bigphysarea and made a module out
of it? It seems you already took a lot of the code, so why not
take the last step?

> I have left the user-mode code that I used to debug allocation and 
> garbage collection.  Compiled into a user-space program, the code will 
> allocate/free random chunks from a pre-allocated space and print out the 
> used list.

/proc/bigphysarea?

> Comments?
> 
> Questions:
> 1) On  a 256 MB machine, I was able to pre-allocate 512 pages using 
> __get_free_pages(...,get_order(size)). It is enough for one card, but 
> not for more. Any ideas on how to pre-allocate more?
> 2) __get_free_pages(...,get_order(size)) can be used to pre-allocate 2^n 
> contiguous pages (2,4,16,...512, ...., 1024). Can I use something else 
> from a kernel module to request a number that is not  2^n  (say 750)?

Congrats. Now you know why I used bootmem, which as a bad sideeffect
prevents one to make bigphysarea a module :(

On the last question: no. get_free_pages() works with _pages_. kmalloc()
works with sizes. (but you know the problems with that one.)

> /***************************************************************************
>                           memreserve.c  -  description
>                              -------------------
>     begin                : Tue Jul 31 2001
>     copyright            : (C) 2001 by Optibase Ltd

Eh, if you insist of using this much of the bigphysarea ideas,
you could at least give us some credit/mention?

>     email                : linux@optibase.com

    Met vriendelijke groet,
        Pauline Middelink
-- 
GPG Key fingerprint = 2D5B 87A7 DDA6 0378 5DEA  BD3B 9A50 B416 E2D0 C3C2
For more details look at my website http://www.polyware.nl/~middelink
