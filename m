Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292982AbSCDXOR>; Mon, 4 Mar 2002 18:14:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292991AbSCDXN0>; Mon, 4 Mar 2002 18:13:26 -0500
Received: from smtp4.vol.cz ([195.250.128.43]:7954 "EHLO majordomo.vol.cz")
	by vger.kernel.org with ESMTP id <S292984AbSCDXND>;
	Mon, 4 Mar 2002 18:13:03 -0500
Date: Mon, 4 Mar 2002 20:13:56 +0100
From: Pavel Machek <pavel@suse.cz>
To: kernel list <linux-kernel@vger.kernel.org>,
        Rusty trivial patch monkey Russell 
	<trivial@rustcorp.com.au>,
        patches@x86-64.org
Subject: pm storing void * in int
Message-ID: <20020304191356.GA12862@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

...which is no-no for 64bit apps. (In case you wonder, data in pm.c
is void *). Please apply,
									Pavel

--- linux/include/linux/pm.h	Thu Feb 28 23:14:54 2002
+++ linux.64/include/linux/pm.h	Mon Mar  4 19:58:01 2002
@@ -103,8 +103,8 @@
 	void		*data;
 
 	unsigned long	 flags;
-	int		 state;
-	int		 prev_state;
+	unsigned long	 state;
+	unsigned long	 prev_state;
 
 	struct list_head entry;
 };
--- linux/kernel/pm.c	Sat May  5 11:10:04 2001
+++ linux.64/kernel/pm.c	Mon Mar  4 19:58:12 2002
@@ -162,7 +162,7 @@
 	case PM_SUSPEND:
 	case PM_RESUME:
 		prev_state = dev->state;
-		next_state = (int) data;
+		next_state = (unsigned long) data;
 		if (prev_state != next_state) {
 			if (dev->callback)
 				status = (*dev->callback)(dev, rqst, data);

-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
