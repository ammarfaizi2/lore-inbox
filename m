Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313569AbSDZBHD>; Thu, 25 Apr 2002 21:07:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313589AbSDZBHD>; Thu, 25 Apr 2002 21:07:03 -0400
Received: from slide.SoftHome.net ([66.54.152.30]:40865 "EHLO softhome.net")
	by vger.kernel.org with ESMTP id <S313569AbSDZBHC>;
	Thu, 25 Apr 2002 21:07:02 -0400
In-Reply-To: <courier.3CC89816.00006EFA@softhome.net>
            <20020426022139.N14343@suse.de>
From: dmacbanay@softhome.net
To: Dave Jones <davej@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel 2.5.10 problems
Date: Thu, 25 Apr 2002 19:07:02 -0600
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [64.251.165.205]
Message-ID: <courier.3CC8A836.00000E67@softhome.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones writes: 

> On Thu, Apr 25, 2002 at 05:58:14PM -0600, dmacbanay@softhome.net wrote: 
> 
>  > 4.  Starting with kernel 2.5.6 (kernels 2.5.5 through 2.5.6-pre3 work)  the 
>  > KDE program krecord closes right after it starts.  
> 
> Interesting. last few lines of strace output may show up what's going on.
> Can you do a before/after strace on a working & non-working kernel? 
> 
> -- 
> | Dave Jones.        http://www.codemonkey.org.uk
> | SuSE Labs

Here's what shows in kernel 2.5.10.  I'm using a Soundblaster PCI 512 and I 
have ALSA support for it installed. 

gettimeofday({1019717263, 731947}, NULL) = 0
select(8, [3 4 6 7], NULL, NULL, {0, 0}) = 2 (in [6 7], left {0, 0})
read(7, 0x809fa74, 8192)                = -1 EBADFD (File descriptor in bad 
state)
dup(2)                                  = 8
fcntl64(8, F_GETFL)                     = 0x2 (flags O_RDWR)
fstat64(8, {st_mode=S_IFCHR|0620, st_rdev=makedev(3, 1), ...}) = 0
ioctl(8, SNDCTL_TMR_TIMEBASE, {B38400 opost isig icanon echo ...}) = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) 
= 0x40014000
_llseek(8, 0, 0xbffff5e4, SEEK_CUR)     = -1 ESPIPE (Illegal seek)
write(8, "read sound: File descriptor in b"..., 41read sound: File 
descriptor in bad state
) = 41
close(8)                                = 0
munmap(0x40014000, 4096)                = 0
_exit(1)                                = ? 

Here's what shows in kernel 2.5.6-pre3 until I pressed control-C. 

gettimeofday({1019718466, 876979}, NULL) = 0
select(8, [3 4 6 7], NULL, NULL, {10, 631024}) = 1 (in [7], left {10, 
600000})
read(7, "\377\377\1\0\377\377\2\0\2\0\376\377\376\377\0\0\375\377"..., 8192) 
= 8192
gettimeofday({1019718466, 922638}, NULL) = 0
ioctl(3, 0x541b, [0])                   = 0
gettimeofday({1019718466, 923415}, NULL) = 0
select(8, [3 4 6 7], NULL, NULL, {10, 584588}) = 1 (in [7], left {10, 
540000})
read(7, "\0\0\377\377\0\0\6\0\2\0\377\377\1\0\3\0\376\377\375\377"..., 8192) 
= 8192
gettimeofday({1019718466, 969320}, NULL) = 0
ioctl(3, 0x541b, [0])                   = 0
gettimeofday({1019718466, 970109}, NULL) = 0
select(8, [3 4 6 7], NULL, NULL, {10, 537894} <unfinished ...> 

David Macbanay 
