Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263528AbTFGUBd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 16:01:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263535AbTFGUBd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 16:01:33 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:52491 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S263528AbTFGUBb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 16:01:31 -0400
Date: Sat, 7 Jun 2003 22:14:57 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Andrew Morton <akpm@digeo.com>
Cc: Adrian Bunk <bunk@fs.tum.de>, bcollins@debian.org,
       linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       trivial@rustcorp.com.au
Subject: Re: [patch] 2.5.70-mm5: fix ieee1394_core.c compile if !CONFIG_PROC_FS
Message-ID: <20030607201457.GA32054@mars.ravnborg.org>
Mail-Followup-To: Andrew Morton <akpm@digeo.com>,
	Adrian Bunk <bunk@fs.tum.de>, bcollins@debian.org,
	linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	trivial@rustcorp.com.au
References: <20030607144558.GO15311@fs.tum.de> <20030607130625.37f077da.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030607130625.37f077da.akpm@digeo.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 07, 2003 at 01:06:25PM -0700, Andrew Morton wrote:
> Adrian Bunk <bunk@fs.tum.de> wrote:
> >
> > I got the following compile error with !CONFIG_PROC_FS:
> > 
> > The following patch fixes it:
> > --- linux-2.5.70-mm5/drivers/ieee1394/ieee1394_core.c.old	2003-06-07 16:42:35.000000000 +0200
> > +++ linux-2.5.70-mm5/drivers/ieee1394/ieee1394_core.c	2003-06-07 16:42:47.000000000 +0200
> > @@ -1228,7 +1228,9 @@
> >  
> >  	unregister_chrdev(IEEE1394_MAJOR, "ieee1394");
> >  	devfs_remove("ieee1394");
> > +#ifdef CONFIG_PROC_FS
> >  	remove_proc_entry("ieee1394", proc_bus);
> > +#endif
> >  }
> >  
> 
> proc_fs.h has:
> 
> static inline void remove_proc_entry(const char *name, struct proc_dir_entry *parent) {};
> 
> for the !CONFIG_PROC_FS case, so that _should_ have prevented this problem.
>  What went wrong?
proc_bus is only defined when CONFIG_PROC

	Sam
