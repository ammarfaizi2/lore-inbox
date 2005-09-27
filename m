Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965211AbVI0W1x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965211AbVI0W1x (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 18:27:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965214AbVI0W1w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 18:27:52 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:3508
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S965211AbVI0W1w
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 18:27:52 -0400
Subject: Re: [PATCH] RT:  unwritten_done_lock to DEFINE_SPINLOCK
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: dwalker@mvista.com
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org
In-Reply-To: <1127845928.4004.26.camel@dhcp153.mvista.com>
References: <1127845928.4004.26.camel@dhcp153.mvista.com>
Content-Type: text/plain
Organization: linutronix
Date: Wed, 28 Sep 2005 00:28:32 +0200
Message-Id: <1127860112.15115.213.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-09-27 at 11:32 -0700, Daniel Walker wrote:
> Convert unwritten_done_lock xfs lock to the new syntax.
> 
> Signed-Off-By: Daniel Walker <dwalker@mvista.com>
> 
> Index: linux-2.6.13/fs/xfs/linux-2.6/xfs_aops.c
> ===================================================================
> --- linux-2.6.13.orig/fs/xfs/linux-2.6/xfs_aops.c
> +++ linux-2.6.13/fs/xfs/linux-2.6/xfs_aops.c
> @@ -192,7 +192,7 @@ linvfs_unwritten_done(
>  	int			uptodate)
>  {
>  	xfs_ioend_t		*ioend = bh->b_private;
> -	static spinlock_t	unwritten_done_lock = SPIN_LOCK_UNLOCKED;
> +	static DECLARE_SPINLOCK(unwritten_done_lock);
>  	unsigned long		flags;

Did you actually compile this ?


tglx

--- linux-2.6.13.orig/fs/xfs/linux-2.6/xfs_aops.c
+++ linux-2.6.13/fs/xfs/linux-2.6/xfs_aops.c
@@ -192,7 +192,7 @@ linvfs_unwritten_done(
        int                     uptodate)
 {
        xfs_ioend_t             *ioend = bh->b_private;
-       static spinlock_t       unwritten_done_lock = SPIN_LOCK_UNLOCKED;
+       static DEFINE_SPINLOCK(unwritten_done_lock);
        unsigned long           flags;
 
        ASSERT(buffer_unwritten(bh));



