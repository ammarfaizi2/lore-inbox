Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935999AbWK1SCV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935999AbWK1SCV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 13:02:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936000AbWK1SCV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 13:02:21 -0500
Received: from mx1.redhat.com ([66.187.233.31]:61151 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S935999AbWK1SCU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 13:02:20 -0500
Subject: Re: [GFS2] Fix Kconfig wrt CRC32 [8/9]
From: Steven Whitehouse <swhiteho@redhat.com>
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: Patrick Caulfield <pcaulfie@redhat.com>, linux-kernel@vger.kernel.org,
       cluster-devel@redhat.com,
       Toralf =?ISO-8859-1?Q?F=F6rster?= <toralf.foerster@gmx.de>
In-Reply-To: <456B149C.4050605@oracle.com>
References: <1164360889.3392.146.camel@quoit.chygwyn.com>
	 <20061124214338.0e4d0510.randy.dunlap@oracle.com>
	 <1164633855.3392.167.camel@quoit.chygwyn.com> <456B149C.4050605@oracle.com>
Content-Type: text/plain; charset=utf-8
Organization: Red Hat (UK) Ltd
Date: Tue, 28 Nov 2006 18:02:12 +0000
Message-Id: <1164736932.3752.28.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 2006-11-27 at 08:38 -0800, Randy Dunlap wrote:
> Steven Whitehouse wrote:
> > Hi,
> > 
> > On Fri, 2006-11-24 at 21:43 -0800, Randy Dunlap wrote:
> >> On Fri, 24 Nov 2006 09:34:49 +0000 Steven Whitehouse wrote:
> >>
> >>> >From 6f788fd00c82533d4cd5587a9706f8468658a24d Mon Sep 17 00:00:00 2001
> >>> From: Steven Whitehouse <swhiteho@redhat.com>
> >>> Date: Mon, 20 Nov 2006 10:04:49 -0500
> >>> Subject: [PATCH] [GFS2] Fix Kconfig wrt CRC32
> >>> Content-Type: text/plain; charset=UTF-8
> >>> Content-Transfer-Encoding: 8bit
> >>>
> >>> GFS2 requires the CRC32 library function. This was reported by
> >>> Toralf Förster.
> >>>
> >>> Cc: Toralf Förster <toralf.foerster@gmx.de>
> >>> Signed-off-by: Steven Whitehouse <swhiteho@redhat.com>
> >>> ---
> >>>  fs/gfs2/Kconfig |    1 +
> >>>  1 files changed, 1 insertions(+), 0 deletions(-)
> >>>
> >>> diff --git a/fs/gfs2/Kconfig b/fs/gfs2/Kconfig
> >>> index 8c27de8..c0791cb 100644
> >>> --- a/fs/gfs2/Kconfig
> >>> +++ b/fs/gfs2/Kconfig
> >>> @@ -2,6 +2,7 @@ config GFS2_FS
> >>>  	tristate "GFS2 file system support"
> >>>  	depends on EXPERIMENTAL
> >>>  	select FS_POSIX_ACL
> >>> +	select CRC32
> >>>  	help
> >>>  	A cluster filesystem.
> >> Hi,
> >>
> >> Do you also have Kconfig patches for DLM needing SYSFS
> >> and DLM needing CONFIG_NET ?
> >>
> >> ---
> >> ~Randy
> > 
> > My original reply to this seemed to disappear into my email system
> > somewhere, so apologies if this is the second copy you get.
> > 
> > The DLM shouldn't depend upon SYSFS at all. I believe that its perfectly
> > ok whether or not thats compiled in. There is a patch relating to the
> > Kconfig for DLM which is in my -nmw tree:
> 
> Hm, OK.  Apparently I meant CONFIGFS instead of SYSFS.
> 
The Kconfig for DLM in Linus' current tree says:
	select CONFIGFS_FS

so I don't know what else is needed.... its the same in -nmw as that bit
hasn't changed.

> > http://www.kernel.org/git/?p=linux/kernel/git/steve/gfs2-2.6-nmw.git;a=commitdiff;h=8758fbc8724c2da8a6a062f2b61d79c8f2a55c5f
> > 
> > This applies after the patch adding the TCP communications layer to DLM
> > which is also in -nmw. The patches in -nmw (next merge window) are a
> > superset of the ones I just requested that Linus pull since it contains
> > the newer features and more involved bug fixes and clean ups.
> > 
> > I believe that the Kconfig in -nmw is correct for DLM, though I'm
> > willing to be proved wrong. I'm also copying in Patrick in case he wants
> > to comment further as its more his area than mine,
> 
> I applied just that one patch to 2.6.19-rc6-git10 (which may or may not
> be sufficient -- please say) and built with my previously failing config file.
You'll need the patch:
http://www.kernel.org/git/?p=linux/kernel/git/steve/gfs2-2.6-nmw.git;a=commitdiff;h=4a28fda50d864ede7d2724723949407e0e4043b8
as well. I'm also slightly surprised that you managed to get the errors
that you did, since most of those symbols appear to be networking
related and the DLM depends on INET which is clearly not set since NET
is not set.

> It still fails with:
> 
> WARNING: "kernel_sendmsg" [fs/dlm/dlm.ko] undefined!
> WARNING: "sock_release" [fs/dlm/dlm.ko] undefined!
> WARNING: "config_item_put" [fs/dlm/dlm.ko] undefined!
> WARNING: "sock_create_kern" [fs/dlm/dlm.ko] undefined!
> WARNING: "config_item_init_type_name" [fs/dlm/dlm.ko] undefined!
> WARNING: "config_group_init_type_name" [fs/dlm/dlm.ko] undefined!
> WARNING: "configfs_register_subsystem" [fs/dlm/dlm.ko] undefined!
> WARNING: "config_group_find_obj" [fs/dlm/dlm.ko] undefined!
> WARNING: "configfs_unregister_subsystem" [fs/dlm/dlm.ko] undefined!
> WARNING: "kernel_recvmsg" [fs/dlm/dlm.ko] undefined!
> WARNING: "config_item_get" [fs/dlm/dlm.ko] undefined!
> WARNING: "config_group_init" [fs/dlm/dlm.ko] undefined!
>   CC      arch/x86_64/boot/compressed/misc.o
>   OBJCOPY arch/x86_64/boot/compressed/vmlinux.bin
> make[1]: *** [__modpost] Error 1
> make: *** [modules] Error 2
> 
Which of the various methods (oldconfig, xconfig, menuconfig, etc) did
you use to generate this config?

Steve.


