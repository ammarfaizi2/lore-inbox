Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262817AbTLPVtP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Dec 2003 16:49:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262859AbTLPVtP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Dec 2003 16:49:15 -0500
Received: from fep02-0.kolumbus.fi ([193.229.0.44]:2639 "EHLO
	fep02-app.kolumbus.fi") by vger.kernel.org with ESMTP
	id S262817AbTLPVtL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Dec 2003 16:49:11 -0500
Content-Type: text/plain;
  charset="iso-8859-15"
From: Kari Hameenaho <khaho@kolumbus.fi>
To: linux-kernel@vger.kernel.org
Subject: Change of setitimer() handling in 2.6.0-testX against 2.5.69 (and 2.4.x) ?
Date: Tue, 16 Dec 2003 23:49:46 +0200
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20031216214910.UOCO15326.fep02-app.kolumbus.fi@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There was previously a linux-kernel mailing list thread about scheduling 
degration (actually change of nanosleep timeout handling). I am not so 
interrested in nanosleep, but I do have an application using setitimer().

I did some test code and noticed that it_interval handling in 
setitimer(ITIMER_REAL ...) has also changed:

- machine is otherwise idle, SMP, threads RT priority or not
- SIGALRM comes in average every 1 ms in 2.5.x (and 1000 Hz patched 2.4.x)
- SIGALRM comes in average every 2 ms in 2.6.0-test11 (also 2.6.0-test8)

Setting of the timer:

  it.it_value.tv_sec = 0;
  it.it_value.tv_usec = 1000;
  it.it_interval.tv_sec = 0;
  it.it_interval.tv_usec = 1000;
  setitimer(ITIMER_REAL,&it,NULL);

Of course when asked for longer timeouts, the 1 ms difference remains.

Looking at the man page, this also seems to be OK (if this interval is 
interpreted as a timeout, which can be longer but not shorter than expected).

However, building a timebase for an application by setitimer() has definitely 
changed, so every code relying on the interval really being averaged 
correctly is now a little bit broken.

Is this intended or some side effect of other recent changes ?

-- 
Kari Hämeenaho
