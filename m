Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932385AbWCGBJ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932385AbWCGBJ1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 20:09:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932580AbWCGBJ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 20:09:27 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:49073 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932385AbWCGBJ1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 20:09:27 -0500
Date: Mon, 6 Mar 2006 17:09:19 -0800
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: jesper.juhl@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: initcall at ... returned with error code -19 (Was: Re:
 2.6.16-rc5-mm2)
Message-Id: <20060306170919.0fcd8566.pj@sgi.com>
In-Reply-To: <20060306140851.4140ae2b.akpm@osdl.org>
References: <9a8748490603061359r64655a45i9a26e1f92009c7bf@mail.gmail.com>
	<20060306140851.4140ae2b.akpm@osdl.org>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew wrote:
> That's OK - it's -ENODEV. 

I can't help but wonder if the particular case of -ENODEV should
be kept quiet, as in the following totally untested patch:

diff -Naurp 2.6.16-rc5-mm2.orig/init/main.c 2.6.16-rc5-mm2/init/main.c
--- 2.6.16-rc5-mm2.orig/init/main.c	2006-03-06 17:02:46.491860190 -0800
+++ 2.6.16-rc5-mm2/init/main.c	2006-03-06 17:07:29.754830844 -0800
@@ -608,7 +608,8 @@ static void __init do_initcalls(void)
 
 		result = (*call)();
 
-		if (result) {
+		/* don't mind -ENODEV - just a driver w/o hardware */
+		if (result && result != -ENODEV) {
 			sprintf(msgbuf, "error code %d", result);
 			msg = msgbuf;
 		}

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
