Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261785AbTEHPeh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 11:34:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261786AbTEHPeg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 11:34:36 -0400
Received: from bristol.phunnypharm.org ([65.207.35.130]:48562 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S261785AbTEHPef (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 11:34:35 -0400
Date: Thu, 8 May 2003 11:16:43 -0400
From: Ben Collins <bcollins@debian.org>
To: "David S. Miller" <davem@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, Pavel Machek <pavel@ucw.cz>,
       Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: Re: ioctl cleanups: enable sg_io and serial stuff to be shared
Message-ID: <20030508151643.GO679@phunnypharm.org>
References: <20030507104008$12ba@gated-at.bofh.it> <200305071154.h47BsbsD027038@post.webmailer.de> <20030507124113.GA412@elf.ucw.cz> <20030507135600.A22642@infradead.org> <1052318339.9817.8.camel@rth.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1052318339.9817.8.camel@rth.ninka.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 07, 2003 at 07:39:00AM -0700, David S. Miller wrote:
> On Wed, 2003-05-07 at 05:56, Christoph Hellwig wrote:
> > Btw, if you really want to move all the 32bit ioctl compat code to the
> > drivers a ->ioctl32 file operation might be the better choice..
> 
> I can't believe I never thought of that. :-)

How would the driver differentiate between .compat_ioctl == NULL being a
case where it should fail because there is no translation, or a case
where it should use the compatible .ioctl? Maybe there should be an
extra flag like use_compat_ioctl. So:

	.use_compat_ioctl	= 1;
	.ioctl			= my_ioctl;
	.compat_ioctl		= my_compat_ioctl;

Means use my_compat_ioctl() for translation. And just:

	.use_compat_ioctl	= 1;
	.ioctl			= my_ioctl;

Means that our standard my_ioctl is 32/64 compatible.

This would also solve the current problem where a module that is
compiled with compat ioctl's using register_ioctl32_conversion() is not
usable on a kernel compiled without CONFIG_COMPAT, even though it very
well should be.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
Deqo       - http://www.deqo.com/
