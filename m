Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261437AbSJMGaB>; Sun, 13 Oct 2002 02:30:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261438AbSJMGaA>; Sun, 13 Oct 2002 02:30:00 -0400
Received: from fastmail.fm ([209.61.183.86]:17374 "EHLO www.fastmail.fm")
	by vger.kernel.org with ESMTP id <S261437AbSJMG37>;
	Sun, 13 Oct 2002 02:29:59 -0400
X-Mail-from: robm@fastmail.fm
X-Spam-score: -0.1
X-Epoch: 1034490949
X-Sasl-enc: l4K+vb0bvjCSJW2neuxLjA
Message-ID: <113001c27282$93955eb0$1900a8c0@lifebook>
From: "Rob Mueller" <robm@fastmail.fm>
To: "Mark Hahn" <hahn@physics.mcmaster.ca>
Cc: <linux-kernel@vger.kernel.org>, "Jeremy Howard" <jhoward@fastmail.fm>
References: <Pine.LNX.4.33.0210130202070.17395-100000@coffee.psychology.mcmaster.ca>
Subject: Re: Strange load spikes on 2.4.19 kernel
Date: Sun, 13 Oct 2002 16:34:21 +1000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


We've just discovered that this is actually happening on another one of our
machines as well. This machine uses 2.4.18 kernel, ext3 and has 2 SCSI
drives and 2 IDE drives which hold the main user mailbox data. Also it's a
P3 with a completely different motherboard rather than an Athlon, so it
doesn't seem to be hardware related in that respect.

> well, it's conceivable that if something is blocking a bunch
> of procs, it would also block your shell and ps, so not show up.
> "vmstat 1" might work better, though it's munging plenty of
> /proc files so is hardly immune to that.

But the ps/shell would only use CPU time, and there's plenty of that
available. Unless it was something everything would block on... what could
that be? A spin lock or something? Some interrupt routine? Would that even
result in other processes being counted as blocked process?

Also Let me do a calculation, though I have no idea if this is right or
not...
a) the first item in the uptime output is 'system load average for the last
1 minute'
b) it seems to only update/recalculate every 5 seconds
c) it jumps from < 1 to 20 in 1 interval (eg 5 seconds)

This means that for it to jump from < 1 to 20 in 5 seconds, there must be on
average about 60/5 * 20 = 240 processes blocked over those 5 seconds waiting
for run time of some sort for the load to jump 20 points. Is that right?

> but it's worth asking: do you notice a hiccup other than by looking
> at the loadav?  that is, suppose the loadav is simply miscalculated...

Well yes, there definitely does seem to be a performance hit on the whole
system when the load jumps, everything feels significantly more 'sluggish'
during the spikes is the best I can describe it right now...

Rob

