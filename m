Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261376AbUKJIsQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261376AbUKJIsQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 03:48:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261415AbUKJIsQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 03:48:16 -0500
Received: from fw.osdl.org ([65.172.181.6]:19428 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261376AbUKJIsN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 03:48:13 -0500
Date: Wed, 10 Nov 2004 00:47:35 -0800
From: Andrew Morton <akpm@osdl.org>
To: Gerd Knorr <kraxel@bytesex.org>
Cc: markus@trippelsdorf.de, bunk@stusta.de, linux-kernel@vger.kernel.org,
       video4linux-list@redhat.com
Subject: Re: [patch] 2.6.10-rc1-mm4: bttv-driver.c compile error
Message-Id: <20041110004735.7982dc17.akpm@osdl.org>
In-Reply-To: <20041110082407.GA23090@bytesex>
References: <20041109074909.3f287966.akpm@osdl.org>
	<1100018489.7011.4.camel@lb.loomes.de>
	<20041109211107.GB5892@stusta.de>
	<1100037358.1519.6.camel@lb.loomes.de>
	<20041110082407.GA23090@bytesex>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gerd Knorr <kraxel@bytesex.org> wrote:
>
> > kobject_register failed for <NULL> (-17)
> 
>  IIRC there was a bug in the driver base and a patch from Gred fixing
>  that floating around, maybe that one helps?

err, yes.  Without that patch the kobject layer will scribble on memory and
all bets are off.

Try this:

--- a/lib/kobject.c	2004-11-09 12:09:33 -08:00
+++ b/lib/kobject.c	2004-11-09 12:09:33 -08:00
@@ -180,10 +180,10 @@
 
 	error = create_dir(kobj);
 	if (error) {
+		/* unlink does the kobject_put() for us */
 		unlink(kobj);
 		if (parent)
 			kobject_put(parent);
-		kobject_put(kobj);
 	} else {
 		kobject_hotplug(kobj, KOBJ_ADD);
 	}

