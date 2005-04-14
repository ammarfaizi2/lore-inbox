Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261482AbVDNMWY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261482AbVDNMWY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 08:22:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261484AbVDNMWY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 08:22:24 -0400
Received: from wproxy.gmail.com ([64.233.184.200]:51232 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261482AbVDNMWW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 08:22:22 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=NTAuQ91DM6faJFQ5Hh57wmWP6v2zooKZCSZpOTKoRwGHI8BQCZJvle1y+q1d9Tdz1euxQpez6mOkf39595zgHMkEqR/41rF68jVWtT/+906f/bQr60ZSGxPtgSZiFZpC0RSqJV6AlwFZDmwIg45W69jcst8jA/fKU3hrvl2zyQE=
Date: Thu, 14 Apr 2005 14:22:16 +0200
From: Diego Calleja <diegocg@gmail.com>
To: Iwan Sanders <iwan.sanders@tuxproject.info>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel messages
Message-Id: <20050414142216.2b2da0a0.diegocg@gmail.com>
In-Reply-To: <425E23CC.2010509@tuxproject.info>
References: <425E23CC.2010509@tuxproject.info>
X-Mailer: Sylpheed version 1.9.8 (GTK+ 2.6.2; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Thu, 14 Apr 2005 10:03:24 +0200,
Iwan Sanders <iwan.sanders@tuxproject.info> escribió:

> Can someone explain to me what just happend? I would really like to know 
>   :-)
> I think that the machine ran out of memory and the OOM killer shot some 
> processes, this is what I found
> in my logfiles:

This is exactly the kind of reports that I wanted to avoid with this small cosmetic change:


--- stable/mm/oom_kill.c.orig	2005-04-02 17:44:14.000000000 +0200
+++ stable/mm/oom_kill.c	2005-04-02 18:01:02.000000000 +0200
@@ -189,7 +189,8 @@
 		return;
 	}
 	task_unlock(p);
-	printk(KERN_ERR "Out of Memory: Killed process %d (%s).\n", p->pid, p->comm);
+	printk(KERN_ERR "The system has run Out Of Memory (RAM + swap), a process will be killed to free some memory\n");
+	printk(KERN_ERR "OOM: Killed process %d (%s).\n", p->pid, p->comm);
 
 	/*
 	 * We give our sacrificial lamb high priority and access to
