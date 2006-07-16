Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750751AbWGPKO2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750751AbWGPKO2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jul 2006 06:14:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750805AbWGPKO1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jul 2006 06:14:27 -0400
Received: from 142.163.233.220.exetel.com.au ([220.233.163.142]:31421 "EHLO
	idefix.homelinux.org") by vger.kernel.org with ESMTP
	id S1750751AbWGPKO0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jul 2006 06:14:26 -0400
Subject: Re: Where is RLIMIT_RT_CPU?
From: Jean-Marc Valin <Jean-Marc.Valin@USherbrooke.ca>
To: Esben Nielsen <nielsen.esben@googlemail.com>
Cc: Lee Revell <rlrevell@joe-job.com>, Arjan van de Ven <arjan@infradead.org>,
       linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <Pine.LNX.4.64.0607161137080.9870@localhost.localdomain>
References: <1152663825.27958.5.camel@localhost>
	 <1152809039.8237.48.camel@mindpipe>
	 <1152869952.6374.8.camel@idefix.homelinux.org>
	 <Pine.LNX.4.64.0607142037110.13100@localhost.localdomain>
	 <1152919240.6374.38.camel@idefix.homelinux.org>
	 <1152971896.16617.4.camel@mindpipe>
	 <1152973159.6374.59.camel@idefix.homelinux.org>
	 <1152974578.3114.24.camel@laptopd505.fenrus.org>
	 <1152975857.6374.65.camel@idefix.homelinux.org>
	 <1152978284.16617.7.camel@mindpipe>
	 <1153009392.6374.77.camel@idefix.homelinux.org>
	 <Pine.LNX.4.64.0607161137080.9870@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: =?ISO-8859-1?Q?Universit=E9?= de Sherbrooke
Date: Sun, 16 Jul 2006 20:14:24 +1000
Message-Id: <1153044864.6374.135.camel@idefix.homelinux.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> You can't have "random" users scheduling thing at real-time priorities.
> A real-time system can only work if it is set up as whole and all 
> real-time tasks are taken into consideration. If you allow a user to start 
> another real-time task, that task might destroy the real-time properties 
> of all the rest by taking too much cpu.
> 
> As I see it the only thing you can do is to use sudo to run anything,
> which needs real-time priority, with higher priviliges, than what a normal 
> user have. Then he can only start specific audio programs and can't crash 
> the system (unless those programs have a bug).

I though we were past that point a long time ago. Of course you don't
want *any* random user to have access to rt scheduling. However, you
*do* want the user logged-in on the console be allowed to run tasks with
rt priority (within some limits). Why? Because 1) you don't want to give
root access to any user who needs RT for some apps and 2) you don't want
to make all these apps suid root either. 

Think about it, would you really feel safe with your sound daemon,
Ekiga/Gnomemeeting, jackd, Amarok, mplayer, ... all being run setuid
root. Yet all these apps (and many others) can benefit from being
allowed a few percent CPU running at rt priority. Not to mention the
fact that you may actually want to do rt *development* as a regular
user. That's why people have come up with realtime-lsm, and more
recently, with SCHED_ISO and rt-limit. What's currently missing is just
the tiny bit that prevents the user from locking up the machine. Even
that one was done by Ingo, but unfortunately not merged in the mainline
kernel. Controlled properly, access to rt scheduling is no more
dangerous (and probably less) than fork(), malloc() or mlock(), all of
which can lock up a machine efficiently if unlimited use is allowed.

	Jean-Marc
