Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281818AbRLWNRZ>; Sun, 23 Dec 2001 08:17:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281836AbRLWNRO>; Sun, 23 Dec 2001 08:17:14 -0500
Received: from hog.ctrl-c.liu.se ([130.236.252.129]:9742 "HELO
	hog.ctrl-c.liu.se") by vger.kernel.org with SMTP id <S281818AbRLWNRD>;
	Sun, 23 Dec 2001 08:17:03 -0500
To: hpa@zytor.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: AMD SC410 boot problems with recent kernels
Newsgroups: linux.kernel
In-Reply-To: <a04b3k$7sr$1@cesium.transmeta.com>
In-Reply-To: <a03cuj$661$1@cesium.transmeta.com> <Pine.LNX.4.33.0112231009500.10528-100000@callisto.local>
Organization: 
Message-Id: <20011223131658.3944A36FA8@hog.ctrl-c.liu.se>
Date: Sun, 23 Dec 2001 14:16:58 +0100 (CET)
From: wingel@hog.ctrl-c.liu.se (Christer Weinigel)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hpa wrote:
>> If the board is really _broken_ I have no problem with the fact that in
>> the future the manufacturer has either to supply a correct BIOS or a
>> workaround patch has to be used. If it's only uggly that there's no BIOS
>> routine it would IMHO be better to find a way to make it work again. There
>> are fixes for other uggly architectures in the code as well, see the
>> Toshiba Laptop reference. If the board may be PC compatible, Linux should
>> IMHO boot without further changes.

It is an embedded board with a _mostly_ PC compatible CPU, but it
has a few strange bugs/features that have to be worked around. For
example look a the fix for the timer and serial port in:

    http://www.uwsg.iu.edu/hypermail/linux/kernel/0004.2/0667.html

Especially the serial fix is (IMHO) too ugly to live in the standard
kernel.

I'd also suggest that you change the whole gate A20-mess to:

    inb $0xee, %al

this will enable A20 propagation on the SC410 and always works, 
the disadvantage is that it won't work on a normal PC anymore.

>The weird part about your board is that the code clearly *works*, or
>your kernel wouldn't boot at all.  It somehow poisons the system,
>though, and that's utterly bizarre.
>
>I don't think this is debuggable without access to hardware (and maybe
>not even then.)

It has been a few years since I was working on an Elan SC400 board, but
if I remember correctly, the Elan CPU has some configuration registers
located at some I/O ports that on a normal PC are either "safe" or used
for something else.  

Additionally, since there normally isn't a keyboard controller on the 
SC410, accesss to port 0x60 and 0x64 trap into SMI mode, doing I/O to 
those ports could mess up a badly written BIOS.  

My belief is that the SC410 based boards are so strange that one has
to have a custom kernel anyways, so asking why it isn't 100% PC
compatible and trying to fix that is rather pointless.

  /Christer

-- 
"Just how much can I get away with and still go to heaven?"
