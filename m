Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750799AbWDXNX4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750799AbWDXNX4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 09:23:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750798AbWDXNXz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 09:23:55 -0400
Received: from mx1.redhat.com ([66.187.233.31]:42626 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750788AbWDXNXy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 09:23:54 -0400
Subject: Re: [PATCH 13/16] GFS2: Makefiles and Kconfig
From: Steven Whitehouse <swhiteho@redhat.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060421164309.GE19754@stusta.de>
References: <1145636558.3856.118.camel@quoit.chygwyn.com>
	 <20060421164309.GE19754@stusta.de>
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Mon, 24 Apr 2006 14:32:30 +0100
Message-Id: <1145885550.3856.152.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 2006-04-21 at 18:43 +0200, Adrian Bunk wrote:
> On Fri, Apr 21, 2006 at 05:22:38PM +0100, Steven Whitehouse wrote:
> 
> >...
> > --- a/fs/Kconfig
> > +++ b/fs/Kconfig
> >...
> >
> >  source "fs/nls/Kconfig"
> > +source "fs/dlm/Kconfig"
> >...
> 
> File doesn't exist
> 
> > --- a/fs/Makefile
> > +++ b/fs/Makefile
> > @@ -48,6 +48,7 @@ obj-$(CONFIG_SYSFS)         += sysfs/
> >  obj-y                                += devpts/
> >
> >  obj-$(CONFIG_PROFILING)              += dcookies.o
> > +obj-$(CONFIG_DLM)            += dlm/
> >...
> 
> Directory doesn't exist.
> 
The above two anomalies are due to the git tree also containing the DLM
(already in -mm) and I forgot to redo this patch which is the only one
which overlaps with the DLM code. I expect that Andrew Morton will
update the version of the DLM in -mm at the same time as taking GFS2
when it is deemed ready to go in.

> > --- /dev/null
> > +++ b/fs/gfs2/Kconfig
> > @@ -0,0 +1,46 @@
> > +config GFS2_FS
> > +        tristate "GFS2 file system support"
> > +	default m
> > +	depends on EXPERIMENTAL
> > +        select FS_POSIX_ACL
> > +        select SYSFS
> >...
> 
> - tabs <-> spaces (tabs are correct)
> - please remove the "default m"
These two are done in:
http://www.kernel.org/git/?p=linux/kernel/git/steve/gfs2-2.6.git;a=commitdiff;h=b5ea3e1ef307548bdd40fff6aba5fc96b002f284


> - "depends on SYSFS" instead of the select
> 
This has been resolved by removing the dependency completely.

> > +config GFS2_FS_LOCKING_DLM
> > +	tristate "GFS2 DLM locking module"
> > +	depends on GFS2_FS
> > +	select DLM
> >...
> 
> DLM in -mm depends on IPV6 || IPV6=n, so if you are select'ing it you 
> have to add this dependency to GFS2_FS_LOCKING_DLM.
> 
> cu
> Adrian
> 
I will check this with the DLM developers and see what the best solution
is. Thanks for the feedback,

Steve.


