Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263364AbTJZRpi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Oct 2003 12:45:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263367AbTJZRpi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Oct 2003 12:45:38 -0500
Received: from puetzk.org ([212.13.198.114]:61965 "EHLO puetzk.vm.65535.net")
	by vger.kernel.org with ESMTP id S263364AbTJZRph (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Oct 2003 12:45:37 -0500
From: Kevin Puetz <puetzk@puetzk.org>
To: jjluza <jjluza@free.fr>, linux-kernel@vger.kernel.org,
       Jaroslav Kysela <perex@suse.cz>
Subject: Alsa deadlock fix (was Re: 2.6-test8 : alsa hangs my box)
Date: Sun, 26 Oct 2003 11:45:18 -0600
User-Agent: KMail/1.5.9
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200310261145.18537.puetzk@puetzk.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am seeing this hang also, on a different card, whenever a native alsa and an 
OSS-emulation app collide. No nVidia stuff this time, and not snd_intel8x0 
either, this is w/ a via82xx motherboard's integrated sound. From what little 
one can tell from the sysrq-T backtrace, it looks like a classic deadlock 
(both tasks stick in down(), probably on different mutexes). 

It also looks like it has alreay been fixed (in alsa 0.9.7b) - I think the 
kernel's alsa is approximately equivalent to 0.9.6 these days? So, it looks 
like either some work to port that patch or a wholesale merge of alsa 0.9.8 
would be good before 2.6.0... probably the former given Linus's 
strongly-worded comments with -test9 :-) 

But a deadlock that results in two unkillable state 'D' processes whenever you 
an OSS and an alsa-native app access the soundcard at the same time, which 
happens on both VIA and Intel integrated sound, seems like a hang which might 
meet his criteria of problems which "causes lockups or just basic 
nonworkingness: and this happens on hardware that normal people are expected 
to have". So I figured it's worth asking if someone who already knows what 
the fix consisted of could push it toward Linus ...
