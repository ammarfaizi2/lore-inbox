Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261503AbTIKU0R (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 16:26:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261505AbTIKU0Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 16:26:16 -0400
Received: from pop.gmx.de ([213.165.64.20]:60118 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261503AbTIKU0L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 16:26:11 -0400
References: <200309102303.34095.adq_dvb@lidskialf.net>
Cc: linux-kernel@vger.kernel.org, linux-dvb@linuxtv.org, franck@nenie.org,
       eric@lammerts.org
In-Reply-To: <200309102303.34095.adq_dvb@lidskialf.net> (message from Andrew de Quincey on Wed, 10 Sep 2003 23:03:34 +0100)
To: adq_dvb@lidskialf.net
Subject: Re: [linux-dvb] Possible kernel thread related crashes on 2.4.x
From: David Kuehling <dvdkhlng@gmx.de>
Date: 11 Sep 2003 22:18:10 +0200
Message-ID: <873cf3w03h.fsf@snail.pool>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Andrew" == Andrew de Quincey <adq_dvb@lidskialf.net> writes:

> Hi, I've been having fatal oopses with some of my DVB receiver systems
> when restarting streaming recently (i.e. opening/closing DVB devices).
> I've only just got into the office with a debug cable to find out what
> has happening.

> Anyway, here are the important parts of the oops (full oops at end of
> mail): Unable to handle kernel paging request at virtual address
> d905a984 ...  Trace; c011c79c <free_uid+2c/34> Trace; c011767b
> <release_task+2b/16c> Trace; c0118337 <sys_wait4+307/390> Trace;
> c0106c03 <system_call+33/38>

Looks *very* familiar.  My box keeps constantly crashing, since I
installed linux-dvb 1.0.0.  Here's one of my backtraces:

Call Trace: 
        [free_uid+44/64] 
        [release_task+41/336]
        [sys_wait4+775/912] 
        [system_call+51/56] 

Someone else on this list mentioned that he had the same problem but it
went away, when he changed some config switches in the kernel.  He also
mentioned, that he wasn't able to figure out how those crashes were
caused.

> Searching about found me this patch on LKML:
> http://hypermail.idiosynkrasia.net/linux-kernel/archived/2003/week04/0468.html
> Which I applied to 2.4.21, and which appears to fix the problem. At
> least, I was able to continually restart streaming for 4 hours this
> afternoon without a problem.  Previously, I could crash it within 15
> minutes.

I think I'll just try that.  Hopefully it will apply to my debianized
linux-2.4.17.

> It seems to be a bug related to kernel threads when starting/stopping
> them. The DVB drivers now do this when a DVB device is opened/closed,
> although I'm sure they previously left them running which would
> explain why I never saw this behaviour before.

This would explain why my system hangs/crashes especially when zapping a
lot (it never crashed during continuous playback, only when zapping).
I'm using MPlayer, which always re-opens the device for a new channel.

David
-- 
GnuPG public key: http://user.cs.tu-berlin.de/~dvdkhlng/dk.gpg
Fingerprint: B17A DC95 D293 657B 4205  D016 7DEF 5323 C174 7D40

