Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132759AbRDQQuo>; Tue, 17 Apr 2001 12:50:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132764AbRDQQuf>; Tue, 17 Apr 2001 12:50:35 -0400
Received: from mail.relex.ru ([213.24.247.153]:47378 "EHLO mail.relex.ru")
	by vger.kernel.org with ESMTP id <S132759AbRDQQua>;
	Tue, 17 Apr 2001 12:50:30 -0400
Content-Type: text/plain; charset=US-ASCII
From: Yaroslav Rastrigin <yarick@relex.ru>
Organization: RELEX Inc.
To: linux-kernel@vger.kernel.org
Subject: IPC usage inside of kernel module
Date: Tue, 17 Apr 2001 20:46:30 +0400
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01041720463000.28962@yarick>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everybody !

I needed to implement an IPC connectiovity between module and 
userspace daemon, and came to this horrible code (after looking to 
sys_msgsnd() ):
...
copy_to_user(msg_buf, &hlb1, sizeof(struct linfs_buffer));
hi1 = sys_ipc(MSGSND, msgq_id, message_size, 0, \
(struct msgbuf *)msg_buf,  0);
...
msg_buf is in userspace, hlb1 - module's prepared message (struct msgbuf ).
Well, it works :) . Messages are delivered,
but the whole construction looks rather ugly. The worst part of it is
sys_msgsnd() does then copy_from_user to kmalloc()'ed buffer, just to enqueue 
message. Can somebody tell me, is there any other way to implement IPC 
functionality , without rewriting sys_msgsnd() and accompanying functions 
(load_msg etc.) inside of my module ?

With all the best, yarick at relex dot ru 
