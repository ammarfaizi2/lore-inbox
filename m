Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265188AbUDUHP7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265188AbUDUHP7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 03:15:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265190AbUDUHP7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 03:15:59 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:58531 "EHLO
	atlas.informatik.uni-freiburg.de") by vger.kernel.org with ESMTP
	id S265188AbUDUHPz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 03:15:55 -0400
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org, Tuukka Toivonen <tuukkat@ee.oulu.fi>
Subject: Re: /dev/psaux-Interface
References: <Pine.GSO.4.58.0402271451420.11281@stekt37>
	<200404200756.08672.dtor_core@ameritech.net>
	<xb71xmhhmej.fsf@savona.informatik.uni-freiburg.de>
	<200404210151.06636.dtor_core@ameritech.net>
From: Sau Dan Lee <danlee@informatik.uni-freiburg.de>
Date: 21 Apr 2004 09:15:53 +0200
In-Reply-To: <200404210151.06636.dtor_core@ameritech.net>
Message-ID: <xb7smexg5sm.fsf@savona.informatik.uni-freiburg.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=big5
Content-Transfer-Encoding: 8BIT
Organization: Universitaet Freiburg, Institut fuer Informatik
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Dmitry" == Dmitry Torokhov <dtor_core@ameritech.net> writes:

    Dmitry> Also I do not see where the code makes sure that it does
    Dmitry> not bind to keyboard's port (so keyboard driver has to be
    Dmitry> loaded first).
    >>  Ask the people who wrote i8042.c and serio.c to document the
    >> interface.  I simply copied the necessary stuff from
    >> psmouse-base.c.  If that psmouse.ko works, then why should my
    >> psaux fail?
 
    Dmitry> Because if you look in psmouse_probe we actually check if
    Dmitry> there is a mouse behing the port.

Such probing can  only detect my touchscreen (and  many other devices)
as a PS2 mouse, due to  hardware emulation.  Why would I use Linux 2.6
if my touchscreen is degenerated into a mouse-emulating device?


    >> Adding the complexity of various devices and protocols into
    >> kernelspace is insane.

    Dmitry> The thing is that processing in kernel space is not that
    Dmitry> complex.

Even so,  it's not easy to  get it right.  In  kernel programming, you
have to take  care of many issues, such as whether  you have a process
context, when to  use spinlock, wait queues, etc.  I  even had to care
about fasync() when developing the psaux module, even though it's just
copying a few lines of sample code from the kernel hacking guide.

If it  were in user space,  it would be  simpler: I just need  to open
/dev/psaux  (a la  2.4, 2.2,  2.0, 1.0.32(?)),  block-reading  a byte,
modify  the state  of  my state  machine  in the  program, and  output
something to  a repeater device  when needed.  No SMP  issues, fasync,
etc   (assuming  /dev/psaux   and   the  repeater   device  do   those
automagically).


    Dmitry> The only thing  kernel has to do is to  parse raw data and
    Dmitry> convert to events.

Unfortunately,  it loses  data during  the conversion.   Moreover, the
current  /dev/psaux in  standard  2.6 kernel  DOES  NOT ALLOW  writing
command bytes  to the  PS2/AUX port, preventing  me from  enabling the
touchscreen behaviour  (disabling mouse emulation)  without any kernel
programming.  That's stupid.

IOW, the 2.6 kernel is implementing a policy, taking away flexibility.


    Dmitry> We have such thing - look at uinput module - it can be
    Dmitry> used to feed events back into the kernel.

There is still no provision for a userspace program to talk to the PS2
AUX port *directly*.  I don't want  my commands to be censored and the
data be translated.


-- 
Sau Dan LEE                     §õ¦u´°(Big5)                    ~{@nJX6X~}(HZ) 

E-mail: danlee@informatik.uni-freiburg.de
Home page: http://www.informatik.uni-freiburg.de/~danlee

