Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129870AbQKJHWn>; Fri, 10 Nov 2000 02:22:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130152AbQKJHWd>; Fri, 10 Nov 2000 02:22:33 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:49167 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S129870AbQKJHWQ>;
	Fri, 10 Nov 2000 02:22:16 -0500
Message-ID: <3A0BA1F8.E3ABCD18@mandrakesoft.com>
Date: Fri, 10 Nov 2000 02:21:28 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: jiffies wrap question...
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following is a piece of code from the latter half of
schedule_timeout, in kernel/sched.c.  Is it possible that
schedule_timeout could return an incorrect value, if the jiffy value
wraps between the first and last lines shown below.

        expire = timeout + jiffies;

        init_timer(&timer);
        timer.expires = expire;
        timer.data = (unsigned long) current;
        timer.function = process_timeout;

        add_timer(&timer);
        schedule();
        del_timer_sync(&timer);

        timeout = expire - jiffies;


-- 
Jeff Garzik             |
Building 1024           | Would you like a Twinkie?
MandrakeSoft            |
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
