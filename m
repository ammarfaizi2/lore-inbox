Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262185AbVAAEAW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262185AbVAAEAW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Dec 2004 23:00:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262186AbVAAEAV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Dec 2004 23:00:21 -0500
Received: from rproxy.gmail.com ([64.233.170.193]:61207 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262185AbVAAEAF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Dec 2004 23:00:05 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=IwSp6+DMUSDpu2YOvtBwsNWDxQ8awu7+Adxf0CdE5nK8b5BIArAAUq7Nhn0/PzUObeTj2AaZFfGwB1M00xeHVEAObHpvAbY8jn5xGfw3MolZjUAFxNNiU88mU6FaH4LHQM2E4P3QChETr3SL7hfy+5xhWiJhrUFGmJ+QhspbVqs=
Message-ID: <105c793f041231200047dd1e25@mail.gmail.com>
Date: Fri, 31 Dec 2004 23:00:03 -0500
From: Andrew Haninger <ahaning@gmail.com>
Reply-To: Andrew Haninger <ahaning@gmail.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: Fwd: Toshiba PS/2 touchpad on 2.6.X not working along bottom and right sides
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <105c793f0412301626468198be@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <105c793f04122907116b571ebf@mail.gmail.com>
	 <cr16ho$eh1$1@tangens.hometree.net>
	 <105c793f041230080734d71c4a@mail.gmail.com>
	 <200412301203.44484.dtor_core@ameritech.net>
	 <105c793f0412301626468198be@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Using the other options (imps and exps) didn't change the behavior
> much. I had some strange issues with the cursor being occasionally
> moved to the upper-right corner of the screen very quickly when I
> dragged in the lower and the right sides of the touchpad. This
> behavior, however, was not (yet) reproducible. If I can figure out how
> to reproduce it reliably, I'll note it later.

For what it's worth, I still haven't found exactly what is causing
this problem, but it has shown up more than once. It seems that it
might have something to do with repeatedly loading and unloading the
psmouse driver using different protocol options (proto=bare|imps|exps)
and loading and unloading gpm (I said gdm previously, which was a
mistake) using different -t (type) options (ps2|imps2|auto) and/or
different mouse devices (/dev/mouse or /dev/input/mice). I've done
lots of things to try to reproduce this behavior, but nothing yet
seems to make it happen every time.

I haven't used the laptop 'normally' very much yet, so I don't know if
this problem shows up in normal use or just under strange
circumstances like setup and testing.

When it does show up, the mouse cursor moves quickly up to the
upper-right corner of the display - be it the X display or on the
console with gpm - when the lower or right sides of the touchpad are
used. Using the other areas of the touchpad produces normal curser
movement.

I'll continue to test things to see what might be causing problems.
One thing I can contribute which showed up after this problem is an
Oops during a boot. It could be totally unrelated and it's only
happened once (a reboot produced no such Oops), but here it is:

Software Suspend 2.1.5.10: Suspending enabled.
Unable to handle kernel NULL pointer dereference at virtual address 00000004
 printing eip:
c01266e6
*pde = 00000000
Oops: 0001 [#1]
PREEMPT
Modules linked in:
CPU:    0
EIP:    0060:[<c01226e6>]    Not tainted VLI
EFLAGS: 00010083    (2.6.10)
EIP is at worker_thread+0x1e6/0x310
eax: 00000000   ebx: cbd0f04c   ecx: cbfe77b0   edx: 00000000
esi: cbd0f048   edi: cbfc9000   ebp: 00000283   esp: cbfc9f44
ds: 007b   es: 007b   ss: 0068
Process events/0 (pid: 3, threadinfo=cbf9000 task=cbfc3020)
Stack: 00000000 cbfc9f74 00000000 cbfe77b8 cbfc9000 cbfc9000 00000000 00000000
       cbfc9000 cbfe77a8 ffffffff ffffffff 00000001 00000000 c0112d10 00010000
       00000000 00000000 00000000 cbfc9000 00000000 cbfc3020 c0112d10 00100100
Call Trace:
 [<c0112d10>] default_wake_function+0x0/0x20
 [<c0112d10>] default_wake_function+0x0/0x20
 [<c0126500>] worker_thread+0x0/0x310
 [<c012ab0a>] kthread+0xba/0xc0
 [<c01012e5>] kernel_thread_helper+0x5/0x10
Code: 50 18 89 54 24 0c eb 0d 90 90 90 90 90 90 90 90 90 90 90 90 90
8d 73 fc 8b 46 0c 89 44 24 1c 8b 56 10 89 54 24 18 8b 53 04
 8b 03 <89> 50 04 89 02 89 5b 04 89 1b 55 9d ff 4f 14 8b 47 08 83 e0 08
 <6>note: events/0[3] exited with preempt_count 1
Software Suspend 2.1.5.10: This is normal swap space.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory 160k freed
_


If anything looks odd or unlike normal Oops output, I was unable to
capture it digitally and so had to type it out longhand, which could
contribute to typos :-/ . Also, since it seems to have occured between
the swsusp code loading, I may need to submit it to those guys
instead.

HTH. Thanks.

-Andy
