Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263185AbUE3MPy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263185AbUE3MPy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 May 2004 08:15:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263204AbUE3MPy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 May 2004 08:15:54 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:55168 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S263185AbUE3MPq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 May 2004 08:15:46 -0400
Date: Sun, 30 May 2004 14:16:06 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Sau Dan Lee <danlee@informatik.uni-freiburg.de>
Cc: Giuseppe Bilotta <bilotta78@hotpop.com>, linux-kernel@vger.kernel.org,
       Tuukka Toivonen <tuukkat@ee.oulu.fi>
Subject: Re: keyboard problem with 2.6.6
Message-ID: <20040530121606.GA1496@ucw.cz>
References: <MPG.1b2111558bc2d299896a2@news.gmane.org> <20040525201616.GE6512@gucio> <xb7hdu3fwsj.fsf@savona.informatik.uni-freiburg.de> <xb7aczscv0q.fsf@savona.informatik.uni-freiburg.de> <20040529131233.GA6185@ucw.cz> <xb7y8nab65d.fsf@savona.informatik.uni-freiburg.de> <20040530101914.GA1226@ucw.cz> <xb765aeb1i3.fsf@savona.informatik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xb765aeb1i3.fsf@savona.informatik.uni-freiburg.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 30, 2004 at 01:25:24PM +0200, Sau Dan Lee wrote:

>     Vojtech> Well, keyboard support was always in the kernel
> 
> Once in kernel space, forever in kernel space?  What's the logic?
> 
> Where  it is  now possible  to  move it  out of  kernel space  WITHOUT
> performance problems, why not move it out?

Because it just works.

1) Upgrading the kernel will make your keyboard stop working. Noone has
installed your userspace daemons on the system.

2) The keyboard (and other input devices, so that you don't complain
about limiting this to the keyboard) should work without requiring
userspace to be running.

And, it works just fine in the kernel, doesn't take up any more space
than as a program, so why to move it out?

>     Vojtech>  - you need it there, because you need the keyboard
>     Vojtech> always to work
> 
> Then, why make 'i8042' and  'atkbd' modules?  I still remember reading
> web pages  that early  pioneers who migrated  from 2.4  to 2.6.0-test*
> encountered a problem: they didn't compile-in these modules, and hence
> the system boot  up without a responding keyboard.   Despite that, the
> system does work and daemons are running!
> 
> So, why is a the keyboard need to always work?

This is getting really annoying. Let me rephrase it again:

I don't have a keyboard on every of my systems. But when I have it and I
have the driver running, I expect it to work. Regardless of what
happened to the system. Regardless of userspace programs dying. Just
work.

> I've  been  testing  'i8042'  module  and my  atkbd  driver  (and  the
> SERIO_USERDEV  patch) through  the  network.  I've  been doing  'rmmod
> i8042' many many times.  The system DOES work without that module (and
> keyboard  functionality).   Why are  you  saying  that  "you need  the
> keyboard  always  to  work"?   Again,   is  that  the  limit  of  your
> imagination?

Yes. The system doesn't need the keyboard drivers to function. The user
does.

> Are you aware of the i8042_shutdown bug, which I discovered and fixed?
> How could I have found such a bug, if "keyboard has to always work"?

Thanks for the fix.

> And  how about  mouse  drivers?  They  used  to be  in userland  (gpm,
> XFree86 3.x -- 4.x, etc.)  Why move it into the kernel?

You wanted to use a mouse click to dump registers?

>     Vojtech> I meant that keyboard handling was never done in
>     Vojtech> userspace. 
> 
> OK.  Then, it's time to consider moving it to userspace.

I'm not interested.

I'd have an interesting idea for you, though: If you want moving stuff
to userspace, move the whole console there. The font handling, the
keymap handling, colors, resolution, all that.

Just a simple program that uses the evdev interface to get the keyboard
data for input, the fbdev interface for output, and the pty interface to
communicate with the system.

Now *that* would be a great project moving stuff to userspace.

>     Vojtech> Of course it is modular now, but that still counts as 'in
>     Vojtech> the kernel'.
> 
> How about my atkbd.c?

It's in userspace. It's not running in the kernel space. It's subject to
the scheduler and swapping. It doesn't react to interrupts immediately.
I think that's quite clear.

>     Vojtech> ;) On embedded systems, or when you have an USB
>     Vojtech> keyboard, you can leave the whole PS/2 stuff out.
> 
> Is  it impossible  to run  daemons driving  the keyboard  (my atkbd.c,
> should  be invoked  from inittab)  and mouse  (e.g.  gpm)  on embedded
> systems?  I mean, why MUST the keyboard and mouse drivers be in kernel
> space?

Of course it's possible. There is not much that'd be impossible in
operating systems. It's not convenient, that's all. 

