Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131164AbQLKXoh>; Mon, 11 Dec 2000 18:44:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130147AbQLKXoa>; Mon, 11 Dec 2000 18:44:30 -0500
Received: from h50s48a140n47.user.nortelnetworks.com ([47.140.48.50]:5035 "EHLO
	zrtps06s.us.nortel.com") by vger.kernel.org with ESMTP
	id <S129908AbQLKXoC>; Mon, 11 Dec 2000 18:44:02 -0500
Message-ID: <3A355E29.36A57B4C@asiapacificm01.nt.com>
Date: Mon, 11 Dec 2000 23:07:21 +0000
From: "Andrew Morton" <morton@nortelnetworks.com>
Organization: Nortel Networks, Wollongong Australia
X-Mailer: Mozilla 4.61 [en] (X11; I; Linux 2.4.0-test12-pre7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Mohammad A. Haque" <mhaque@haque.net>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Miles Lane <miles@megapathdsl.net>,
        Frank Davis <fdavis112@juno.com>, linux-kernel@vger.kernel.org
Subject: Re: INIT_LIST_HEAD marco audit
In-Reply-To: <E145SRT-0007sM-00@the-village.bc.nu> <3A34D455.7208BE2F@haque.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Orig: <morton@asiapacificm01.nt.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Mohammad A. Haque" wrote:
> 
> Thinko.
> 
> Question is... Adam Richter posted a patch for i2o_lan.c that does
> this...
> 
> static struct tq_struct i2o_post_buckets_task = {
>         list: LIST_HEAD_INIT(i2o_post_buckets_task.list),
>         sync: 0,
>         routine: (void (*)(void *))i2o_lan_receive_post,
>         data: (void *) 0
> };
> 

Will someone pleeeeze compile, test, use and submit this?

--- linux-2.4.0-test12-pre7/include/linux/tqueue.h	Mon Dec 11 13:21:04 2000
+++ linux/include/linux/tqueue.h	Tue Dec 12 10:03:51 2000
@@ -47,6 +47,16 @@
 #define DECLARE_TASK_QUEUE(q)	LIST_HEAD(q)
 #define TQ_ACTIVE(q)		(!list_empty(&q))
 
+#define INIT_TQ_STRUCT(routine, data)				\
+	{	list: LIST_HEAD_INIT(*(struct list_head *)0),	\
+		sync: 0,					\
+		routine: (routine),				\
+		data: (data),					\
+	}
+
+#define DECLARE_TQ_STRUCT(name, routine, data)			\
+	struct tq_struct name = INIT_TQ_STRUCT(routine, data)
+
 extern task_queue tq_timer, tq_immediate, tq_disk;
 
 /*
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
