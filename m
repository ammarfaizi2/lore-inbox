Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263475AbUE3Mkn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263475AbUE3Mkn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 May 2004 08:40:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263484AbUE3Mkn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 May 2004 08:40:43 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:29163 "EHLO
	atlas.informatik.uni-freiburg.de") by vger.kernel.org with ESMTP
	id S263475AbUE3Mkd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 May 2004 08:40:33 -0400
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Giuseppe Bilotta <bilotta78@hotpop.com>, linux-kernel@vger.kernel.org,
       Tuukka Toivonen <tuukkat@ee.oulu.fi>
Subject: Re: keyboard problem with 2.6.6
References: <MPG.1b2111558bc2d299896a2@news.gmane.org>
	<20040525201616.GE6512@gucio>
	<xb7hdu3fwsj.fsf@savona.informatik.uni-freiburg.de>
	<xb7aczscv0q.fsf@savona.informatik.uni-freiburg.de>
	<20040529131233.GA6185@ucw.cz>
	<xb7y8nab65d.fsf@savona.informatik.uni-freiburg.de>
	<20040530101914.GA1226@ucw.cz>
	<xb765aeb1i3.fsf@savona.informatik.uni-freiburg.de>
	<20040530121606.GA1496@ucw.cz>
From: Sau Dan Lee <danlee@informatik.uni-freiburg.de>
Date: 30 May 2004 14:40:31 +0200
In-Reply-To: <20040530121606.GA1496@ucw.cz>
Message-ID: <xb7ekp29jgg.fsf@savona.informatik.uni-freiburg.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=big5
Content-Transfer-Encoding: 8BIT
Organization: Universitaet Freiburg, Institut fuer Informatik
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Vojtech" == Vojtech Pavlik <vojtech@suse.cz> writes:

    >> Where it is now possible to move it out of kernel space WITHOUT
    >> performance problems, why not move it out?

    Vojtech> Because it just works.

    Vojtech> 1) Upgrading the kernel will make your keyboard stop
    Vojtech> working. Noone has installed your userspace daemons on
    Vojtech> the system.

Many people has already fallen  into this trap with YOUR input system:
they didn't know they had  to enable the 'i8042' and 'atkbd' features,
or they did  but made them modules and didn't have  any clue to insmod
them in the bootup scripts.

