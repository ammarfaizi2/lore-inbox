Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275230AbTHRWxY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 18:53:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275232AbTHRWxY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 18:53:24 -0400
Received: from mail.webmaster.com ([216.152.64.131]:14812 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP id S275230AbTHRWxW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 18:53:22 -0400
From: "David Schwartz" <davids@webmaster.com>
To: "Mike Fedyk" <mfedyk@matchmail.com>
Cc: "Hank Leininger" <hlein@progressive-comp.com>,
       <linux-kernel@vger.kernel.org>
Subject: RE: Dumb question: Why are exceptions such as SIGSEGV not logged
Date: Mon, 18 Aug 2003 15:53:17 -0700
Message-ID: <MDEHLPKNGKAHNMBLJOLKCEFNFDAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <20030818224409.GJ10320@matchmail.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mon, Aug 18, 2003 at 03:39:15PM -0700, David Schwartz wrote:

> > > And why not just catch the ones sent from the kernel?  That's
> > > the one that
> > > is killing the program because it crashed, and that's the one the
> > > origional
> > > poster wants logged...

> > 	Because sometimes a program wants to terminate. And it is
> > perfectly legal
> > for a programmer who needs to terminate his program as quickly
> > as possible
> > to do this:

> > char *j=NULL;
> > signal(SIGSEGV, SIG_DFL);
> > *j++;

> > 	This is a perfectly sensible thing for a program to do with
> > well-defined
> > semantics. If a program wants to create a child every minute
> > like this and
> > kill it, that's perfectly fine. We should be able to do that in
> > the default
> > configuration without a sysadmin complaining that we're DoSing
> > his syslogs.

> Are you saying that a signal requested from userspace uses the same code
> path as the signal sent when a process has overstepped its bounds?

	It depends what you mean by "requested".

> Surely some flag can be set so that we know the kernel is killing
> it because
> it did something illegal...

	It depends what you mean by "illegal".

	Dereferencing a NULL pointer deliberately to induce the kernel to kill your
process is indistinguishable from dereferencing a NULL pointer accidentally
and forcing the kernel to kill your process.

	These "illegal" operations have well-defined semantics that programmers can
use and rely on. Logging every such operation changes their semantics and
breaks programs that currently work -- breaks in the sense that they will
now DoS logs and result in admin complaints.

	The kernel cannot determine whether a SEGV or ILL was the result of a
deliberate attempt on the part of the programmer to create such a signal or
whether it's due to a programming error. Even an uncaught exception can be
used as a good way to terminate a process immediately (is there another
portable way to do that?).

	DS


