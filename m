Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265478AbUBFOyu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 09:54:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265479AbUBFOyu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 09:54:50 -0500
Received: from ns.suse.de ([195.135.220.2]:27362 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265478AbUBFOyr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 09:54:47 -0500
Subject: Re: Bug in "select" dependency checking?
From: Andreas Gruenbacher <agruen@suse.de>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: "kbuild-devel@lists.sourceforge.net" 
	<kbuild-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0402061448500.7851@serv>
References: <1076027838.2223.95.camel@nb.suse.de>
	 <Pine.LNX.4.58.0402061448500.7851@serv>
Content-Type: text/plain
Organization: SUSE Labs, SUSE LINUX AG
Message-Id: <1076078947.19043.27.camel@E136.suse.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Fri, 06 Feb 2004 15:49:07 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-02-06 at 15:00, Roman Zippel wrote:
> Hi,
> 
> On Fri, 6 Feb 2004, Andreas Gruenbacher wrote:
> 
> > With this configuration, menuconf gives me this message (among others):
> >
> >   Warning! Found recursive dependency: NFSD_V3 NFSD_ACL NFSD NFSD_V3
> 
> This is indeed a wrong positive, the patch below fixes this, but you if
> change your config into e.g.:
> 
> config NFSD_ACL
> 	bool "..."
> 	depends on NFSD_V3
> 	select NFS_ACL_SUPPORT if NFSD
>
> you avoid the warning and it does the same.

Does it? I would assume this to limit NFS_ACL_SUPPORT to y or n
depending on the value of NFSD_ACL. If should be y, m or n depending on
the value of NFSD.

> Or you could also write this simpler as:
> 
> config NFS_ACL_SUPPORT
> 	tristate
> 	default (NFSD && NFSD_ACL) || (NFS_FS && NFS_ACL)

That's much more elegant than my "handwired" version. But I prefer
select: NFSD_ACL and NFS_ACL are in different patches; with select, the
patches don't conflict with each other.


Thanks,
-- 
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX AG

