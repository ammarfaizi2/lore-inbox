Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262219AbTEEQHx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 12:07:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262490AbTEEQHx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 12:07:53 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:55189 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S262219AbTEEQHv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 12:07:51 -0400
Date: Mon, 5 May 2003 12:20:21 -0400 (EDT)
From: Ingo Molnar <mingo@redhat.com>
X-X-Sender: mingo@devserv.devel.redhat.com
To: linux-kernel@vger.kernel.org
Subject: [patch] exec-shield-2.4.21-rc1-C5
In-Reply-To: <Pine.LNX.4.44.0305021217090.17548-100000@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.4.44.0305050632590.552-100000@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


a new (-C5) release of the exec-shield patch can be found at:

 	http://redhat.com/~mingo/exec-shield/exec-shield-2.4.21-rc1-C5

Changes since -B6:

 - removed the X_workaround - chstk can be used for equivalent 
   functionality. (issue raised by Yoav Weiss)

 - increase SHLIB_BASE from 1MB to 1MB + 64KB, suggested by Alexandre 
   Julliard, to fix DOS loaders.

 - fix Pentium/i386 compilation failure in fault.c. (reported by Johannes 
   Walch)
   
 - fix signal return bug, found by pageexec@freemail.hu.

 - shared library address randomization, both within and outside the
   ASCII-shield. This should make remote attacks a little bit more
   difficult.

 - process stack randomization. A number of other patches did this as
   well, it generally helps. (There's no memory wasted because the stack
   area left out will simply not be paged in.)

 - turn off shlib relocation if the stack is executable. This is needed
   for Wine, qemu and other apps that need the low memory range.

 - do not show the wchan field of non-owned processes, and do not show the
   maps file either. This should make it a little bit harder to guess
   library locations for local attackers.

most of the new stuff in this patch (randomization, information filtering)  
has been done in other patches as well (such as PaX, grsecurity, non-exec
stack patch, etc.) - i tried to filter out and add the ones that matter
most, do not introduce constraints and are thus uncontroversial.

bug reports, suggestions welcome.

	Ingo

