Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261976AbUE0Lvu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261976AbUE0Lvu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 07:51:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261984AbUE0Lvg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 07:51:36 -0400
Received: from ecbull20.frec.bull.fr ([129.183.4.3]:58514 "EHLO
	ecbull20.frec.bull.fr") by vger.kernel.org with ESMTP
	id S261976AbUE0LvV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 07:51:21 -0400
Message-ID: <40B5D68C.466FE969@nospam.org>
Date: Thu, 27 May 2004 13:52:44 +0200
From: Zoltan Menyhart <Zoltan.Menyhart_AT_bull.net@nospam.org>
Reply-To: Zoltan.Menyhart@bull.net
Organization: Bull S.A.
X-Mailer: Mozilla 4.78 [en] (X11; U; AIX 4.3)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Hot plug vs. reliability
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've got some questions about how hot plugging can (or cannot)
ensure reliability:

When we produce machines, we execute tests like burn in, stress,
validation, etc. tests. In addition, every time a machine is switched
on, a power on self test is executed.
When we hot plug (add, remove, swap) a component that has never been
seen, how can we make sure that the modified machine achieves the
same MTBF as the original machine had, without passing any of the
tests I mentioned above ?

There are cases when not the "worst case" design is used. You select 
components "carefully". E.g. you use a quicker component after a
slower one to compensate the excessive delay, or you select parallel
components with similar irregularities (no problem if they are too
slow assuming they are similarly slow). How can we match a hot
plug device with the existing ones ?
Our engineers made hard effort e.g. to equalize the delays on the
"back plain" to make sure the signals reaches the components with
the same delay.
A machine is fabricated with the same series of the CPU / memory
boards. (And they are tested together.) What if the new series of
these boards are somewhat quicker ?

A test can do any "irregular" operation whatever it wants. E.g.
the memory controller can be switched into a test mode, that allows
reading / writing the memory without the intervention of the ECC
logic. One can fill in the memory with some predefined pattern and
check if the ECC logic does what it has to do. Can we do this for
memory hot plug without breaking a running OS ?
Another example: we add a CPU board and we need to make sure that
the coherency dialog goes fine. Can we carry out these tests
without perturbing the already on line CPUs ?
How can we make sure that a freshly inserted I/O card can reach
all the memory it has to, it can interrupt any CPU it has to ?
(Again, without breaking the OS.)

And now the most difficult tests: how can we make sure that no error
will be undetected. E.g. at the power on test, we can voluntarily
provoke "machine checks" to make sure that these kinds of errors are
safely detected. Can we really do this on a living operating system ?
No problem resetting several times the machine (by the service
processor). Obviously, it is not a good idea for a running system.
What can we do in case of hungs, time-outs ?

Do you know of some firmware services like "in place testing" ? I mean
the operating system invokes a specific firmware call and hands over
the control of the machine temporarily (say for 1 millisecond) to the
firmware. The firmware can execute a small part of the validation
test (without corrupting any data, without losing an interrupt, etc.)
then it returns to the OS. This latter resumes the operations and
calls again the firmware the tests somewhat later.

We cannot remove safely failing memory / CPUs. In most of the cases
it is too late. We (in the OS) can see some corrected CPU, memory, I/O
and platform errors. Yet the OS has not got and should not have the
knowledge when a component is "enough bad". I think it is the firmware
that has all the information about the details of the HW events.
Do you know of some firmware services which can say something like:
"hey, remove the component X otherwise your MTBF will drop by 95 %..." ?

Today HW components are sold without much testing. They say O.K. got
a problem?, just send it back, we'll refund. Thanks. I just have broken
my system.
Shall I have a PCI test pad just for validate PCI cards before hot
plugging it in ?

Do we really want to hot plug in order to compromise our MTBF ?

Thanks,

Zoltán Menyhárt
