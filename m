Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750837AbVIHLxk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750837AbVIHLxk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 07:53:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750870AbVIHLxk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 07:53:40 -0400
Received: from mail.ccur.com ([208.248.32.212]:49207 "EHLO mail.ccur.com")
	by vger.kernel.org with ESMTP id S1750837AbVIHLxj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 07:53:39 -0400
Subject: strange signal on new clone creation under ptrace?
From: Tom Horsley <tom.horsley@ccur.com>
To: linux-kernel@vger.kernel.org
Cc: bugsy@ccur.com
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 08 Sep 2005 07:53:38 -0400
Message-Id: <1126180418.11585.12.camel@tweety>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm seeing this on a redhat enterprise 4 system (so the kernel is
older than dirt in lkml time :-), but I wondered if it might
strike a familiar note to anyone working on ptrace issues.

In my debugger, I'm following clone and fork creation around
to debug children using PTRACE_SETOPTIONS. Normally when I get
the waitpid() status for a new clone, it shows up with SIGSTOP
as the initial reported signal. My debugger is expecting this
and handles it no problem.

In a hairy complex threads program a user has (which is apparently
using SIGUSR1 a lot), the very first status that ever shows up for
a brand new clone reports SIGUSR1 rather than SIGSTOP.

When I teach the debugger to deal with that and get the new clone
started up, it immediately gets the SIGSTOP I didn't get on the
initial status.

I haven't been able to create any test program to reproduce this
behavior, so I have no idea how it could happen, but it appears
as though the kernel managed to queue up the signals in the wrong
order.

Does this sound like a bug anyone remembers fixing? Does anyone
have an idea how I could make it happen? Just curious about what
the heck could be going on here (I can probably teach the debugger
to work around this as well).

