Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316649AbSGGX0z>; Sun, 7 Jul 2002 19:26:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316659AbSGGX0y>; Sun, 7 Jul 2002 19:26:54 -0400
Received: from mailout08.sul.t-online.com ([194.25.134.20]:29388 "EHLO
	mailout08.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S316649AbSGGX0x> convert rfc822-to-8bit; Sun, 7 Jul 2002 19:26:53 -0400
Content-Type: text/plain; charset=US-ASCII
From: Oliver Neukum <oliver@neukum.name>
To: Thunder from the hill <thunder@ngforever.de>,
       Dave Hansen <haveblue@us.ibm.com>
Subject: Re: BKL removal
Date: Mon, 8 Jul 2002 01:31:06 +0200
User-Agent: KMail/1.4.1
Cc: Thunder from the hill <thunder@ngforever.de>, Greg KH <greg@kroah.com>,
       kernel-janitor-discuss 
	<kernel-janitor-discuss@lists.sourceforge.net>,
       <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0207071702120.10105-100000@hawkeye.luckynet.adm>
In-Reply-To: <Pine.LNX.4.44.0207071702120.10105-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200207080131.06119.oliver@neukum.name>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > "up" is a local variable.  There is no point in protecting its
> > allocation.  If the goal is to protect data inside "up", there should
> > probably be a subsystem-level lock for all "struct uhci_hcd"s or a
> > lock contained inside of the structure itself.  Is this the kind of
> > example you're looking for?
>
> So the BKL isn't wrong here, but incorrectly used?

The BKL, unless used unbalanced, can never cause a bug.
It could be insufficient or superfluous, but never be really buggy in itself.

> Is it really okay to "lock the whole kernel" because of one struct file?
> This brings us back to spinlocks...
>
> You're possibly right about this one. What did Greg K-H say?

I don't speak for Greg, but in this example it could be dropped IMO.
The spinlock protects the critical section anyway. As a rule, if you
do a kmalloc without GFP_ATOMIC under BKL you are doing either insufficient
locking (you may need a semaphore) or useless locking.

This should have been posted on linux-usb long ago.

	Regards
		Oliver

