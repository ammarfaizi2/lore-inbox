Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264067AbUE1Vrr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264067AbUE1Vrr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 17:47:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264012AbUE1Vrh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 17:47:37 -0400
Received: from elma.elma.fi ([192.89.233.77]:34553 "EHLO elma.elma.fi")
	by vger.kernel.org with ESMTP id S264076AbUE1Vq3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 17:46:29 -0400
Date: Sat, 29 May 2004 00:46:26 +0300 (EETDST)
From: Antti Lankila <alankila@elma.net>
To: linux-kernel@vger.kernel.org
Subject: Out of memory and overcommit_memory setting
Message-ID: <Pine.A41.4.58.0405290045330.125288@tokka.elma.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Firstly, I'd want you to look at these two results from the following
command, executed one after other:

% time perl -wle 'sub foo { foo() } foo()'
Deep recursion on subroutine "main::foo" at -e line 1.
zsh: terminated  perl -wle 'sub foo { foo() } foo()'
perl -wle 'sub foo { foo() } foo()'  2,19s user 1,17s system 40% cpu 8,355
total
% time perl -wle 'sub foo { foo() } foo()'
Deep recursion on subroutine "main::foo" at -e line 1.
Out of memory!
zsh: exit 1     perl -wle 'sub foo { foo() } foo()'
perl -wle 'sub foo { foo() } foo()'  2,97s user 1,27s system 4% cpu 1:26,54
total

The difference between wallclock time between the runs is an
order-of-magnitude kind. What changed was that the avove (the one which was
running shorter) was run with overcommit_memory enabled, while the latter
(the one that took 1min 26s to recover) was running with overcommit_memory
disabled (which is the default setting).

However, I prefer the former kind of behavoiur. What gives? Why is it better
to run overcommit_memory enabed than disabled?

My kernel is 2.6.5-1-686 as packaged by Debian Sarge.

-- 
Antti
