Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263731AbUE3N0U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263731AbUE3N0U (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 May 2004 09:26:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263736AbUE3N0U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 May 2004 09:26:20 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:13038 "EHLO
	atlas.informatik.uni-freiburg.de") by vger.kernel.org with ESMTP
	id S263731AbUE3NZN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 May 2004 09:25:13 -0400
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: keyboard problem with 2.6.6
References: <xb7r7t2b3mb.fsf@savona.informatik.uni-freiburg.de>
	<20040530111847.GA1377@ucw.cz>
	<xb71xl2b0to.fsf@savona.informatik.uni-freiburg.de>
	<20040530124353.GB1496@ucw.cz>
From: Sau Dan Lee <danlee@informatik.uni-freiburg.de>
Date: 30 May 2004 15:25:10 +0200
In-Reply-To: <20040530124353.GB1496@ucw.cz>
Message-ID: <xb7aczq9he1.fsf@savona.informatik.uni-freiburg.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=big5
Content-Transfer-Encoding: 8BIT
Organization: Universitaet Freiburg, Institut fuer Informatik
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Vojtech" == Vojtech Pavlik <vojtech@suse.cz> writes:

    >>  How about the PS/2 mouse port?  It's not just for mice.  There
    >> ARE implementations using it for other things: touchpad,
    >> touchscreen, etc.

    Vojtech> All simulate a mouse. 

Yeah.  All can fall back to  PS/2 mouse emulation mode.  But to enable
the extended features,  you need to write to the  port to enable them,
and then interpret the extended data formats.



    Vojtech> No. I'm just saying - if you want something that's not in
    Vojtech> the kernel drivers, just write a driver for it. But the
    Vojtech> driver must be able to coexist with the other drivers.

It's easier to write a mouse  driver in userspace than in kernel.  But
with the  input system  in 2.6, I  am *forced*  to write it  in kernel
space, and  reboot and  reboot and reboot  when it oops.   Writing the
driver in kernel  space, I at most get a segfault.   Plus I cannot use
everything from glibc.  It simply  takes more time and energy to write
a kernel space driver.


    Vojtech> Your psaux/userspace serio driver is fine, except it
    Vojtech> cannot coexist with the other drivers.

That's why I've abandoned it.  It's obsolete.

Our (Tuukka and I) SERIO_USERDEV  patch does work with kernel drivers,
and allow  both kernel  and userland drivers  to coexist.   Again, I'm
disappointed that you still haven't discovered this.


Now, it's time  for you to try our SERIO_USERDEV  patch, plus my crude
userspace atkbd.c and psmouse drivers.


    Vojtech> Anyway, at least 99% setups just keep working in 2.6.

But  not 100%  compatibly.   Mouse  moving twice  as  fast, mouse  not
accelerating, etc.  And  tp4d not working any more.   And touch screen
not working. ...


    Vojtech> The raw data not what you want to use there. You want the
    Vojtech> keystroke data,
    >>  No.  I want the raw bytes.  (That's also useful for debugging
    >> a hardware, in case people are making or experimenting with new
    >> hardware.)

    Vojtech> Sure. For debugging purposes, yes. But for analyzing the
    Vojtech> typing behavior, the abstract data is better.

It depends on  what level I want  to analyze at.  How come  you have a
crystal ball telling you that you know what I want?



    >> I could study the I-Ching in English, but I would prefer to do
    >> it in Chinese.  Now, your approach is forcing me to do it in
    >> English.  And you believe that's a good idea.

    Vojtech> In your example, you wanted to study the frequency of
    Vojtech> keypresses, and their relations. For that, it's best to
    Vojtech> ask the kernel to report keypresses to you.

No.  The kernel has already translated the data.



-- 
Sau Dan LEE                     §õ¦u´°(Big5)                    ~{@nJX6X~}(HZ) 

E-mail: danlee@informatik.uni-freiburg.de
Home page: http://www.informatik.uni-freiburg.de/~danlee

