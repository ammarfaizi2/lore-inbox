Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261757AbSIPLyJ>; Mon, 16 Sep 2002 07:54:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261786AbSIPLyJ>; Mon, 16 Sep 2002 07:54:09 -0400
Received: from mail.parknet.co.jp ([210.134.213.6]:43789 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP
	id <S261757AbSIPLyI>; Mon, 16 Sep 2002 07:54:08 -0400
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>,
       Daniel Jacobowitz <drow@false.org>
Subject: Re: [PATCH] Fix for ptrace breakage
References: <Pine.LNX.4.44.0209161349270.29027-100000@localhost.localdomain>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Mon, 16 Sep 2002 20:58:53 +0900
In-Reply-To: <Pine.LNX.4.44.0209161349270.29027-100000@localhost.localdomain>
Message-ID: <87vg565eo2.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> writes:

> On Mon, 16 Sep 2002, OGAWA Hirofumi wrote:
> 
> > 	list_for_each(_p, &father->ptrace_children) {
> > 		p = list_entry(_p,struct task_struct,ptrace_list);
> > 		list_del_init(&p->ptrace_list);
> > 		reparent_thread(p, reaper, child_reaper);
> > 		if (p->parent != p->real_parent)
> > 			list_add(&p->ptrace_list, &p->real_parent->ptrace_children);
> > 	}
> > 
> > current->ptrace_children should be empty after this reparent.
> 
> oh, okay. It's also cleaner this way.

Grr, sorry. This patch is bad version.

 	list_for_each(_p, &father->ptrace_children) {

of course, this should

 	list_for_each_safe(_p, _n, &father->ptrace_children) {

I'll resend patch.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
