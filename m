Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264027AbTCXBQi>; Sun, 23 Mar 2003 20:16:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264029AbTCXBQi>; Sun, 23 Mar 2003 20:16:38 -0500
Received: from [218.70.98.78] ([218.70.98.78]:57365 "EHLO debian")
	by vger.kernel.org with ESMTP id <S264027AbTCXBQh>;
	Sun, 23 Mar 2003 20:16:37 -0500
Message-ID: <3E7E60DA.6030000@farstone.com>
Date: Mon, 24 Mar 2003 09:35:22 +0800
From: dave young <Young@farstone.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; zh-CN; rv:1.1) Gecko/20020826
X-Accept-Language: zh-cn
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: loop's kernel_thread
References: <3E7E0B37.5060505@portrix.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi all
    I'm being  modified loop block device driver for multi files binded 
to one loop device,
but the loop_thread sometimes seems locking the kernel.

static int loop_thread(void *data)
{
        struct loop_device *lo = data;
        struct buffer_head *bh;

        daemonize();
        exit_files(current);

        printk(KERN_INFO "i am here\n");
        sprintf(current->comm, "loop%i", lo->lo_number);

        spin_lock_irq(&current->sigmask_lock);
        sigfillset(&current->blocked);
        flush_signals(current);
        spin_unlock_irq(&current->sigmask_lock);

        current->policy = SCHED_OTHER;
        current->nice = -20;
.....
}
        It seems that  process name is still "mount" .It should be 
"loop0,loop1,etc.", isn't it?

        Anyone can help me?

