Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261634AbVGZRT4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261634AbVGZRT4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 13:19:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261820AbVGZRTz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 13:19:55 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:6023 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261634AbVGZRTz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 13:19:55 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/23] reboot-fixes
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Tue, 26 Jul 2005 11:19:17 -0600
Message-ID: <m1mzo9eb8q.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The reboot code paths seems to be suffering from 15 years of people
only looking at the code when it breaks.  The result is there
are several code paths in which different callers expect different
semantics from the same functions, and a fair amount of imperfect
inline replication of code.

For a year or more every time I fix one bug in the bug fix reveals yet
another bug.  In an attempt to end the cycle of bug fixes revealing
yet more bugs I have generated a series of patches to clean up
the semantics along the reboot path.

With the callers all agreeing on what to expect from the functions
they call it should at least be possible to kill bugs without
more showing up because of the bug fix.

My primary approach is to factor sys_reboot into several smaller
functions and provide those functions for the general kernel
consumers instead of the architecture dependent restart and
halt hooks.

I don't expect this to noticeably fix any bugs along the
main code paths but magic sysrq and several of the more obscure
code paths should work much more reliably.

Eric
