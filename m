Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261711AbUFNCg3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261711AbUFNCg3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jun 2004 22:36:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261712AbUFNCg3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jun 2004 22:36:29 -0400
Received: from mailout.despammed.com ([65.112.71.29]:25545 "EHLO
	mailout.despammed.com") by vger.kernel.org with ESMTP
	id S261711AbUFNCgZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jun 2004 22:36:25 -0400
Date: Sun, 13 Jun 2004 21:23:01 -0500 (CDT)
Message-Id: <200406140223.i5E2N1k18221@mailout.despammed.com>
From: ndiamond@despammed.com
To: linux-kernel@vger.kernel.org
Subject: Panics need better handling
X-Mailer: despammed.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following information is visible on
a screen after a panic.  Usually even
this amount of information is not
visible.  It was visible because of an
intuitive guess that a panic was going
to happen within minutes of that guess.
A very lucky occurence resulted in one
of the lines being displayed which is
rarely displayed even when other panic
lines are visible.  I am not asking for
help in solving this particular panic,
I am asking for help in general, in
getting information displayed when it
needs to be displayed.

EIP is at __insmod_binfmt_misc_S.data_L548 [binfmt_misc] 0x20e7 (2.4.20-custom)
eax: e47f1600   ebx: e4017e80   ecx: 00000000   edx: e7883000
esi: 04000001   edi: c034df54   ebp: 0000000b   esp: c034df10
ds: 0068   es: 0068   ss: 0068
Process swapper (pid: 0, stackpage=c034d000)
Stack: c010aab5 0000000b e47f1600 c034df54 c036fe80 0000000b c29c6c00 00000580
       c010ac54 0000000b c034df54 c29c6c00 00000000 00000000 00000000 00000000
       c010d768 00000000 00000000 000005c1 00000000 00000000 00000000 c034dfbc
Call Trace:   [<c010aab5>] handle_IRQ_event [kernel] 0x45 (0xc034df10))
[<c010ac54>] do_IRQ [kernel] 0x84 (0xc034df30))
[<c010d768>] call_do_IRQ [kernel] 0x5 (0xc034df50))
[<c0110068>] dump_fpu [kernel] 0x48 (0xc034df70))
[<c01157ee>] apm_bios_call_simple [kernel] 0x8e (0xc034df7c))
[<c0115937>] apm_do_idle [kernel] 0x27 (0xc034dfa8))
[<c0115a8b>] apm_cpu_idle [kernel] 0xbb (0xc034dfc0))
[<c01159d0>] apm_cpu_idle [kernel] 0x0 (0xc034dfc4))
[<c0107040>] default_idle [kernel] 0x0 (0xc034dfd0))
[<c01070f2>] cpu_idle [kernel] 0x42 (0xc034dfd4))
[<c0105000>] stext [kernel] 0x0 (0xc034dfe0))


Code:  Bad EIP value.
 <0>Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing
_       <-- (cursor is there)


I'm not sure which of these complaints
to prioritize.

When a panic is visible, there are two
blank lines, a redundant line saying
Kernel panic Aieee, a redundant line
saying In interrupt handler, and a
redundant line with the cursor only.
If these 5 lines were removed, there
could be 5 more lines of trace
information.  Actually there usually
are 5 more lines of trace information,
actually usually more than that, but
they get scrolled off the top of the
screen.  The line saying "EIP is at" is
almost always among the lines that get
scrolled off the screen, but in this
case we were lucky that this line just
barely got a chance to survive.  And
usually the EIP isn't so badly invalid
as this one is, usually it's really
useful information that gets scrolled
off the top of the screen.  Is there
any chance in getting the 24 most
important lines of panic information
displayed last, and putting the cursor
at the end of the 24th line thereof, so
that 24 valuable lines of panic
information can be visible?

Also, usually the panic information
isn't visible at all.  Certain famous
frequent blue screens of death are
famous and frequent partly because of
famous frequent crashes, but also
partly because the kernel puts the
screen back into VGA text mode before
displaying the text.  In Linux, usually
XFree86 is running, and usually the
only visible effect is a freeze.  How
many of these freezes really have panic
information written to an invisible VGA
buffer and never displayed?  When a
panic occurs, we need to shove off
XFree86 and put the display into VGA
text mode.  Even if this makes Linux
black screens of death become as famous
and frequent as certain blue ones, we
need to get the information.

(Apologies if there are editing errors
in the above, which are not visible in
the web interface being used for this
submission.  I used to send submissions
from my real e-mail account, and as a
result was rewarded with 60 spams per
day.  I'm not going to send submissions
from my new real e-mail account.)
