Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261630AbSJUUea>; Mon, 21 Oct 2002 16:34:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261638AbSJUUea>; Mon, 21 Oct 2002 16:34:30 -0400
Received: from w032.z064001165.sjc-ca.dsl.cnc.net ([64.1.165.32]:49988 "EHLO
	nakedeye.aparity.com") by vger.kernel.org with ESMTP
	id <S261630AbSJUUe2>; Mon, 21 Oct 2002 16:34:28 -0400
Date: Mon, 21 Oct 2002 13:48:51 -0700 (PDT)
From: "Matt D. Robinson" <yakker@aparity.com>
To: Christoph Hellwig <hch@sgi.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.44: lkcd (7/9): dump configuration
In-Reply-To: <20021021165240.A14993@sgi.com>
Message-ID: <Pine.LNX.4.44.0210211208150.22662-100000@nakedeye.aparity.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Oct 2002, Christoph Hellwig wrote:
|>> +tristate 'Crash dump support' CONFIG_CRASH_DUMP
|>
|>I"m very unhappy with this beeing a tristate.  We have the following
|>things depend on it either builtin or modular:
|>
|>(1) build Kerntypes
|>(2) do not send smp_stop_cpu
|>
|>and the following goes into dump.o:
|>
|>(3) dump_base.c
|>(4) dump_<arch>.c
|>
|>Of those (2) should be replaced by a dump_in_progress check so
|>that we poweroff even with dumping enabled, but not in progress.

There is the concept of non-distruptive dumping, which means
that you don't power off after a dump -- you keep running.  In
other words, you can silence the system and then resume after
a dump is taken.  It's a way of snapshotting the system state
which is possible today.

|>The question is whether we should make (1) unconditional either
|>or make it a separate bool (CONFIG_KERNELTYPES) so that that dump.o
|>could be load into any such kernel.  But imho CONFIG_CRASH_DUMP
|>should just become a bool - this way dump_<arch>.c could be moved
|>into arch/<arch>/kernel and a lot of exports could be remove.

Wow ... we spent a ton of time moving all the code _out_ of the
arch directories as other kernel developers didn't want it there.

|>It's not much code either and the actual dump drivers stay modular.

I realize what you're asking for, but I'm not sure this is the
right way to implement it.

>From one perspective, the base dump driver is needed in order to
provide the upper level dumping capabilities as well as some of
the architecture-specific functionality.  That said, however, if
you make it a bool, it's either on or off -- some people don't
want it in the kernel all the time, and shouldn't be required
to build in.

Maybe understanding that dumping can be non-disruptive changes
your opinion on this?

--Matt

