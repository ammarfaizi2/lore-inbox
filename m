Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261780AbTIUGrb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Sep 2003 02:47:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262339AbTIUGrb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Sep 2003 02:47:31 -0400
Received: from fw.osdl.org ([65.172.181.6]:6579 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261780AbTIUGr3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Sep 2003 02:47:29 -0400
Date: Sat, 20 Sep 2003 23:48:53 -0700
From: Andrew Morton <akpm@osdl.org>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] move some more intilization out of drivers/char/mem.c
Message-Id: <20030920234853.7e09f663.akpm@osdl.org>
In-Reply-To: <20030921063030.GA1508@lst.de>
References: <20030920132900.GC23153@lst.de>
	<20030920160645.30c2745d.akpm@osdl.org>
	<20030921063030.GA1508@lst.de>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@lst.de> wrote:
>
> > Please compile-test things...
> 
>  Well, I compiled this here.  I see, looks like I lost half of the patch
>  when sending it to you.  Sorryh for that, here's the full patch:

It still generates warnings.  I suggest you build kernels with a script
which saves up stderr and spits it all out at the end.  That way, these
things are noticed.



 drivers/char/random.c |    3 ++-
 drivers/char/tty_io.c |    3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff -puN drivers/char/random.c~char-init-cleanup-fix drivers/char/random.c
--- 25/drivers/char/random.c~char-init-cleanup-fix	2003-09-20 23:45:28.000000000 -0700
+++ 25-akpm/drivers/char/random.c	2003-09-20 23:45:46.000000000 -0700
@@ -1493,7 +1493,7 @@ static void init_std_data(struct entropy
 	}
 }
 
-static void __init rand_initialize(void)
+static int __init rand_initialize(void)
 {
 	int i;
 
@@ -1515,6 +1515,7 @@ static void __init rand_initialize(void)
 	memset(&mouse_timer_state, 0, sizeof(struct timer_rand_state));
 	memset(&extract_timer_state, 0, sizeof(struct timer_rand_state));
 	extract_timer_state.dont_count_entropy = 1;
+	return 0;
 }
 module_init(rand_initialize);
 
diff -puN drivers/char/tty_io.c~char-init-cleanup-fix drivers/char/tty_io.c
--- 25/drivers/char/tty_io.c~char-init-cleanup-fix	2003-09-20 23:45:35.000000000 -0700
+++ 25-akpm/drivers/char/tty_io.c	2003-09-20 23:46:06.000000000 -0700
@@ -2423,7 +2423,7 @@ static struct cdev vc0_cdev;
  * Ok, now we can initialize the rest of the tty devices and can count
  * on memory allocations, interrupts etc..
  */
-static void __init tty_init(void)
+static int __init tty_init(void)
 {
 	strcpy(tty_cdev.kobj.name, "dev.tty");
 	cdev_init(&tty_cdev, &tty_fops);
@@ -2512,5 +2512,6 @@ static void __init tty_init(void)
 #ifdef CONFIG_A2232
 	a2232board_init();
 #endif
+	return 0;
 }
 module_init(tty_init);

_

