Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317697AbSGUP6T>; Sun, 21 Jul 2002 11:58:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317698AbSGUP6S>; Sun, 21 Jul 2002 11:58:18 -0400
Received: from smtpde01.sap-ag.de ([155.56.68.140]:52140 "EHLO
	smtpde01.sap-ag.de") by vger.kernel.org with ESMTP
	id <S317697AbSGUP6S>; Sun, 21 Jul 2002 11:58:18 -0400
X-Gnus-Agent-Meta-Information: mail nil
From: Christoph Rohland <cr@sap.com>
To: torvalds@transmeta.com (Linus Torvalds)
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 'select' failure or signal should not update timeout
References: <200207190952.g6J9q4I07044@sic.twinsun.com>
	<200207200038.g6K0cZO12086@devserv.devel.redhat.com>
	<ahau4q$1n2$1@penguin.transmeta.com>
Organisation: Development SAP J2EE Engine
In-Reply-To: <ahau4q$1n2$1@penguin.transmeta.com>
Message-ID: <u1mug2ii.fsf@sap.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp (Windows [3]))
Date: 21 Jul 2002 18:00:35 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SAP: out
X-SAP: out
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Sat, 20 Jul 2002, Linus Torvalds wrote:
> The thing is, nobody should really ever use timeouts, because the
> notion of "I want to sleep X seconds" is simply not _useful_ if the
> process also just got delayed by a page-out event as it said so.
> What does "X seconds" mean at that point? It's ambiguous - and the
> kernel will (quite naturally) just always assume that it is "X
> seconds from when the kernel got notified".
>
> A _useful_ interface would be to say "I want to sleep to at most
> time X" or "to at least time X".  Those are unambiguous things to
> say, and are not open to interpretation.

Yes, so everybody really using select assumes it's _at least_ X
seconds... So where's the problem? I always know it's at least in a
multiprocess environment. (At least as long as I do not want to fiddle
with scheduling and priorities)

> The Linux behaviour of modifying the timeout is a half-assed try for
> restartability, but the problem is that (a) nobody else does that or
> expects it to happen, despite the man-pages originally claiming that
> they were supposed to and (b) it inherently has rounding problems
> and other ambiguities - making it even less useful.

Yes, and probably select is one of the calls you most of the time use
because of portability. So IMHO a linuxism isn't worth the effort.

Greetings
		Christoph


