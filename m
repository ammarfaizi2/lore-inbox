Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751043AbVKDXvz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751043AbVKDXvz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 18:51:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751045AbVKDXvz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 18:51:55 -0500
Received: from verein.lst.de ([213.95.11.210]:55207 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S1751041AbVKDXvy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 18:51:54 -0500
Date: Sat, 5 Nov 2005 00:51:48 +0100
From: Christoph Hellwig <hch@lst.de>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Christoph Hellwig <hch@lst.de>, akpm@osdl.org, schwidefsky@de.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] ->compat_ioctl for 390 tape_char
Message-ID: <20051104235148.GA10604@lst.de>
References: <20051104221816.GD9384@lst.de> <200511050010.47138.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511050010.47138.arnd@arndb.de>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 05, 2005 at 12:10:46AM +0100, Arnd Bergmann wrote:
> Hmm, isn't ->compat_ioctl called before the translation lookup?

Yes.

> If so,
> this code would return -EINVAL from tape_34xx_ioctl and result in never
> entering the conversion for MTIO* at all.

we return -ENOIOCTLCMD if we didn't have a valid compat ioctl, and in
that case the vfs code will try to find it in the core translation
table.

> BTW, I now have a set of 25 patches that moves all handlers from
> fs/compat_ioctl.c over to the respective drivers and subsystems,
> but I'm not sure how to best test that.
> I intend to at least give it a test run on my Opteron for the whatever
> ioctls I normally use, but the rest is just guesswork. Christoph,
> can you review those patches?

I'm not sure moving everything from fs/compat_ioctl.c is a good idea.
Everything that is just in a single driver or subsystem that has
common ioctl code - sure.  else it doesn't make a lot of sense.

