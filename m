Return-Path: <linux-kernel-owner+w=401wt.eu-S1752872AbWLXVFE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752872AbWLXVFE (ORCPT <rfc822;w@1wt.eu>);
	Sun, 24 Dec 2006 16:05:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752877AbWLXVFE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Dec 2006 16:05:04 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:45131 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752871AbWLXVFD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Dec 2006 16:05:03 -0500
Date: Sun, 24 Dec 2006 22:00:37 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Zack Weinberg <zackw@panix.com>
cc: Stephen Smalley <sds@tycho.nsa.gov>, jmorris@namei.org,
       Chris Wright <chrisw@sous-sol.org>, Vincent Legoll <vlegoll@9online.fr>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 1/4] Add <linux/klog.h>
In-Reply-To: <20061224202628.820320038@panix.com>
Message-ID: <Pine.LNX.4.61.0612242200020.16427@yvahk01.tjqt.qr>
References: <20061224202207.150596681@panix.com> <20061224202628.820320038@panix.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Dec 24 2006 12:22, Zack Weinberg wrote:
>===================================================================
>--- linux-2.6.orig/fs/proc/kmsg.c	2006-12-23 08:55:17.000000000 -0800
>+++ linux-2.6/fs/proc/kmsg.c	2006-12-24 11:43:14.000000000 -0800
>@@ -11,6 +11,7 @@
> #include <linux/kernel.h>
> #include <linux/poll.h>
> #include <linux/fs.h>
>+#include <linux/klog.h>
> 
> #include <asm/uaccess.h>
> #include <asm/io.h>
>@@ -21,27 +22,28 @@
> 
> static int kmsg_open(struct inode * inode, struct file * file)
> {
>-	return do_syslog(1,NULL,0);
>+	return do_syslog(KLOG_OPEN, NULL, 0);
> }
> 
> static int kmsg_release(struct inode * inode, struct file * file)
> {
>-	(void) do_syslog(0,NULL,0);
>+	(void) do_syslog(KLOG_CLOSE, NULL, 0);
        ^^^^^^

I bet you can get rid of that in the process.


	-`J'
-- 
