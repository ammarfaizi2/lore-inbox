Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318896AbSIIUfC>; Mon, 9 Sep 2002 16:35:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318912AbSIIUe5>; Mon, 9 Sep 2002 16:34:57 -0400
Received: from mx2.elte.hu ([157.181.151.9]:30107 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S318884AbSIIUes>;
	Mon, 9 Sep 2002 16:34:48 -0400
Date: Mon, 9 Sep 2002 22:43:51 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Daniel Jacobowitz <dan@debian.org>
Cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: do_syslog/__down_trylock lockup in current BK
In-Reply-To: <20020909201516.GA7465@nevyn.them.org>
Message-ID: <Pine.LNX.4.44.0209092243160.19642-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the following assert triggers and catches the lockup:

--- linux/kernel/exit.c.orig	Mon Sep  9 21:59:24 2002
+++ linux/kernel/exit.c	Mon Sep  9 22:38:44 2002
@@ -461,6 +461,8 @@
 		ptrace_unlink (p);
 
 		list_del_init(&p->sibling);
+		if (p->parent == father && p->parent == p->real_parent)
+			BUG();
 		p->parent = p->real_parent;
 		list_add_tail(&p->sibling, &p->parent->children);
 	}

so somehow we can end up having parent == real_parent?

	Ingo

