Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266349AbUHBIPL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266349AbUHBIPL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 04:15:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266351AbUHBIPL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 04:15:11 -0400
Received: from main.gmane.org ([80.91.224.249]:30374 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S266349AbUHBIPD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 04:15:03 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@kth.se>
Subject: Re: Oops in register_chrdev, what did I do?
Date: Mon, 02 Aug 2004 10:15:05 +0200
Message-ID: <yw1xzn5eyn06.fsf@kth.se>
References: <yw1xwu0i1vcp.fsf@kth.se> <20040801200919.5da16bc7.Tommy.Reynolds@MegaCoder.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 161.80-203-29.nextgentel.com
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
Cancel-Lock: sha1:JoDY5qcYpt4n4MssIvjUrwi0mes=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tommy Reynolds <Tommy.Reynolds@MegaCoder.com> writes:

> Uttered Måns Rullgård <mru@kth.se>, spake thus:
>
>> While experimenting a bit with a small kernel module, I got this
>> oops.  Digging further, I found that /proc/devices had an entry saying
>> 248 <NULL>
>> which would indicate that I passed a NULL name to register_chrdev(),
>> only I didn't.  I used a string constant, so I can't see what changed
>> it to NULL along the way.
>> 
>> What am I missing here?
>
> Enough information for us to help you.  Show us your code snippet,
> please.

I can't imagine that the details of the fops functions are a problem,
since they never get called.

static struct file_operations foo_fops = {
    .owner   = THIS_MODULE,
    .open    = foo_open,
    .read    = foo_read,
    .write   = foo_write,
    .mmap    = foo_mmap,
    .release = foo_release
};

static int __init
init_foo(void)
{
    int err;

    err = register_chrdev(foo_major, "foo", &foo_fops);
    if(err)
	return err;

    return 0;
}

static void __exit
exit_foo(void)
{
    unregister_chrdev(foo_major, "foo");
}

module_init(init_foo);
module_exit(exit_foo);
MODULE_LICENSE("GPL");

-- 
Måns Rullgård
mru@kth.se

