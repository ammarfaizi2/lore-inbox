Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265901AbUBGWDt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 17:03:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265919AbUBGWDs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 17:03:48 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:59144 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S265901AbUBGWD1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 17:03:27 -0500
Date: Sat, 7 Feb 2004 23:03:15 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Andreas Gruenbacher <agruen@suse.de>
cc: "kbuild-devel@lists.sourceforge.net" 
	<kbuild-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Bug in "select" dependency checking?
In-Reply-To: <1076078947.19043.27.camel@E136.suse.de>
Message-ID: <Pine.LNX.4.58.0402070026140.7851@serv>
References: <1076027838.2223.95.camel@nb.suse.de>  <Pine.LNX.4.58.0402061448500.7851@serv>
 <1076078947.19043.27.camel@E136.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 6 Feb 2004, Andreas Gruenbacher wrote:

> > config NFSD_ACL
> > 	bool "..."
> > 	depends on NFSD_V3
> > 	select NFS_ACL_SUPPORT if NFSD
> >
> > you avoid the warning and it does the same.
>
> Does it? I would assume this to limit NFS_ACL_SUPPORT to y or n
> depending on the value of NFSD_ACL. If should be y, m or n depending on
> the value of NFSD.

That's what the "if NFSD" part does, it's added to the expression and so
modifies how NFS_ACL_SUPPORT is selected. If you enable the debug options
in xconfig you can see the generated expression, which is used to
calculate the final value.
While looking at this, I noticed that a bit too much is added, the NFSD_V3
dependency is also added, but it belongs to NFSD_ACL, otherwise it can
also unintentionally turn the bool into a tristate. I'll have to fix
this...

bye, Roman
