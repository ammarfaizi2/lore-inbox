Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284610AbRLIXFj>; Sun, 9 Dec 2001 18:05:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284604AbRLIXFa>; Sun, 9 Dec 2001 18:05:30 -0500
Received: from zero.tech9.net ([209.61.188.187]:30982 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S284613AbRLIXFT>;
	Sun, 9 Dec 2001 18:05:19 -0500
Subject: Re: [PATCH] Make highly niced processes run only when idle
From: Robert Love <rml@tech9.net>
To: Anthony DeRobertis <asd@suespammers.org>
Cc: root <r6144@263.net>, linux-kernel@vger.kernel.org
In-Reply-To: <75F30A52-ECF4-11D5-80FE-00039355CFA6@suespammers.org>
In-Reply-To: <75F30A52-ECF4-11D5-80FE-00039355CFA6@suespammers.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.0.99+cvs.2001.12.06.08.57 (Preview Release)
Date: 09 Dec 2001 18:05:13 -0500
Message-Id: <1007939114.878.1.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2001-12-09 at 17:31, Anthony DeRobertis wrote:

> One of two things:
> 	1) The higher priority task will no longer be runnable; or
> 	2) We gave enough rope to hang yourself, and, well, you did.

and (3) the lower priority task won't be runnable either.

Without addressing this (and it is addressable, see below) this feature
won't make it into the kernel.  It isn't an argument to say "we gave you
the rope and you took it" because if I idle task some random application
because it deserves little time, I shouldn't have to think of what
resource/kernel semantics it and another task are going to get into a
priority inversion fight over.

I've seen a few solutions.  The easiest is to just give idle tasks a
"boost" on occasion to give them a chance to prevent the deadlock.  You
then, however, have the problem where the tasks can take advantage of
the boost...  Or, we could fix in-kernel deadlocks by doing priority
inheriting on locks held by A and wanted by B (i.e., if A holds
something B wants, boost A's priority temporarily to that of B's).  But
that is probably overkill ... note to do any of these it is probably
cleanest to make a SCHED_IDLE scheduling class.

maybe I'll put a patch together ...

	Robert Love

