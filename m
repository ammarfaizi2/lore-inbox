Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264081AbTEGPwY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 11:52:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264083AbTEGPwY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 11:52:24 -0400
Received: from rth.ninka.net ([216.101.162.244]:9645 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S264081AbTEGPwW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 11:52:22 -0400
Subject: Re: ioctl cleanups: enable sg_io and serial stuff to be shared
From: "David S. Miller" <davem@redhat.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Christoph Hellwig <hch@infradead.org>, Arnd Bergmann <arnd@arndb.de>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20030507152856.GF412@elf.ucw.cz>
References: <20030507104008$12ba@gated-at.bofh.it>
	 <200305071154.h47BsbsD027038@post.webmailer.de>
	 <20030507124113.GA412@elf.ucw.cz> <20030507135600.A22642@infradead.org>
	 <20030507152856.GF412@elf.ucw.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1052323484.9817.14.camel@rth.ninka.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 07 May 2003 09:04:44 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-05-07 at 08:28, Pavel Machek wrote:
> Not sure if we are not too close to stable release to do that? And I
> see no incremental way how to get there. Moving compatibility stuff
> closer to drivers can be done close to stable release...

You can define it as follows:

1) If entry exists in COMPAT or TRANSLATE table, invoke
   fops->ioctl(), else

2) If ->compat_ioctl() exists, invoke that, else

3) Fail.

The COMPAT tables are sort of valuable, in that it eliminates
the need to duplicate code when all of a drivers ioctls need
no translation.

BTW, need to extend this to netdev->do_ioctl as well for the
handling of SIOCDEVPRIVATE based stuff.  Oh goody, we can finally
fix up that crap :))))

-- 
David S. Miller <davem@redhat.com>
