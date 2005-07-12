Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262489AbVGLXnp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262489AbVGLXnp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 19:43:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262431AbVGLXln
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 19:41:43 -0400
Received: from unused.mind.net ([69.9.134.98]:42450 "EHLO echo.lysdexia.org")
	by vger.kernel.org with ESMTP id S262457AbVGLXkt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 19:40:49 -0400
Date: Tue, 12 Jul 2005 16:39:58 -0700 (PDT)
From: William Weston <weston@sysex.net>
X-X-Sender: weston@echo.lysdexia.org
To: Daniel Walker <dwalker@mvista.com>
cc: mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: RT and XFS
In-Reply-To: <1121209293.26644.8.camel@dhcp153.mvista.com>
Message-ID: <Pine.LNX.4.58.0507121630150.21776@echo.lysdexia.org>
References: <1121209293.26644.8.camel@dhcp153.mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Jul 2005, Daniel Walker wrote:

> Is there something so odd about the XFS locking, that it can't use the
> rt_lock ?
> 
> 
> --- linux.orig/fs/xfs/linux-2.6/mrlock.h
> +++ linux/fs/xfs/linux-2.6/mrlock.h
> @@ -37,12 +37,12 @@
>  enum { MR_NONE, MR_ACCESS, MR_UPDATE };
>  
>  typedef struct {
> -	struct rw_semaphore	mr_lock;
> -	int			mr_writer;
> +	struct compat_rw_semaphore	mr_lock;
> +	int				mr_writer;
>  } mrlock_t;

BTW, what's the difference between rw_semaphore and compat_rw_semaphore?  
Or between semaphore and compat_semaphore?  I ran into a similar issue
(needing compat_semaphore) with the IVTV drivers.  The following is a
portion of my patch to get IVTV running under RT (the other portions are
just compile-time semantics):

--- ivtv-0.2.0-rc3k.orig/driver/msp3400.c       2004-11-19 08:21:04.000000000 -0800
+++ ivtv-0.2.0-rc3k/driver/msp3400.c    2005-06-22 17:26:24.000000000 
-0700
@@ -115,7 +115,7 @@
 	struct task_struct  *thread;
 	wait_queue_head_t    wq;
 
-	struct semaphore    *notify;
+	struct compat_semaphore *notify;
 	int                  active,restart,rmmod;
 
 	int                  watch_stereo;

--ww
