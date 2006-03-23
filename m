Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030222AbWCWTBn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030222AbWCWTBn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 14:01:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030227AbWCWTBn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 14:01:43 -0500
Received: from mail.gmx.de ([213.165.64.20]:28332 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1030222AbWCWTBm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 14:01:42 -0500
X-Authenticated: #704063
Subject: Re: [Patch] Pointer dereference in net/irda/ircomm/ircomm_tty.c
From: Eric Sesterhenn <snakebyte@gmx.de>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060322232247.GD7790@mipter.zuzino.mipt.ru>
References: <1143067566.26895.8.camel@alice>
	 <20060322232247.GD7790@mipter.zuzino.mipt.ru>
Content-Type: text/plain
Date: Thu, 23 Mar 2006 20:01:39 +0100
Message-Id: <1143140499.17843.7.camel@alice>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

On Thu, 2006-03-23 at 02:22 +0300, Alexey Dobriyan wrote:
> On Wed, Mar 22, 2006 at 11:46:05PM +0100, Eric Sesterhenn wrote:
> > this fixes coverity bugs #855 and #854. In both cases tty
> > is dereferenced before getting checked for NULL.
> 
> Before Al will flame you,

I know you prefer doing it yourself :)

> IMO, what should be done is removing asserts checking for "self",
> because ->driver_data is filled in ircomm_tty_open() with valid pointer.

Updated patch below.

Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>

--- linux-2.6.16-git6/net/irda/ircomm/ircomm_tty.c.orig	2006-03-23 19:58:50.000000000 +0100
+++ linux-2.6.16-git6/net/irda/ircomm/ircomm_tty.c	2006-03-23 19:59:31.000000000 +0100
@@ -501,7 +501,6 @@ static void ircomm_tty_close(struct tty_
 	if (!tty)
 		return;
 
-	IRDA_ASSERT(self != NULL, return;);
 	IRDA_ASSERT(self->magic == IRCOMM_TTY_MAGIC, return;);
 
 	spin_lock_irqsave(&self->spinlock, flags);
@@ -1011,7 +1010,6 @@ static void ircomm_tty_hangup(struct tty
 
 	IRDA_DEBUG(0, "%s()\n", __FUNCTION__ );
 
-	IRDA_ASSERT(self != NULL, return;);
 	IRDA_ASSERT(self->magic == IRCOMM_TTY_MAGIC, return;);
 
 	if (!tty)


