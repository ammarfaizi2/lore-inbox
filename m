Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261350AbSIPLMN>; Mon, 16 Sep 2002 07:12:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261351AbSIPLMN>; Mon, 16 Sep 2002 07:12:13 -0400
Received: from mx2.elte.hu ([157.181.151.9]:7559 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S261350AbSIPLML>;
	Mon, 16 Sep 2002 07:12:11 -0400
Date: Mon, 16 Sep 2002 13:23:59 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>,
       Daniel Jacobowitz <drow@false.org>
Subject: Re: [PATCH] Fix for ptrace breakage
In-Reply-To: <87it16kxtp.fsf@devron.myhome.or.jp>
Message-ID: <Pine.LNX.4.44.0209161322260.28163-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> This patch fixes the following,
>
>    - race condition of ptrace flag
>    - sent odd signal to the tracer
>    - broken before behavior

(looks good to me). I'm wondering about the following:

-	while (!list_empty(&current->children))
-		zap_thread(list_entry(current->children.next,struct task_struct,sibling), current, 0);
-	while (!list_empty(&current->ptrace_children))
-		zap_thread(list_entry(current->ptrace_children.next,struct task_struct,ptrace_list), current, 1);
+	while ((p = eldest_child(current)) != NULL)
+		zap_thread(p, current);
 	BUG_ON(!list_empty(&current->children));

is it guaranteed that at this point current->ptrace_children is empty?

	Ingo

