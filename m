Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284604AbRLIXO3>; Sun, 9 Dec 2001 18:14:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284619AbRLIXOU>; Sun, 9 Dec 2001 18:14:20 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:43026 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S284555AbRLIXOF>; Sun, 9 Dec 2001 18:14:05 -0500
Message-ID: <3C13F021.3080307@zytor.com>
Date: Sun, 09 Dec 2001 15:13:37 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: torvalds@transmeta.com, marcelo@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Linux/i386 boot protocol version 2.03
In-Reply-To: <200112090922.BAA11252@tazenda.transmeta.com>	<m17krww8ky.fsf@frodo.biederman.org> <3C13DD48.3070206@zytor.com> <m11yi4vxvb.fsf@frodo.biederman.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:

> 
>>(3) Contradicts (1) as well as issues with older kernels.  Keep in mind what
>>happens if you violate this limit: the bootloader should be loading the initrd
>>as high as possible
>>
> 
> Hmm.  Bootloaders have had lots of restrictions on getting up high.  
> Plus in some real sense it make sense to pack the two as close
> together as possible.  For 2.5.x and Al Viro's initfs work I'd like
> to do that.
> 
> If you load your ramdisk at the same location every time, after
> a point you have fewer surprises, and potentially a simpler bootloader.
> 


NO, PLEASE PLEASE PLEASE DON'T DO THAT!!!!

Not only would it royally fuck over people with small amounts of RAM, it 
would also really fuck over people who use the Linux boot protocol for 
other purposes, which is getting quite common.


> 
>>, so the only difference is if you get the error message from
>>
>>the boot loader or from the kernel later.  If you're going to export a limit,
>>you better make sure it's right; "8MB except on low memory configurations"
>>doesn't cut it.  It's exactly on those low memory configurations that this limit
>>
>>matters *at all*.
>>
> 
> 8MB is the safe limit.  The only worry some case right now is the
> bootmem allocator with a darn huge bitmap.  It is allocated
> dynamically, and it is extremely hard to predict where that will be
> except in the initial page tables 8MB in size.  If the ugly bitmap
> is allocated elsewhere the kernel can't use it.
> 


"Safe limit" isn't applicable here.  It either works or it doesn't. 
You're breaking systems which it would otherwise work on, which is not 
acceptable.

> So if we are going to fix the fragility please let's handle both ends.
> Then it will be o.k. to put the ramdisk where ever the kernel says
> it is safe.  And we can stop this guessing and breaking game.


You're giving the boot loader options that are really inappropriate. 
All that will do is result in more variance between boot loaders and the 
resulting bugs that will bite some bootloaders and not others.

Allowing unneeded options in protocols is a source of bugs.  You seem to 
think this is a good idea, it's not.

	-hpa


