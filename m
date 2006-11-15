Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966739AbWKOKXq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966739AbWKOKXq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 05:23:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966741AbWKOKXq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 05:23:46 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:28174 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S966739AbWKOKXp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 05:23:45 -0500
Date: Wed, 15 Nov 2006 11:23:51 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Patrick Caulfield <pcaulfie@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, Steven Whitehouse <swhiteho@redhat.com>,
       teigland@redhat.com, linux-kernel@vger.kernel.org,
       cluster-devel@redhat.com
Subject: Re: [-mm patch] fix the DLM dependencies, part 2
Message-ID: <20061115102351.GR22565@stusta.de>
References: <20061114014125.dd315fff.akpm@osdl.org> <20061114183324.GL22565@stusta.de> <20061114225641.GP22565@stusta.de> <455AE7D7.4020002@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <455AE7D7.4020002@redhat.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2006 at 10:11:35AM +0000, Patrick Caulfield wrote:
> Adrian Bunk wrote:
> > On Tue, Nov 14, 2006 at 07:33:24PM +0100, Adrian Bunk wrote:
> >> On Tue, Nov 14, 2006 at 01:41:25AM -0800, Andrew Morton wrote:
> >>> ...
> >>> - A nasty Kconfig warning comes out during the build.  It's due to
> >>>   git-gfs2-nmw.patch.
> >>> ...
> >> So let's fix it.  ;-)
> >> ...
> > 
> > And let's also fix another bug...
> > 
> > 
> > <--  snip  -->
> > 
> > 
> > IPV6=m, DLM=m, DLM_SCTP=y mustn't result in IP_SCTP=y.
> > 
> > Signed-off-by: Adrian Bunk <bunk@stusta.de>
> > 
> > --- linux-2.6.19-rc5-mm2/fs/dlm/Kconfig.old	2006-11-14 22:25:01.000000000 +0100
> > +++ linux-2.6.19-rc5-mm2/fs/dlm/Kconfig	2006-11-14 22:25:19.000000000 +0100
> > @@ -5,6 +5,7 @@ config DLM
> >  	tristate "Distributed Lock Manager (DLM)"
> >  	depends on IPV6 || IPV6=n
> >  	select CONFIGFS_FS
> > +	select IP_SCTP if DLM_SCTP
> >  	help
> >  	A general purpose distributed lock manager for kernel or userspace
> >  	applications.
> > @@ -23,7 +24,6 @@ config DLM_TCP
> >  
> >  config DLM_SCTP
> >  	bool "SCTP"
> > -	select IP_SCTP
> >  
> >  endchoice
> 
> Thanks Adrian. I need to read the kconfig docs a little more closely :)
> 
> Incidentally, I think the 'depends on IPV6 || IPV6=n' can go too; it's in a patch I sent to Steve and it's basically just a line
> copied from SCTP which is obsoleted by these other changes and the addition of the TCP transport.

As long as you select IP_SCTP, the "depends on IPV6 || IPV6=n" can't go:
Otherwise, the illegal configuration DLM=y, IP_SCTP=y, IPV6=m would 
become possible.

> patrick

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

