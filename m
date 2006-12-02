Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424174AbWLBVoM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424174AbWLBVoM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 16:44:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424170AbWLBVoM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 16:44:12 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:10897 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1424156AbWLBVoL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 16:44:11 -0500
From: Roman Zippel <zippel@linux-m68k.org>
To: Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [RFC] timers, pointers to functions and type safety
Date: Sat, 2 Dec 2006 22:43:58 +0100
User-Agent: KMail/1.9.5
Cc: Thomas Gleixner <tglx@linutronix.de>, Matthew Wilcox <matthew@wil.cx>,
       Linus Torvalds <torvalds@osdl.org>, linux-arch@vger.kernel.org,
       linux-kernel@vger.kernel.org
References: <20061201172149.GC3078@ftp.linux.org.uk> <1165084076.24604.56.camel@localhost.localdomain> <20061202184035.GL3078@ftp.linux.org.uk>
In-Reply-To: <20061202184035.GL3078@ftp.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612022243.58348.zippel@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Saturday 02 December 2006 19:40, Al Viro wrote:

> RTFPosting.  It might be void *, but it's set via SETUP_TIMER which
> does type checks before casting to void *.
>
> IOW, I don't want _any_ typecasts/container_of necessary in the code.
>
> Sane variant is
>
> void foo_timer(struct net_device *dev)
> {
> 	...
> }
>
> 	struct foo_dev *p = netdev_priv(dev);
> 	SETUP_TIMER(&p->timer, foo_timer, dev);
>
> etc.
>
> With warning generated if foo_timer(dev) would not be type safe.  Without
> typecasts.  Without container_of().  Without any bleeding cruft at all.

You need some more magic macros to access/modify the data field.
Your SETUP_TIMER macro only protects the simple cases, which are easy anyway, 
in this case I prefer the space savings container_of can give us.

bye, Roman
