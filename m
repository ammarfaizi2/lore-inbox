Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264815AbSKZMhO>; Tue, 26 Nov 2002 07:37:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264818AbSKZMhO>; Tue, 26 Nov 2002 07:37:14 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:738 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S264815AbSKZMhM>; Tue, 26 Nov 2002 07:37:12 -0500
Date: Tue, 26 Nov 2002 13:44:25 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Dennis Grant <trog@wincom.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Identifying/activating faster ATAxx modes (WAS kernel config tale of woe)
Message-ID: <20021126124424.GJ24796@fs.tum.de>
References: <3de2eee3.16fd.0@wincom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3de2eee3.16fd.0@wincom.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 25, 2002 at 10:31:12PM -0500, Dennis Grant wrote:

>...
> VP_IDE: chipset revision 6
> VP_IDE: not 100% native mode: will probe irqs later
> VP_IDE: Unknown VIA SouthBridge, contact Vojtech Pavlik <vojtech@ucw.cz>
>...      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This is the information that explains it. As Christian already mentioned
your motherboard has a VIA KT8235 Southbridge which wasn't supported
until 2.4.20-rc2 (second Release Candidate for 2.4.20).

>...
> Quick philosphical point - it was expressed to me that "users shouldn't be compiling
> kernels, that's the distro manager's job"
> 
> I could not POSSIBLY disagree more. What is Linux if not putting more power
> in the hands of the people who actually use the system? Users should ABSOLUTELY
> be compiling kernels, if they want to or need to. The trick is to pass on enough
> information so as to give the guy on the pointy end of the compiler as best
> a chance of success as can be done.

IMHO we should distinguish two different kinds of users (simplified,
but I hope you get the difference) that often get mixed:

1. The novice user who wants to use applications
This user wants to install Linux with as few clicks as possible. He
doesn't know what a kernel is and he doesn't want to know. All he wants
is a stable OS that runs OpenOffice and Netscape.

2. The more experienced user
There are good reasons (e.g. kernel patches) why a system administrator
might want to compile his own kernel. Or a computer science student 
wants to learn a bit more about the kernel he's using.


For people like you in the second category it should always be possible
to compile a custom kernel. A user in the first category should whenever
possible never need to compile his own kernel.


> Is asking for a dmesg that states "this is an ATAxxx drive, and your interfacer
> is using ATAyyy" really such a horrible thing to ask?

No it isn't horrible. The problem I can imagine is that it's possible
that a startup script on a user's computer (e.g. provided by the
distribution) uses hdparm or a similar program to manipulate the IDE
devices. The information provided by "dmesg" would then not reflect the
state of the system after bootup is completed.

> In any case, I will provide any other info anybody might wish on my system,
> and thanks to those people who are offering help. It is appreciated.

The information whether DMA is used is available via "hdparm -v", I'm
sure it will show that "using_dma" is off on your computer.

There are two solutions:
- safe solution:
  Apply the 2.4.20-rc3 patch [1] on top of 2.4.19 and do a
    cp .config /tmp  # because "make mrproper" will delete the .config
    make mrproper
    cp /tmp/.config .
    make oldconfig dep bzImage modules
- more risky solution:
  enable DMA with "hdparm -d1"

> DG

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

