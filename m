Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265521AbUG1WYU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265521AbUG1WYU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 18:24:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266129AbUG1WYU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 18:24:20 -0400
Received: from mail.convergence.de ([212.84.236.4]:40416 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S265521AbUG1WYD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 18:24:03 -0400
Date: Thu, 29 Jul 2004 00:24:55 +0200
From: Johannes Stezenbach <js@convergence.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: 2.6.8-rc2-mm1
Message-ID: <20040728222455.GC5878@convergence.de>
Mail-Followup-To: Johannes Stezenbach <js@convergence.de>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	viro@parcelfarce.linux.theplanet.co.uk
References: <20040728020444.4dca7e23.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040728020444.4dca7e23.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 28, 2004 at 02:04:44AM -0700, Andrew Morton wrote:
> 
> - If people have patches in here which are important for a 2.6.8 release,
>   please let me know.
...
> +dvb-major-number.patch
> 
>  Use the right major in DVB

I would like to see this patch go into 2.6.8. We already changed
the major number in linuxtv.org CVS and announced it on our
website, so this might help keep the time of confusion for
DVB users short.

The patch below should go along with it. It fixes some breakage
in dvb_usercopy() introduced by Al Viro's sparse cleanups in -rc2.
(A similar patch might have been mailed already by Michael Hunold.)

Signed-off-by: Johannes Stezenbach <js@convergence.de>

--- linux-2.6.8-rc2/drivers/media/dvb/dvb-core/dvb_functions.c.orig	2004-07-29 00:19:50.000000000 +0200
+++ linux-2.6.8-rc2/drivers/media/dvb/dvb-core/dvb_functions.c	2004-07-29 00:20:05.000000000 +0200
@@ -36,7 +36,7 @@ int dvb_usercopy(struct inode *inode, st
         /*  Copy arguments into temp kernel buffer  */
         switch (_IOC_DIR(cmd)) {
         case _IOC_NONE:
-                parg = NULL;
+                parg = (void *) arg;
                 break;
         case _IOC_READ: /* some v4l ioctls are marked wrong ... */
         case _IOC_WRITE:

Johannes
