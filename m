Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268777AbUHLU5m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268777AbUHLU5m (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 16:57:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268786AbUHLU5l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 16:57:41 -0400
Received: from the-village.bc.nu ([81.2.110.252]:42965 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268784AbUHLU4m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 16:56:42 -0400
Subject: Re: [RFC, PATCH] sys_revoke(), just a try. (was: Re: dynamic /dev
	security hole?)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Michael Buesch <mbuesch@freenet.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Albert Cahalan <albert@users.sourceforge.net>,
       Eric Lammerts <eric@lammerts.org>, Marc Ballarin <Ballarin.Marc@gmx.de>,
       Greg KH <greg@kroah.com>
In-Reply-To: <200408121849.20227.mbuesch@freenet.de>
References: <20040808162115.GA7597@kroah.com>
	 <1092057570.5761.215.camel@cube> <200408111912.21469.mbuesch@freenet.de>
	 <200408121849.20227.mbuesch@freenet.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1092340279.22362.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 12 Aug 2004 20:51:19 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2004-08-12 at 17:49, Michael Buesch wrote:
> +static ssize_t revoke_read(struct file *filp,
> +			   char *buf,
> +			   size_t count,
> +			   loff_t *ppos)
> +{
> +	return 0;
> +}

-EIO I think but I'm not sure I remember the BSD behaviour in full

> +static int filp_revoke(struct file *filp, struct inode *inode)
> +{

First problem here is that the handle might still be in use
for mmap, so you'd need to undo mmaps on it. A second is that 
while you can ->flush() here you can't really close it until the
file usage count hits zero. 

You are btw tackling a really really hard problem and its more likely
the way to do this is to add revoke() methods to drivers and do it at
the driver level - as the tty layer does with vhangup.

