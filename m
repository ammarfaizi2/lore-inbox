Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263174AbUE3MCy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263174AbUE3MCy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 May 2004 08:02:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263185AbUE3MCy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 May 2004 08:02:54 -0400
Received: from mail1.kontent.de ([81.88.34.36]:2441 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S263174AbUE3MCv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 May 2004 08:02:51 -0400
From: Oliver Neukum <oliver@neukum.org>
To: Sau Dan Lee <danlee@informatik.uni-freiburg.de>
Subject: Re: keyboard problem with 2.6.6
Date: Sun, 30 May 2004 14:01:20 +0200
User-Agent: KMail/1.6.2
Cc: Vojtech Pavlik <vojtech@suse.cz>, Giuseppe Bilotta <bilotta78@hotpop.com>,
       linux-kernel@vger.kernel.org, Tuukka Toivonen <tuukkat@ee.oulu.fi>
References: <MPG.1b2111558bc2d299896a2@news.gmane.org> <20040530101914.GA1226@ucw.cz> <xb765aeb1i3.fsf@savona.informatik.uni-freiburg.de>
In-Reply-To: <xb765aeb1i3.fsf@savona.informatik.uni-freiburg.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200405301401.20196.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, 30. Mai 2004 13:25 schrieb Sau Dan Lee:
> >>>>> "Vojtech" == Vojtech Pavlik <vojtech@suse.cz> writes:
> 
>     >> >> What I hate is only the part where mouse/keyboard drivers
>     >> >> are now in kernel space.  The translation of raw byte
>     >> >> streams into input events should be better done in userland.
>     >> >> One important argument is: userland program may be swapped
>     >> >> out.  Kernel modules can't.
>     >> 
> 
>     Vojtech> Well, keyboard support was always in the kernel
> 
> Once in kernel space, forever in kernel space?  What's the logic?
> 
> Where  it is  now possible  to  move it  out of  kernel space  WITHOUT
> performance problems, why not move it out?

Two reasons: security and robustness.

1. sysreq must work, always work. Ideally you even do the dump
in hard irq. USB has been modified to support this.

2. A true SAK key must be processed in kernel space

There are additional reasons that make it nice to have a kernel driver,
but these reasons make it necessary.

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
> 
> 
> I've  been  testing  'i8042'  module  and my  atkbd  driver  (and  the
> SERIO_USERDEV  patch) through  the  network.  I've  been doing  'rmmod
> i8042' many many times.  The system DOES work without that module (and
> keyboard  functionality).   Why are  you  saying  that  "you need  the
> keyboard  always  to  work"?   Again,   is  that  the  limit  of  your
> imagination?

It does not support all features it is supposed to without that module.
There's nothing preventing you from using uinput if you want to. But full
function needs a kernel driver, either statically compiled or as a loaded
module.

	Regards
		Oliver
