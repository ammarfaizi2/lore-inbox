Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261441AbSJMG4F>; Sun, 13 Oct 2002 02:56:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261442AbSJMG4F>; Sun, 13 Oct 2002 02:56:05 -0400
Received: from smtp801.mail.sc5.yahoo.com ([66.163.168.180]:30767 "HELO
	smtp801.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id <S261441AbSJMG4C>; Sun, 13 Oct 2002 02:56:02 -0400
From: "Joseph D. Wagner" <wagnerjd@prodigy.net>
To: "'Rob Mueller'" <robm@fastmail.fm>,
       "'Mark Hahn'" <hahn@physics.mcmaster.ca>
Cc: <linux-kernel@vger.kernel.org>, "'Jeremy Howard'" <jhoward@fastmail.fm>
Subject: RE: Strange load spikes on 2.4.19 kernel
Date: Sun, 13 Oct 2002 02:01:44 -0500
Message-ID: <000001c27286$6ab6bc60$7443f4d1@joe>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4024
In-Reply-To: <113001c27282$93955eb0$1900a8c0@lifebook>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'll let you in on a dirty little secret.  The Linux file system does
not utilize SMP.  That's right.  All file processes go through one and
only one processor.  It has to do with the fact that the Linux kernel is
a non-preemptive kernel.

Linus, in his infinite wisdom, made a "strategiery" decision that it
would be better for one process to be able to grind your machine to a
halt than to redo and rework sections of the kernel that don't allow for
preemption.

Try switching kernels to the Linux Kernel Preemption Project:
http://sourceforge.net/projects/kpreempt


-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Rob Mueller
Sent: Sunday, October 13, 2002 1:34 AM
To: Mark Hahn
Cc: linux-kernel@vger.kernel.org; Jeremy Howard
Subject: Re: Strange load spikes on 2.4.19 kernel


We've just discovered that this is actually happening on another one of
our
machines as well. This machine uses 2.4.18 kernel, ext3 and has 2 SCSI
drives and 2 IDE drives which hold the main user mailbox data. Also it's
a
P3 with a completely different motherboard rather than an Athlon, so it
doesn't seem to be hardware related in that respect.

> well, it's conceivable that if something is blocking a bunch
> of procs, it would also block your shell and ps, so not show up.
> "vmstat 1" might work better, though it's munging plenty of
> /proc files so is hardly immune to that.

But the ps/shell would only use CPU time, and there's plenty of that
available. Unless it was something everything would block on... what
could
that be? A spin lock or something? Some interrupt routine? Would that
even
result in other processes being counted as blocked process?

Also Let me do a calculation, though I have no idea if this is right or
not...
a) the first item in the uptime output is 'system load average for the
last
1 minute'
b) it seems to only update/recalculate every 5 seconds
c) it jumps from < 1 to 20 in 1 interval (eg 5 seconds)

This means that for it to jump from < 1 to 20 in 5 seconds, there must
be on
average about 60/5 * 20 = 240 processes blocked over those 5 seconds
waiting
for run time of some sort for the load to jump 20 points. Is that right?

> but it's worth asking: do you notice a hiccup other than by looking
> at the loadav?  that is, suppose the loadav is simply miscalculated...

Well yes, there definitely does seem to be a performance hit on the
whole
system when the load jumps, everything feels significantly more
'sluggish'
during the spikes is the best I can describe it right now...

Rob

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

