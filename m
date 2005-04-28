Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262188AbVD1RiV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262188AbVD1RiV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 13:38:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262189AbVD1RiV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 13:38:21 -0400
Received: from fire.osdl.org ([65.172.181.4]:20918 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262188AbVD1RiH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 13:38:07 -0400
Date: Thu, 28 Apr 2005 10:37:44 -0700
From: Chris Wright <chrisw@osdl.org>
To: Greg KH <gregkh@suse.de>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>, linux-kernel@vger.kernel.org,
       Jean Delvare <khali@linux-fr.org>
Subject: Re: [RFC/PATCH 0/5] read/write on attribute w/o show/store should return -ENOSYS
Message-ID: <20050428173744.GO23013@shell0.pdx.osdl.net>
References: <200504280030.10214.dtor_core@ameritech.net> <20050428172659.GA18859@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050428172659.GA18859@kroah.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Greg KH (gregkh@suse.de) wrote:
> On Thu, Apr 28, 2005 at 12:30:09AM -0500, Dmitry Torokhov wrote:
> > Hi,
> > 
> > Jean Delvare has noticed that if a driver happens to declare its
> > attribute as RW but doesn't provide store() method attempt to write
> > into such attribute will cause spinning process as most of the
> > attribute implementations return 0 in case of missing store causing
> > endless retries. In some cases missing show/store will return -EPERM,
> > -EACCESS or -EINVAL.
> > 
> > I think we should unify implementations and have them all return -ENOSYS
> > (function not implemented) when corresponding method (show/store) is
> > missing.
> 
> What is the POSIX standard for this?  ENOSYS or EACCESS?

SuSv3 suggests EBADF, however we already do EINVAL at VFS for no write
op.  Although, returning 0 (i.e. wrote zero bytes) is still meaningful
too.

> Or anyone have a link that I can look this up at?

http://www.opengroup.org/onlinepubs/000095399/functions/write.html

thanks,
-chris