>     Vojtech> But still, if you have a working keyboard, the handling
>     Vojtech> is done in the kernel, and you can do a register dump,
>     Vojtech> process listing, etc, even when the system is
>     Vojtech> crashed.
> 
> Why just  the keyboard?  For that  purpose, we can  use mouse buttons,
> the  power button,  a joystick  button, or  even a  home-brewed button
> connected to the RS232 port or parallel port.  Why *limit* that to the
> keyboard?

Use whatever device you wish. I don't restrict you to just the keyboard.
The above argument works for a mouse, for a joystick, for an infrared
remote all the same.

>     Vojtech> You wouldn't be able to do that if the processing of the
>     Vojtech> byte stream was done in an userspace program.
> 
> Isn't it  possible to monitor  the kernel via  a tty connected  to the
> serial line?

It is. Surprise, the SAK and SysRq handling for that is done
_in_the_kernel_, because it doesn't want to depend on userspace.

>     Vojtech> - even in the case of a crash, when all userspace
>     Vojtech> programs may already be dead.
>     >>  There are still RS232 ports and the network.
> 
>     Vojtech> Sure. How convenient it is to have to find an RS232
>     Vojtech> cable, when your keyboard is just next to you on the
>     Vojtech> table?
> 
> The keyboard should be made an *option*, not a *requirement* for that.
> As an optional feature, yo shouldn't assume it for granted.

It IS an option, not a requirement. But I WANT THE OPTION. If the
keyboard handling is in userspace, I don't have the option of pressing a
key combination and getting a register dump, because the daemon doing
the processing may be dead already.

>     Vojtech> It can. But if your userspace is dead, you cannot run
>     Vojtech> that program. And that's usually when you need sysrq.
> 
> So, why limit that to the  keyboard only?  Why can't my LED lid switch
> do it?

Go ahead. It's just a matter of adding a few lines to the ACPI drivers,
registering the lid switch as an input device.

>     >>  Is that "improvement" significant for 1200 baud devices?  Even
>     >> on a 386DX-33?
> 
>     Vojtech> Yes. Very much significant. Exactly because they're
>     Vojtech> running at 1200 baud, you need get most of that little
>     Vojtech> data they're sending to you. 
> 
> I don't  understand this.  The slower  a device is, the  lesser is the
> need to handle the incoming  data in kernel space.  I can't understand
> how 1200baud is  fast enough to cause significant  delays.  Maybe, you
> can enlighten me on that?

> Yeah.  At  what rate  are they arriving?   1200baud.  Let's  say that'
> 9600bps.   So,   1200  bytes  per   second.   1  byte  in   every  833
> microseconds.  How  come a processor at 33MHz  (0.030 microseconds per
> clock cycle) cannot  cope with that?  Assuming that  the processing of
> the  data  plus  context  switching  plus  other  overhead  taks  1000
> microseconds, that still shouldn't be felt by a HUMAN user.  Who has a
> reaction time of less than 100 _milli_seconds?

Can you say swap?

>     Vojtech> Yes, it does. Because it uses the _kernel_ input system
>     Vojtech> to do the interfacing work. But I don't see any benefit
>     Vojtech> of having to go to userspace and back again into the
>     Vojtech> kernel.
> 
> Flexibility.  The  keyboard driver can  talk to another machine  via a
> TCP  connection, for  instance.   The keyboard  driver  can be  easily
> modified  and debugged --  all in  user space  -- without  hanging the
> kernel due to  stupid bugs (e.g. NULL pointers).   The keyboard driver
> could be prototyped  in Perl, C++, or any  other high-level languages.
> (It'd be possible  to design a specific language to  make it easier to
> describe the state machine, than in a general purpose language like C,
> making it possible to  less programming-proficient users to change the
> keyboard behaviours.)

Go play with microkernel systems. You'll meet people with similar views
there. Linux is not a microkernel, though.

>     Vojtech> Care to name any? Everything from raw SCSI handling to
>     Vojtech> presenting files to processes is done in the
>     Vojtech> kernel. 
> 
> So,  raw access  is  still available,  just  in case  the kernel  code
> developers' imaginations are exceeded in some applications.

Yes, and it's good. And I don't object to having raw access available. I
really don't. I just want to have it done in a sane way that doesn't
conflict with the kernel drivers. Like in SCSI.

>     Vojtech> Good argument. There are limits of what makes sense to do
>     Vojtech> in the kernel.  Ghostscript is easier to do in userspace,
>     Vojtech> because it needs access to fonts, has a nontrivial
>     Vojtech> configuration, isn't time critical, etc. Good candidate
>     Vojtech> for userspace.
> 
> Keyboard and mouse drivers are also easier to do in userspace, because
> that  makes access to  keymaps, mouse  protocol modules,  etc. easier.
> Neither do I think keyboard/mouse  drivers are time critical enough to
> be absolutely  placed in  kernel space.  Human  beings do not  work in
> units of milliseconds.

The keyboard and mouse drivers don't handle keymaps. Those are handled
in the console. The keyboard/mouse drivers are not necessarily _time_
critical, but they're critical. When your keyboard stops working, this
often means your system is dead. (Think a laptop on an airplane.)

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
