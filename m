Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263142AbTCWSyI>; Sun, 23 Mar 2003 13:54:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263144AbTCWSyI>; Sun, 23 Mar 2003 13:54:08 -0500
Received: from pimout3-ext.prodigy.net ([207.115.63.102]:46061 "EHLO
	pimout3-ext.prodigy.net") by vger.kernel.org with ESMTP
	id <S263142AbTCWSyH>; Sun, 23 Mar 2003 13:54:07 -0500
Message-Id: <200303231905.h2NJ57OU665784@pimout3-ext.prodigy.net>
Content-Type: text/plain; charset=US-ASCII
From: dan carpenter <d_carpenter@sbcglobal.net>
To: Brian Gerst <bgerst@didntduck.org>, Thomas Molina <tmolina@cox.net>,
       <jsimmons@infradead.org>
Subject: Re: sleeping function call in 2.5.65-bk
Date: Sun, 23 Mar 2003 02:44:25 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0303230958450.891-100000@localhost.localdomain> <3E7DE12C.2020301@quark.didntduck.org>
In-Reply-To: <3E7DE12C.2020301@quark.didntduck.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 23 March 2003 05:30 pm, Brian Gerst wrote:
>
> The fbcon driver is calling kmalloc in interrupt context without
> GFP_ATOMIC.

Good call.  This is compile tested only.

regards,
dan carpenter

--- drivers/video/console/fbcon.c.orig  2003-03-23 02:39:23.000000000 +0100
+++ drivers/video/console/fbcon.c       2003-03-23 02:40:39.000000000 +0100
@@ -985,8 +985,8 @@
 
        size = ((width + 7) >> 3) * height;
 
-       data = kmalloc(size, GFP_KERNEL);
-       mask = kmalloc(size, GFP_KERNEL);
+       data = kmalloc(size, GFP_ATOMIC);
+       mask = kmalloc(size, GFP_ATOMIC);
        
        if (cursor->set & FB_CUR_SETSIZE) {
                memset(data, 0xff, size);
