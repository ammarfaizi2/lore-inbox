Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265256AbUATA7t (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 19:59:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265253AbUATA6c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 19:58:32 -0500
Received: from fw.osdl.org ([65.172.181.6]:46472 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263475AbUATA5Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 19:57:16 -0500
Date: Mon, 19 Jan 2004 16:57:30 -0800
From: Andrew Morton <akpm@osdl.org>
To: Thomas Molina <tmolina@cablespeed.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.6.1-mm4
Message-Id: <20040119165730.7f250869.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0401191912300.5662@localhost.localdomain>
References: <20040115225948.6b994a48.akpm@osdl.org>
	<Pine.LNX.4.58.0401191912300.5662@localhost.localdomain>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Molina <tmolina@cablespeed.com> wrote:
>
> Rusty, 
> 
> I updated mm4 with the patch you sent in response to my shutdown oops 
> report and haven't received a repeat oops in six reboots.  Hopefully this 
> cures my problem.  I previously couldn't reproduce the oops every single 
> reboot.  
> 
> I do have a couple of other anomalies to report though.
> 
> First is this snippet from my bootup log:
> 
> Cannot open master raw device '/dev/rawctl' (No such device)

Do you have

	alias char-major-162 raw

in /etc/modprobe.conf?

> WARNING: /lib/modules/2.6.1-mm4a/kernel/fs/nfsd/nfsd.ko needs unknown 
> symbol dnotify_parent
> 

Yup, this is fixed and it's all merged up.

diff -puN fs/dnotify.c~nfsd-04-add-dnotify-events-fix fs/dnotify.c
--- 25/fs/dnotify.c~nfsd-04-add-dnotify-events-fix	2004-01-16 08:42:25.000000000 -0800
+++ 25-akpm/fs/dnotify.c	2004-01-16 08:42:45.000000000 -0800
@@ -165,6 +165,7 @@ void dnotify_parent(struct dentry *dentr
 		spin_unlock(&dentry->d_lock);
 	}
 }
+EXPORT_SYMBOL_GPL(dnotify_parent);
 
 static int __init dnotify_init(void)
 {

_

