Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751876AbWGARNt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751876AbWGARNt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 13:13:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751877AbWGARNt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 13:13:49 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:33180 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751876AbWGARNt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 13:13:49 -0400
Subject: [patch 0/2] sLeAZY FPU feature
From: Arjan van de Ven <arjan@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, ak@suse.de
Content-Type: text/plain
Date: Sat, 01 Jul 2006 19:11:33 +0200
Message-Id: <1151773893.3195.45.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

the two patches in this series (the x86-64 on by me, the i386 one by
Chuck Ebbert) change how the lazy fpu feature works. In the current
situation, we are 100% lazy, meaning that after every context switch,
the application takes a trap on the first FPU use, which then restores
the FPU context.

The sLeAZY FPU patch changes this behavior; if a process has used the
FPU for 5 stints at a row, the behavior becomes proactive and the FPU
context is restored during the regular context switch already. This
means we can avoid the trap.

The underlying assumption is that if a process uses 5 times consecutive,
it's likely to do it the 6th and later times as well (eg it's not a
one-off behavior).

There is a limit built in; this proactive behavior resets after 255
times, so that when a process is long lived and chances behavior, it'll
still get the right behavior (for performance) after some time.

Chuck measured a +/- 0.4% performance gain, and my experiments show a
similar improvement.

Greetings,
   Arjan van de Ven

