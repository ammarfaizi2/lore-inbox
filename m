Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317454AbSHHLZD>; Thu, 8 Aug 2002 07:25:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317458AbSHHLZD>; Thu, 8 Aug 2002 07:25:03 -0400
Received: from [195.63.194.11] ([195.63.194.11]:39948 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S317454AbSHHLZC>; Thu, 8 Aug 2002 07:25:02 -0400
Message-ID: <3D525489.3050209@evision.ag>
Date: Thu, 08 Aug 2002 13:22:49 +0200
From: Marcin Dalecki <dalecki@evision.ag>
Reply-To: martin@dalecki.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en, pl, ru
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: martin@dalecki.de, Ingo Molnar <mingo@elte.hu>,
       "Adam J. Richter" <adam@yggdrasil.com>, Andries.Brouwer@cwi.nl,
       johninsd@san.rr.com, linux-kernel@vger.kernel.org
Subject: Re: [bug, 2.5.29, IDE] partition table corruption?
References: <Pine.LNX.4.44.0208081129420.3210-100000@localhost.localdomain>	 <3D523B25.5080105@evision.ag> <1028809830.28883.13.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

U¿ytkownik Alan Cox napisa³:
> On Thu, 2002-08-08 at 10:34, Marcin Dalecki wrote:
> 
>>>  [mingo@a mingo]$ ls -l /sbin/lilo
>>>  -rwxr-xr-x    1 root     root        59324 Aug 23  2000 /sbin/lilo
>>
>>Yes sure. It is simply a very old bug in lilo, which the kernel worked
>>around and did fight against in a diallectic way.
> 
> 
> Its not a bug in lilo. Its a bug in the new kernel. Breaking backward
> compatibility arbitarily is bad. The kernel needs to know geometry
> anyway for the folks who have force ide translation

1. Requiring the kernel to read the partition table information is a
BUG.

2. Falling back on the values which are used by the application 
afterwards is a BUG. (BIOS IRQ after all)

3. Not detecting LBA disk access is required by checking Cylinder value
to emulate BIOS behaviour is a BUG.

4. Asking the kernel to kindly avoid 100% partition table scanning and
*guessing* some *heuristic* values which fail frequently enough is a 
BUG. (Take a look at the jumps and hops in the function in question if
you don't think it is guessing. I recommend the switch in esp.)

5. Relying on the kernel for the translation "trick" himself (if
anything) is a BUG.

6. It's after all no more inconvenient then renaming well for example
the USB host controller module.

7. It is *not* breaking backward compatibility. After the lilo 
configuration fix the old  kernel boots fine as well.

Not reading confusing lilo docs which should better say what to do is a
BUG.

BTW.> Silly RH beta fdisk did tell me bogous things about the
geometry of disks I did install under plain RH 7.3...

BTW.> And finally what about dd if=/dev/hda of=/dev/hdb?

