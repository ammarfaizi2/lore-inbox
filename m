Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316883AbSILS06>; Thu, 12 Sep 2002 14:26:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316897AbSILS05>; Thu, 12 Sep 2002 14:26:57 -0400
Received: from pD9E23F87.dip.t-dialin.net ([217.226.63.135]:38373 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S316883AbSILS04>; Thu, 12 Sep 2002 14:26:56 -0400
Date: Thu, 12 Sep 2002 12:30:53 -0600 (MDT)
From: Thunder from the hill <thunder@lightweight.ods.org>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Giuliano Pochini <pochini@shiny.it>
cc: Jim Sibley <jlsibley@us.ibm.com>, Troy Reed <tdreed@us.ibm.com>,
       <ltc@linux.ibm.com>, <riel@conectiva.com.br>,
       <linux-kernel@vger.kernel.org>
Subject: RE: Killing/balancing processes when overcommited
In-Reply-To: <XFMail.20020912092526.pochini@shiny.it>
Message-ID: <Pine.LNX.4.44.0209121223470.10048-100000@hawkeye.luckynet.adm>
X-Location: Dorndorf/Steudnitz; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 12 Sep 2002, Giuliano Pochini wrote:
> It's not difficult to make the kerner choose the right processes
> to kill. It's impossible.

Not quite. But it's expensive. It adds 4 bytes per task, plus a second 
OOM killer.

> Imagine that when it goes oom the system stops and asks you what
> processes have to be killed. What do you kill ?

Rather whom would you ask?

> Probably we do need an oomd that the sysadmin can configure as he likes.

That's bad, it could get killed. ;-)

Mostly the mem eaters are those who hang in an malloc() deadloop.

	char *x = NULL;

	/*
	 * We need this variable, so if we don't get it, we reallocate it 
	 * regardless of what happened.
	 */
	do {
		x = malloc(X_SIZE);
	} while (!x);

That's possibly a candidate.

So if we just count how often per second that stubborn process uses 
malloc(), you'll catch the right guy most of the time. If you don't get 
a process that's over the threshold, do usual OOM killing...

			Thunder
-- 
--./../...-/. -.--/---/..-/.-./..././.-../..-. .---/..-/.../- .-
--/../-./..-/-/./--..-- ../.----./.-../.-.. --./../...-/. -.--/---/..-
.- -/---/--/---/.-./.-./---/.--/.-.-.-
--./.-/-.../.-./.././.-../.-.-.-

