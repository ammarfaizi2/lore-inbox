Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261267AbVBBEms@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261267AbVBBEms (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 23:42:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261395AbVBBEms
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 23:42:48 -0500
Received: from fw.osdl.org ([65.172.181.6]:48587 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261267AbVBBEmg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 23:42:36 -0500
Date: Tue, 1 Feb 2005 23:29:24 -0800
From: Andrew Morton <akpm@osdl.org>
To: Zhonglin Zhang <zhonglinzh@mobilesoft.com.cn>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc2-mm2 modules can't be loaded correctly!
Message-Id: <20050201232924.0610dc96.akpm@osdl.org>
In-Reply-To: <1107309228.677.5.camel@milo>
References: <1107309228.677.5.camel@milo>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zhonglin Zhang <zhonglinzh@mobilesoft.com.cn> wrote:
>
> Hi, Andrew 
> 
>     Could you please check it ? I have worked out my little patch to fix
> it. But not any feedback.  Is it ok in your machine which is not-SMP?
> 

--- 25/include/linux/stop_machine.h~fix-kallsyms-insmod-rmmod-race-fix-fix-fix	2005-01-29 16:17:47.936137064 -0800
+++ 25-akpm/include/linux/stop_machine.h	2005-01-29 16:18:09.493859792 -0800
@@ -57,7 +57,7 @@ static inline int stop_machine_run(int (
 static inline int stop_machine_run(int (*fn)(void *), void *data,
 				   unsigned int cpu)
 {
-	return 0;
+	return fn(data);
 }
 
 #endif	/* CONFIG_STOP_MACHINE */
_

