Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265227AbUGCWKP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265227AbUGCWKP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jul 2004 18:10:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265244AbUGCWKP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jul 2004 18:10:15 -0400
Received: from dbl.q-ag.de ([213.172.117.3]:12681 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S265227AbUGCWKL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jul 2004 18:10:11 -0400
Message-ID: <40E72EAE.2060806@colorfullife.com>
Date: Sun, 04 Jul 2004 00:09:50 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] cleanup of ipc/msg.c
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Attached is a cleanup of the main loops in sys_msgrcv and sys_msgsnd, 
based on ipc_lock_by_ptr(). Most backward gotos are gone, instead normal 
"for(;;)" loops until a suitable message is found.

Additionally, the patch
- reintroduces lockless receive, same implementation as in ipc/mqueue.c.
- fixes a rare BUG(): if queue settings are changed with 
msgctl(,IPC_SET,) while a thread is sleeping in msgrcv() and the queue 
is then destroyed with msgctl(,IPC_RMID,) before the sleeping thread 
noticed the new configuration, then the BUG() is line 764 would trigger.

Andrew, could you add it to -mm? If it's too large then I'll split out 
the bugfix, it's a oneliner [remove the BUG()].

Signed-Off-By: Manfred Spraul <manfred@colorfullife.com>
