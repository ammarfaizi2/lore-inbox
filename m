Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266149AbUIALng@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266149AbUIALng (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 07:43:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266169AbUIALnf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 07:43:35 -0400
Received: from f22.mail.ru ([194.67.57.55]:15881 "EHLO f22.mail.ru")
	by vger.kernel.org with ESMTP id S266149AbUIALnc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 07:43:32 -0400
From: Kirill Korotaev <kksx@mail.ru>
To: akpm@osdl.org, torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] obscure pid implementation fix (v2)
Mime-Version: 1.0
X-Mailer: mPOP Web-Mail 2.19
X-Originating-IP: 192.168.0.129 via proxy [195.133.213.201]
Date: Wed, 01 Sep 2004 15:43:30 +0400
Reply-To: Kirill Korotaev <kksx@mail.ru>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E1C2TWU-0005Te-00.kksx-mail-ru@f22.mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I remade the previous patch against the latest Linus tree, please apply.

This patch fixes strange and obscure pid implementation in current kernels:
- it removes calling of put_task_struct() from detach_pid()
  under tasklist_lock. This allows to use blocking calls
  in security_task_free() hooks (in __put_task_struct()).
- it saves some space = 5*5 ints = 100 bytes in task_struct
- it's smaller and tidy, more straigthforward and doesn't use
  any knowledge about pids using and assignment.
- it removes pid_links and pid_struct doesn't hold reference counters
  on task_struct. instead, new pid_structs and linked altogether and
  only one of them is inserted in hash_list.

Signed-off-by: Kirill Korotaev (kksx@mail.ru)

Kirill

