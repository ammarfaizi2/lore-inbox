Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262913AbTJaDn3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 22:43:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262937AbTJaDn3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 22:43:29 -0500
Received: from dp.samba.org ([66.70.73.150]:10661 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S262913AbTJaDn2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 22:43:28 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Takashi Iwai <tiwai@suse.de>
Cc: torvalds@osdl.org, akpm@zip.com.au, linux-kernel@vger.kernel.org
Subject: Re: MODULE_ALIAS patch for ALSA 
In-reply-to: Your message of "Thu, 30 Oct 2003 16:31:58 BST."
             <s5h7k2myc5t.wl@alsa2.suse.de> 
Date: Fri, 31 Oct 2003 13:21:26 +1100
Message-Id: <20031031034327.CAE282C0EF@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <s5h7k2myc5t.wl@alsa2.suse.de> you write:
> Hi Rusty,

Hi Takashi!

> while i've played with it, i found that the alias "char-major-14-*"
> and "char-major-116-*" don't work.  "char-major-14" and
> "char-major-116" do work well.  is it a known issue?
> the module-init-tools is 0.9.14-pre2, BTW.

Yep, there's one odd one out.  Thanks.

Linus, please apply.
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Name: request_module char devices fix
Author: Rusty Russell
Status: Trivial

D: Module aliases are all of form "char-major-<major>-<minor>".  char_dev.c
D: calls request_module with "char-major-<major>".

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .30462-linux-2.6.0-test9-bk4/fs/char_dev.c .30462-linux-2.6.0-test9-bk4.updated/fs/char_dev.c
--- .30462-linux-2.6.0-test9-bk4/fs/char_dev.c	2003-09-29 10:25:49.000000000 +1000
+++ .30462-linux-2.6.0-test9-bk4.updated/fs/char_dev.c	2003-10-31 13:20:49.000000000 +1100
@@ -434,7 +434,7 @@ void cdev_init(struct cdev *cdev, struct
 
 static struct kobject *base_probe(dev_t dev, int *part, void *data)
 {
-	request_module("char-major-%d", MAJOR(dev));
+	request_module("char-major-%d-%d", MAJOR(dev), MINOR(dev));
 	return NULL;
 }
 
