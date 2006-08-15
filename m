Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030438AbWHOSVa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030438AbWHOSVa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 14:21:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030439AbWHOSVa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 14:21:30 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:9694 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1030438AbWHOSV3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 14:21:29 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>,
       Linux Containers <containers@lists.osdl.org>,
       Oleg Nesterov <oleg@tv-sign.ru>
Subject: Start using struct pid.
Date: Tue, 15 Aug 2006 12:21:11 -0600
Message-ID: <m1k65997xk.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In the last round of cleaning up the pid hash table a more
general struct pid was introduced, that can be referenced
counted.

With the more general struct pid most if not all places where
we store a pid_t we can now store a struct pid * and remove
the need for a hash table lookup, and avoid any possible problems
with pid roll over.

Looking forward to the pid namespaces struct pid * gives us
an absolute form a pid so we can compare and use them without
caring which pid namespace we are in.

This patchset introduces the infrastructure needed to use
struct pid instead of pid_t, and then it goes on to convert
two different kernel users that currently store a pid_t value.

There are a lot more places to go but this is enough to get the
basic idea. 

Before we can merge a pid namespace patch all of the kernel pid_t
users need to be examined.  Those that deal with user space processes
need to be converted to using a struct pid *.  Those that deal with
kernel processes need to converted to using the kthread api.  A rare
few that only use their current processes pid values get to be left
alone.

Eric
