Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262306AbTINFQa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Sep 2003 01:16:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262307AbTINFQa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Sep 2003 01:16:30 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:24843
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id S262306AbTINFQ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Sep 2003 01:16:27 -0400
Date: Sat, 13 Sep 2003 21:58:41 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Erik Andersen <andersen@codepoet.org>
cc: linux-kernel@vger.kernel.org
Subject: freed_symbols [Re: People, not GPL  [was: Re: Driver Model]]
In-Reply-To: <20030914043716.GA19223@codepoet.org>
Message-ID: <Pine.LNX.4.10.10309132152510.16744-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Pretty Boy,

It is coming and the intent is to return all the stolen symbols.
It is free for anyone to use and enjoy the usage of Linux once again.
So everyone get in line and SUE ME for GPL'ed drivers.


/*
 * Original copyright notice:
 *
 * linux/kernel/freed_symbols.c
 *
 * Copyright (C) 2001-2003              Linux ATA Development
 *                                      Andre Hedrick <andre@linux-ide.org>
 *
 * GPL v2 and only version 2.
 */

/*
 * kernel/signal.c:EXPORT_SYMBOL_GPL(dequeue_signal);
 * returned to kernel API
 */
int freed_dequeue_signal(sigset_t *mask, siginfo_t *info)
{
        return dequeue_signal(mask, info);
}

EXPORT_SYMBOL(freed_dequeue_signal);

/*
 * was kernel/context.c
 *
 * kernel/workqueue.c:EXPORT_SYMBOL_GPL(create_workqueue);
 * kernel/workqueue.c:EXPORT_SYMBOL_GPL(queue_work);
 * kernel/workqueue.c:EXPORT_SYMBOL_GPL(queue_delayed_work);
 * kernel/workqueue.c:EXPORT_SYMBOL_GPL(flush_workqueue);
 * kernel/workqueue.c:EXPORT_SYMBOL_GPL(destroy_workqueue);
 * returned to kernel API
 */

struct workqueue_struct *freed_create_workqueue(const char *name)
{
        return create_workqueue(name);
}

int freed_queue_work(struct workqueue_struct *wq, struct work_struct *work)
{
        return queue_work(wq, work);
}

int freed_queue_delayed_work(struct workqueue_struct *wq,
                struct work_struct *work, unsigned long delay)
{
        return queue_delayed_work(wq, work, delay);
}

void freed_flush_workqueue(struct workqueue_struct *wq)
{
        flush_workqueue(wq);
}

void freed_destroy_workqueue(struct workqueue_struct *wq)
{
        destroy_workqueue(wq);
}

EXPORT_SYMBOL(freed_create_workqueue);
EXPORT_SYMBOL(freed_queue_work);
EXPORT_SYMBOL(freed_queue_delayed_work);
EXPORT_SYMBOL(freed_flush_workqueue);
EXPORT_SYMBOL(freed_destroy_workqueue);


static int freed_symbols_ioctl (struct inode *inode, struct file *file, unsigned int cmd, unsigned long arg)
{
        if (!capable(CAP_SYS_ADMIN))
                return -EACCES;

        switch (cmd) {
                default:
                        return -EINVAL;
        }
        return 0;
}

static int freed_symbols_open (struct inode *inode, struct file *file)
{
        return 0;
}

static int freed_symbols_release (struct inode *inode, struct file *file)
{
        return 0;
}

static struct file_operations freed_symbols_fops = {
        owner:          THIS_MODULE,
        ioctl:          freed_symbols_ioctl,
        open:           freed_symbols_open,
        release:        freed_symbols_release,
};

static struct miscdevice freed_symbols_dev = {  FREED_SYMBOLS_MINOR,
                                                "freed_symbols",
                                                &freed_symbols_fops };

static void __exit freed_symbols_exit (void)
{
        printk(KERN_INFO "freed_symbols_module: unloaded.\n");
//      remove_proc_entry("driver/freed_symbols", NULL);
        misc_deregister(&freed_symbols);
}

int __init freed_symbols_init (void)
{
        printk(KERN_INFO "freed_symbols_module: loaded.\n");
        misc_register(&freed_symbols_dev);
//      create_proc_read_entry("driver/freed_symbols", 0, 0, freed_symbols_read_proc, NULL);
        return 0;
}

MODULE_LICENSE("GPL");
module_init(freed_symbols_init);
module_exit(freed_symbols_exit);


-------------------------------------------

Cheers,

Andre Hedrick
LAD Storage Consulting Group


