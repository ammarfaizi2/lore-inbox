Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271118AbTG1V6f (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 17:58:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271120AbTG1V6f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 17:58:35 -0400
Received: from fw.osdl.org ([65.172.181.6]:20901 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S271118AbTG1V6d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 17:58:33 -0400
Date: Mon, 28 Jul 2003 14:47:04 -0700
From: Andrew Morton <akpm@osdl.org>
To: Shawn <core@enodev.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test2-mm1: Can't mount root
Message-Id: <20030728144704.49c433bc.akpm@osdl.org>
In-Reply-To: <1059428584.6146.9.camel@localhost>
References: <1059428584.6146.9.camel@localhost>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shawn <core@enodev.com> wrote:
>
> I'm using ide=reverse, and my root is on hde5. 2.6.0-test1-mm2 finds my
> root fs fine using the init/do_mounts.c patch posted recently.
> 
> 2.6.0-test2-mm1 (in which said patch seems to have been included),
> however, fails on all of the following root= options:
>       * 2105
>       * /dev/ide/host2/bus0/target0/lun0/part5
>       * /dev/hde5
> 
> I don't know what to try next. Can someone enlighten me as to what has
> been happening lately?

Beats me.  Tried "/dev/hde/5" and "21:05"?

Can you see what this says?

 25-akpm/init/do_mounts.c |    1 +
 1 files changed, 1 insertion(+)

diff -puN init/do_mounts.c~a init/do_mounts.c
--- 25/init/do_mounts.c~a	Mon Jul 28 14:44:37 2003
+++ 25-akpm/init/do_mounts.c	Mon Jul 28 14:44:53 2003
@@ -74,6 +74,7 @@ static dev_t __init try_name(char *name,
 	/*
 	 * The format of dev is now %u:%u -- see print_dev_t()
 	 */
+	printk("scanning `%s'\n", buf);
 	if (sscanf(buf, "%u:%u", &maj, &min) == 2)
 		res = MKDEV(maj, min);
 	else

_

Also take a close look at the dmesg output, make sure that all the devices
and partitions are appearing in the expected places.


