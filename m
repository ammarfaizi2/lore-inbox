Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129614AbRBQTkt>; Sat, 17 Feb 2001 14:40:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129489AbRBQTkk>; Sat, 17 Feb 2001 14:40:40 -0500
Received: from web1304.mail.yahoo.com ([128.11.23.154]:9487 "HELO
	web1304.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S129837AbRBQTk1>; Sat, 17 Feb 2001 14:40:27 -0500
Message-ID: <20010217194023.29754.qmail@web1304.mail.yahoo.com>
Date: Sat, 17 Feb 2001 11:40:23 -0800 (PST)
From: Mark Swanson <swansma@yahoo.com>
Subject: Re: System V msg queue bugs in latest kernels
To: Manfred Spraul <manfred@colorfullife.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3A8ECB1B.776D0372@colorfullife.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The exact error is in /usr/include/linux/msg.h

The three unsigned shorts should be unsigned int instead.
Would too many things break if this was changed?
Should user-space tools like ipcs be rewritten to use /proc/sysvipc
instead? (I notice that my old 2.2.14 kernel doesn't have
/proc/sysvipc...)

Thanks.

/* one msqid structure for each queue on the system */
struct msqid_ds {
    struct ipc_perm msg_perm;
    struct msg *msg_first;      /* first message on queue */
    struct msg *msg_last;       /* last message in queue */
    __kernel_time_t msg_stime;  /* last msgsnd time */
    __kernel_time_t msg_rtime;  /* last msgrcv time */
    __kernel_time_t msg_ctime;  /* last change time */
    struct wait_queue *wwait;
    struct wait_queue *rwait;
    unsigned short msg_cbytes;  /* current number of bytes on queue */
    unsigned short msg_qnum;    /* number of messages in queue */
    unsigned short msg_qbytes;  /* max number of bytes on queue */
    __kernel_ipc_pid_t msg_lspid;   /* pid of last msgsnd */
    __kernel_ipc_pid_t msg_lrpid;   /* last receive pid */
}; 




=====
A camel is ugly but useful; it may stink, and it may spit, but it'll get you where you're going. - Larry Wall -

__________________________________________________
Do You Yahoo!?
Get personalized email addresses from Yahoo! Mail - only $35 
a year!  http://personal.mail.yahoo.com/
