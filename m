Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261401AbSLACZI>; Sat, 30 Nov 2002 21:25:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261411AbSLACZI>; Sat, 30 Nov 2002 21:25:08 -0500
Received: from ns.indranet.co.nz ([210.54.239.210]:60891 "EHLO
	mail.acheron.indranet.co.nz") by vger.kernel.org with ESMTP
	id <S261401AbSLACZH>; Sat, 30 Nov 2002 21:25:07 -0500
Date: Sun, 01 Dec 2002 15:27:52 +1300
From: Andrew McGregor <andrew@indranet.co.nz>
To: Chris Ison <cisos@bigpond.net.au>, linux-kernel@vger.kernel.org
Subject: Re: kernel space access to user space functions
Message-ID: <23630000.1038709672@localhost.localdomain>
In-Reply-To: <3DE91CBF.295C1491@bigpond.net.au>
References: <3DE91CBF.295C1491@bigpond.net.au>
X-Mailer: Mulberry/3.0.0b9 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--On Sunday, December 01, 2002 06:17:03 +1000 Chris Ison 
<cisos@bigpond.net.au> wrote:

> I realize I asked this previously, but the answer given was not to the
> question I asked.
>
> How can I get a kernel module to call a function within a program?

As others have said, you can't.  Unix in general doesn't work this way.

However, all is not lost.  There are other ways to accomplish what you want.

> The reason being I am creating a software midi driver and already have a
> small program that does what I want the driver to do, problem is all the
> math in the program is floating point.
>
> What I would like to do, is be able to run the program, and have the
> kernel software midi driver call a function within the program to que up
> midi events, and have the program do all the hard work of the wavetable
> synth.

Actually, you want to have the program open a MIDI device, and read MIDI 
from there, then output to an audio device.  ALSA already has the 
facilities to do this, and it should not be hard to write a MIDI 
cross-queue device for OSS if you need that.  For low latency, you're going 
to have to be very careful about the structure of the main loop of this 
thing, and probably use mmap-ed audio under ALSA, or the low-latency DMA 
tricks with OSS.

> This way, any improvements to the software don't have to be translated
> to the driver, and visa versa.
>
> How can I make this happen. And please give an example.

Since there are several softsynths done already, why not look at how they 
did it.

http://www.xdt.com/ar/linux-snd/ is a very big list of linux sound apps. 
There should be examples amongst them.

Andrew
