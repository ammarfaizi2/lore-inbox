Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262817AbTK1RU6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Nov 2003 12:20:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263019AbTK1RU6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Nov 2003 12:20:58 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:8198 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S262817AbTK1RU5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Nov 2003 12:20:57 -0500
To: lkml-031128@amos.mailshell.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: 2.6test11 kernel panic on "head -1 /proc/net/tcp"
References: <20031128170138.9513.qmail@mailshell.com>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sat, 29 Nov 2003 02:20:41 +0900
In-Reply-To: <20031128170138.9513.qmail@mailshell.com>
Message-ID: <87d6bc2yvq.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

lkml-031128@amos.mailshell.com writes:

> "bad: scheduling while atomic!
> Call Trace:
>    schedule+0x55d/0x570

Does this patch fix this problem?

diff -puN net/ipv4/tcp_ipv4.c~tcp_seq-oops-fix net/ipv4/tcp_ipv4.c
--- linux-2.6.0-test11/net/ipv4/tcp_ipv4.c~tcp_seq-oops-fix	2003-11-29 00:52:15.000000000 +0900
+++ linux-2.6.0-test11-hirofumi/net/ipv4/tcp_ipv4.c	2003-11-29 00:52:28.000000000 +0900
@@ -2356,6 +2356,7 @@ static void *tcp_get_idx(struct seq_file
 static void *tcp_seq_start(struct seq_file *seq, loff_t *pos)
 {
 	struct tcp_iter_state* st = seq->private;
+	st->state = TCP_SEQ_STATE_LISTENING;
 	st->num = 0;
 	return *pos ? tcp_get_idx(seq, *pos - 1) : SEQ_START_TOKEN;
 }

_
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
