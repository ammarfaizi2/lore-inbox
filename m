Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284484AbRLIVwG>; Sun, 9 Dec 2001 16:52:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284488AbRLIVvz>; Sun, 9 Dec 2001 16:51:55 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:42768 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S284472AbRLIVvr>; Sun, 9 Dec 2001 16:51:47 -0500
Message-ID: <3C13DD48.3070206@zytor.com>
Date: Sun, 09 Dec 2001 13:53:12 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Transmeta Corporation
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:0.9.3) Gecko/20010801
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: torvalds@transmeta.com, marcelo@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Linux/i386 boot protocol version 2.03
In-Reply-To: <200112090922.BAA11252@tazenda.transmeta.com> <m17krww8ky.fsf@frodo.biederman.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
> 
> A couple of notes:
> 1) The minimum safe ramdisk address is 8MB (since 2.4.10).  On low
>    mem machines you can get away with placing a ramdisk lower.  But we
>    don't do any checking in our initial 8MB memory map.
> 2) If we use units of kilobytes instead of bytes for this we don't
>    loose any precision and gain the ability to put a ramdisk in high
>    memory without bumping the protocol version.
> 3) If we are going to export the maximum address we should also export
>    the minimum address.
> 

(2) I guess I'm not so concerned with the ramdisk in highmem since it is 
extrememly unlikely any boot loader will be able to take advantage of 
that.  It could be an issue for x86-64, I guess.

(3) Contradicts (1) as well as issues with older kernels.  Keep in mind 
what happens if you violate this limit: the bootloader should be loading 
the initrd as high as possible, so the only difference is if you get the 
error message from the boot loader or from the kernel later.  If you're 
going to export a limit, you better make sure it's right; "8MB except on 
low memory configurations" doesn't cut it.  It's exactly on those low 
memory configurations that this limit matters *at all*.

	-hpa



