Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261595AbSIXHQ5>; Tue, 24 Sep 2002 03:16:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261596AbSIXHQ5>; Tue, 24 Sep 2002 03:16:57 -0400
Received: from mx2.elte.hu ([157.181.151.9]:33701 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S261595AbSIXHQy>;
	Tue, 24 Sep 2002 03:16:54 -0400
Date: Tue, 24 Sep 2002 09:30:40 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Thunder from the hill <thunder@lightweight.ods.org>
Cc: Bill Davidsen <davidsen@tmr.com>, Larry McVoy <lm@bitmover.com>,
       Peter Waechtler <pwaechtler@mac.com>, <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@redhat.com>
Subject: Re: [ANNOUNCE] Native POSIX Thread Library 0.1
In-Reply-To: <Pine.LNX.4.44.0209240111330.7827-100000@hawkeye.luckynet.adm>
Message-ID: <Pine.LNX.4.44.0209240921090.10279-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 24 Sep 2002, Thunder from the hill wrote:

> > 90% of the programs that matter behave exactly like Larry has described.
> > IO is the main source of blocking. Go and profile a busy webserver or
> > mailserver or database server yourself if you dont believe it.
>
> Well, I guess Java Web Server behaves the same?

yes. The most common case is that it either blocks on the external network
connection (IO), or on some internal database connection (IO as well). The
JVMs themselves be better well-threaded internally, with not much
contention on any internal lock. The case of internal synchronization is
really that the 1:1 model makes a 'bad parallelism' more visible: when
there's contention. It's quite rare that heavy synchronization and heavy
lock contention cannot be avoided, and it mostly involves simulation
projects which often do this because they simulate real world IO :-)

(but, all this thread is becoming pretty theoretical - current fact is
that the 1:1 library is currently more than 4 times faster than the only
M:N library that we were able to run the test on using the same kernel, on
M:N's 'home turf'. So anyone who thinks the M:N library should perform
faster is welcome to improve it and send in results.)

	Ingo

