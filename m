Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280804AbRKTApW>; Mon, 19 Nov 2001 19:45:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280805AbRKTApM>; Mon, 19 Nov 2001 19:45:12 -0500
Received: from cx662584-c.okcnc1.ok.home.com ([65.13.170.37]:15483 "EHLO
	cx662584-c.okcnc1.ok.home.com") by vger.kernel.org with ESMTP
	id <S280804AbRKTApE>; Mon, 19 Nov 2001 19:45:04 -0500
Message-ID: <3BF9A7A8.7050902@rueb.com>
Date: Mon, 19 Nov 2001 18:45:28 -0600
From: Steve Bergman <steve@rueb.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010914
X-Accept-Language: en-us
MIME-Version: 1.0
To: Grzegorz Paszka <Grzegor@Paszka.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 1.5 GB memory problem with 2.4.x
In-Reply-To: <20011119012515.A27753@pik-net.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grzegorz Paszka wrote:

>Hi.
>
>I've RH7.1 with updates and kernel 2.4.14 from tgz, root filesystem is on
>software raid1.
>Hardware: 1.5 GB RAM, asus cuv4x-e, via chipset (host bridge: VT82C693A/694x).
>Kernel is compiled with support for more then 1GB memory. (4GB).
>
>I've tested this hardware with memtest86 (ver. 2.8) and everything looks good.
>
>But linux is unstable. Mysql reports corrupted databases. I get crc
>errors when I try ungzip zipped files. Programs dump cores from time to
>time. And my linux box hanged one time.
>
>I've tryed 2.4.7 kernel with no support for more then 1GB memory (linux see
>about 900MB memory) but problems still appear.
>
>Finally I've only 512MB RAM and linux looks stable with 2.4.7 and 2.4.14.
>
>What I should do to have stable linux with 1.5GB RAM ?
>
>Should I try to redhat kernel-2.4.9-enterprise ? (My / is on raid1 so I don't
>know is it possible)
>
>I'm not subscribed on this list.
>
Well, I have a similar problem.  I'm appending a post that I sent to the 
"Dri-users" list last week.




-------------------

Appended message:

Hi,

I have just upped my RAM from 512MB to 1.5GB and am having problems. 
When I run any 3D accellerated app (e.g. gears) the machine locks hard. 
(Can't ping it)  I have checked the memory thoroughly using memtest86 
and it checks OK.  I have narrowed the problem down to having more than 
1024MB physically in the machine.  If I have only 1024MB installed, 
everything is fine.  If I have 1280MB or 1536MB installed, I have this 
problem.  Note that "boot:  linux mem=1024M" does not help. Nor does 
booting a kernel compiled without high memory support.

I suspect that X is using a memory address just above 0x40000000 (1GB) 
for something and now there is real memory at that address.  I notice in 
the log that something called SAREA gets mapped to 0x40016000 but I 
don't know what that is.

Changing the AGP aperture seems to help some.  Changing it from the 
default 64M to 8M allows "gears" to work and I even get an incompletely 
rendered frame in the game "Rune" before it locks.


Here is my setup:

Epox 8KTA2 MB (KT133 chipset?)
1200MHZ Athlon (sdr)
1536MB sdram pc-133
Radeon QD
Xfree86 4.1
Kernel 2.4.14



Any suggestions appreciated.




