Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263039AbVG3L2X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263039AbVG3L2X (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 07:28:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263052AbVG3L2W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 07:28:22 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:12250 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S263039AbVG3L1g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 07:27:36 -0400
Date: Sat, 30 Jul 2005 13:22:42 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Christoph Lameter <christoph@lameter.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH 2/4] Task notifier against mm: Implement todo list in task_struct
Message-ID: <20050730112241.GA1830@elf.ucw.cz>
References: <Pine.LNX.4.62.0507291328170.5304@graphe.net> <Pine.LNX.4.62.0507291332100.5304@graphe.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0507291332100.5304@graphe.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Introduce a todo notifier in the task_struct so that a task can be told to do
> certain things. Abuse the suspend hooks try_to_freeze, freezing and refrigerator
> to establish checkpoints where the todo list is processed. This will break software
> suspend (next patch fixes and cleans up software suspend).

VERSION = 2
PATCHLEVEL = 6
SUBLEVEL = 13
EXTRAVERSION =-rc3-mm3

This patch fails:

pavel@amd:/usr/src/linux-mm$ cat /tmp/delme | patch -Esp1
1 out of 3 hunks FAILED -- saving rejects to file include/linux/sched.h.rej
pavel@amd:/usr/src/linux-mm$

No wonder when -mm already contains:

/*
 * Check if there is a request to freeze a process
 */
static inline int freezing(struct task_struct *p)
{
        return test_ti_thread_flag(p->thread_info, TIF_FREEZE);
}
	
									Pavel

-- 
teflon -- maybe it is a trademark, but it should not be.