Most package  maintainers put dependencies  in their 2.6  kernel image
packages to force the user to also install module-init-tools.  I can't
see why that couldn't be done for userspace daemons.


    Vojtech> 2) The keyboard (and other input devices, so that you
    Vojtech> don't complain about limiting this to the keyboard)
    Vojtech> should work without requiring userspace to be running.

Is a network interface an input device?  Or do you just mean HID?

USB devices  (including USB keyboards  and mice) require  hot-plug (or
similar mechanisms) to load  the corresponding modules before they can
work.   Both  /sbin/hotplug  and   /sbin/modprobe  on  my  system  are
userspace programs.


    Vojtech> And, it works just fine in the kernel, doesn't take up
    Vojtech> any more space than as a program, so why to move it out?

To leave more *swappable* RAM to userspace.



    Vojtech> This is getting really annoying. Let me rephrase it
    Vojtech> again:

    Vojtech> I don't have a keyboard on every of my systems. But when
    Vojtech> I have it and I have the driver running, I expect it to
    Vojtech> work.

So, you  need to have a  DRIVER running.  How does  putting the driver
into kernel space make it different (for this argument)?


    Vojtech> Regardless of what happened to the system. Regardless of
    Vojtech> userspace programs dying. Just work.

Userspace  programs can  die.  Kernelspace  code can  Oops.   Which is
easier to recover?   What happens when getty dies  and how to recover?
What happens  when some kernel code  oops?  Do you lose  data (held in
RAM by other apps) in these cases?


    Vojtech> Yes. The system doesn't need the keyboard drivers to
    Vojtech> function. The user does.

I don't, when I'm accessing via means other than a keyboard.


    >> Are you aware of the i8042_shutdown bug, which I discovered and
    >> fixed?  How could I have found such a bug, if "keyboard has to
    >> always work"?

    Vojtech> Thanks for the fix.

I've been  reporting this  bug for 2.6.6  and 2.6.7-rc1, and  it still
hasn't been included in 2.6.7-rc2.  What's happening?  Should I report
it again for 2.6.7-rc2?


    >> And how about mouse drivers?  They used to be in userland (gpm,
    >> XFree86 3.x -- 4.x, etc.)  Why move it into the kernel?

    Vojtech> You wanted to use a mouse click to dump registers?

GPM can be  configured to do it, given that the  SysRq feature can now
be triggered from userland.


    Vojtech> I'd have an interesting idea for you, though: If you want
    Vojtech> moving stuff to userspace, move the whole console
    Vojtech> there. The font handling, the keymap handling, colors,
    Vojtech> resolution, all that.

    Vojtech> Just a simple program that uses the evdev interface to
    Vojtech> get the keyboard data for input, the fbdev interface for
    Vojtech> output, and the pty interface to communicate with the
    Vojtech> system.

I've  never  used fbdev.   I  don't  plan to  use  it  on any  PC-type
machines.   It's  so  slow.   I  prefer  the  (S)VGA  text  modes  and
accelerated X11 drivers.



    Vojtech> Now *that* would be a great project moving stuff to
    Vojtech> userspace.

But that restricts to fbdev.


    Vojtech> It's in userspace. It's not running in the kernel
    Vojtech> space. It's subject to the scheduler and swapping. It
    Vojtech> doesn't react to interrupts immediately.  I think that's
    Vojtech> quite clear.

Swappable is one of the features that I want.  I often use my machines
via X11  from one desktop computer.   If the keyboard  driver has been
dormant for  a long time, I'd  prefer it to  be swapped out, so  as to
free up some RAM for other programs.

If you don't want it to  be swappable, you can add some mlock() calls.
You don't have this *choice* for the kernel-space drivers.


    Vojtech> Of course it's possible. There is not much that'd be
    Vojtech> impossible in operating systems. It's not convenient,
    Vojtech> that's all.

Now, it becomes a convenience issue, rather than a necessity issue.



    Vojtech> It IS an option, not a requirement. But I WANT THE
    Vojtech> OPTION. If the keyboard handling is in userspace, I don't
    Vojtech> have the option of pressing a key combination and getting
    Vojtech> a register dump,

Why not?


    Vojtech> because the daemon doing the processing may be dead
    Vojtech> already.

"may be".  So, it's not always.


    >>  I don't understand this.  The slower a device is, the lesser
    >> is the need to handle the incoming data in kernel space.  I
    >> can't understand how 1200baud is fast enough to cause
    >> significant delays.  Maybe, you can enlighten me on that?

    >> Yeah.  At what rate are they arriving?  1200baud.  Let's say
    >> that' 9600bps.  So, 1200 bytes per second.  1 byte in every 833
    >> microseconds.  How come a processor at 33MHz (0.030
    >> microseconds per clock cycle) cannot cope with that?  Assuming
    >> that the processing of the data plus context switching plus
    >> other overhead taks 1000 microseconds, that still shouldn't be
    >> felt by a HUMAN user.  Who has a reaction time of less than 100
    >> _milli_seconds?

    Vojtech> Can you say swap?

Can you say mlock()?



    Vojtech> The keyboard and mouse drivers don't handle
    Vojtech> keymaps. Those are handled in the console. The
    Vojtech> keyboard/mouse drivers are not necessarily _time_
    Vojtech> critical, but they're critical. When your keyboard stops
    Vojtech> working, this often means your system is dead. (Think a
    Vojtech> laptop on an airplane.)

I've used  my laptop  in an airplane,  and it works  without problems.
What would make the keyboard stop working in an airplane?



-- 
Sau Dan LEE                     §õ¦u´°(Big5)                    ~{@nJX6X~}(HZ) 

E-mail: danlee@informatik.uni-freiburg.de
Home page: http://www.informatik.uni-freiburg.de/~danlee

