Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268429AbRHFNMH>; Mon, 6 Aug 2001 09:12:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268428AbRHFNLw>; Mon, 6 Aug 2001 09:11:52 -0400
Received: from [194.30.80.67] ([194.30.80.67]:59911 "EHLO
	serv_correo.ingecom.net") by vger.kernel.org with ESMTP
	id <S268429AbRHFNLh>; Mon, 6 Aug 2001 09:11:37 -0400
Message-ID: <004401c11e79$6866fae0$66011ec0@frank>
From: "Frank Torres" <frank@ingecom.net>
To: <root@chaos.analogic.com>
Cc: "Russell King" <rmk@arm.linux.org.uk>, <jdow@earthlink.net>,
        "Linux-Kernel" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.3.95.1010806081157.3088A-100000@chaos.analogic.com>
Subject: Re: Duplicate console output to a RS232C and keep keyb where it is
Date: Mon, 6 Aug 2001 15:12:08 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2919.6700
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, 6 Aug 2001, Frank Torres wrote:
>
> >
> > > On Fri, Aug 03, 2001 at 04:01:28PM +0200, Frank Torres wrote:
> > > > > This is not valid. You cannot reasonably have parity and 8 bits.
One
> > > > > of them has to go. Either use 8 bits and no parity or 7 bits with
> > > > > parity.
> > >
> > > All standard 16550 family ports support 8 bits _and_ parity.  Ancient
> > > serial ports did have a restriction, but that restriction is no more.
> > >
>
> The current problem:
> During the console initialization sequence, its speed gets set to
> 38400 baud. This means nothing to a virtual terminal. However, if
> the attached RS-232C termional is also being set to the same speed,
> this could explain the garbage characters.
>
> So I suggest that Frank set his terminal to 38400 baud and see if
> the problems disappear.
>

I tried it out since the beginning Dick, but the display is
hardware-configured to its max. speed (9600) So if I'd like to change the
speed to a lower one I'd have to take a soldering iron and change the hard
way. I could,  but I'm obtaining the right characters at the display after
writing an rc.serial with

    setserial /dev/ttyS2 UART 16550A IRQ 10 spd_cust divisor 12
    stty -F /dev/ttyS2 speed 9600 parenb parodd cs8 cstopb -crtscts

I don't care if I don't see the kernel messages. When rc.sysinit starts
through init it calls rc.serial and configure the port. The problem is that
I can't come to that point.. The moment rc.sysinit shows the message, it
falls into a loop showing the message again and again. I've saved that
output. If you want to, I can send U the file.

I just want to change the output to the serial port, but not the input.

inittab creates another prompt for login, that's not useful for me unless I
can tell it to get the input from keyboard.

I've been trying some other choices. I've read that when Linux starts it
uses the first display available. If it doesn't find one, it uses the first
serial port, thus, ttyS0. But ttyS0 is a RC-232 and I need RC-232Cs to feed
the display. So I swapped the major of ttyS0 and ttyS2, removed the display
card and restarted the system, but when the kernel starts, I can't see
nothing there. So I restored everything.
I'm trying desperate ways. Have U noticed it? :)

Greatfully, frank.

