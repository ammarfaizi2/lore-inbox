Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275680AbRJUI1T>; Sun, 21 Oct 2001 04:27:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275709AbRJUI1K>; Sun, 21 Oct 2001 04:27:10 -0400
Received: from colorfullife.com ([216.156.138.34]:23813 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S275680AbRJUI06>;
	Sun, 21 Oct 2001 04:26:58 -0400
Message-ID: <002001c15a0a$41a0baf0$010411ac@local>
From: "Manfred Spraul" <manfred@colorfullife.com>
To: "Ken Ashcraft" <kash@stanford.edu>, <linux-kernel@vger.kernel.org>
Cc: <mc@cs.Stanford.EDU>
In-Reply-To: <Pine.GSO.4.33.0110202220470.963-100000@saga5.Stanford.EDU>
Subject: Re: [CHECKER] Probable Security Errors in 2.4.12-ac3
Date: Sun, 21 Oct 2001 10:08:29 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MIMEOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Ken Ashcraft" <kash@stanford.edu>
> [BUG] minor, loops on len
> /home/kash/linux/2.4.12/ipc/msg.c:788:sys_msgrcv: ERROR:RANGE:756:788: Using user length "msgsz" as argument to "store_msg"
[type=GLOBAL] [state = need_ub] set by 'user-originated parameter':756 [distance=81]
>
> ss_wakeup(&msq->q_senders,0);
> msg_unlock(msqid);
> out_success:
> msgsz = (msgsz > msg->m_ts) ? msg->m_ts : msgsz;
> if (put_user (msg->m_type, &msgp->mtype) ||
> Error --->
>     store_msg(msgp->mtext, msg, msgsz)) {
>     msgsz = -EFAULT;
> }
> free_msg(msg);

That's not a bug:
* msgsz is limited to msg->m_ts (2 lines above store_msg)
* msg->m_ts is set by sys_msgsnd to msgsz, and that function rejects messages longer than msg_ctlmax.

--
    Manfred

