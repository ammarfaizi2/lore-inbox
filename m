Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267364AbUG1XIg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267364AbUG1XIg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 19:08:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267164AbUG1Ww0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 18:52:26 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:60554 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266531AbUG1WoZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 18:44:25 -0400
Date: Wed, 28 Jul 2004 23:44:23 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Johannes Stezenbach <js@convergence.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.8-rc2-mm1
Message-ID: <20040728224423.GJ12308@parcelfarce.linux.theplanet.co.uk>
References: <20040728020444.4dca7e23.akpm@osdl.org> <20040728222455.GC5878@convergence.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040728222455.GC5878@convergence.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 29, 2004 at 12:24:55AM +0200, Johannes Stezenbach wrote:
> Signed-off-by: Johannes Stezenbach <js@convergence.de>
> 
> --- linux-2.6.8-rc2/drivers/media/dvb/dvb-core/dvb_functions.c.orig	2004-07-29 00:19:50.000000000 +0200
> +++ linux-2.6.8-rc2/drivers/media/dvb/dvb-core/dvb_functions.c	2004-07-29 00:20:05.000000000 +0200
> @@ -36,7 +36,7 @@ int dvb_usercopy(struct inode *inode, st
>          /*  Copy arguments into temp kernel buffer  */
>          switch (_IOC_DIR(cmd)) {
>          case _IOC_NONE:
> -                parg = NULL;
> +                parg = (void *) arg;

Mind explaining why it is the right thing to do?  You are creating a kernel
pointer out of value passed to you by userland and feed it to a function
that expects a kernel pointer.  Which is an invitation for trouble - if
it ends up dereferenced, we are screwed and won't notice that.
