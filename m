Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267340AbTALJqG>; Sun, 12 Jan 2003 04:46:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267346AbTALJqB>; Sun, 12 Jan 2003 04:46:01 -0500
Received: from tomts13-srv.bellnexxia.net ([209.226.175.34]:28125 "EHLO
	tomts13-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S267340AbTALJp7>; Sun, 12 Jan 2003 04:45:59 -0500
Date: Sun, 12 Jan 2003 04:54:54 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@dell
To: Adrian Bunk <bunk@fs.tum.de>
cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: two more oddities with the fs/Kconfig file
In-Reply-To: <20030112073406.GM21826@fs.tum.de>
Message-ID: <Pine.LNX.4.44.0301120449530.4974-100000@dell>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Jan 2003, Adrian Bunk wrote:

> On Sun, Jan 12, 2003 at 02:07:13AM -0500, Robert P. J. Day wrote:
> > 
> >   there are a few options that are categorized as simply
> > "bool", with no following label -- examples being UMSDOS,
> > QUOTACTL, and a couple of others.  without a label on that
> > line, the option is not displayed for selection anywhere
> > on the menu.  is this deliberate?
> >...
> 
> Yes, this is what was called define_bool in the old kconfig.
> 
> E.g.
> 
> config QUOTACTL
>         bool
>         depends on XFS_QUOTA || QUOTA
>         default y
> 
> says that QUOTACTL is automatically selected if XFS_QUOTA or QUOTA is 
> selected. This is a config option that is never visible to the user 
> configuring the kernel.

hold everything.  i *thought* i understood this, now i'm not so sure.
i zipped thru fs/Kconfig, and extracted all of the options i could
find that were either "bool" or "tristate" with no labels.  supposedly,
these are never visible to the user.  examples:

config QUOTACTL
	bool
	depends on XFS_QUOTA || QUOTA
	default y

config JBD
	bool
	default EXT3_FS
	---help---

config UMSDOS_FS
	bool
	---help---

config RAMFS
	bool
	default y
	---help---

config SUNRPC
	tristate
	default m if NFS_FS!=y && NFSD!=y && (NFS_FS=m || NFSD=m)
	default y if NFS_FS=y || NFSD=y

config LOCKD
	tristate
	default m if NFS_FS!=y && NFSD!=y && (NFS_FS=m || NFSD=m)
	default y if NFS_FS=y || NFSD=y

config LOCKD_V4
	bool
	depends on NFSD_V3 || NFS_V3
	default y

config EXPORTFS
	tristate
	default NFSD

config RXRPC
	tristate
	default m if AFS_FS=m
	default y if AFS_FS=y

config ZISOFS_FS
	tristate
	depends on ZISOFS
	default ISO9660_FS

config FS_MBCACHE
	tristate
	depends on EXT2_FS_XATTR || EXT3_FS_XATTR
	default y if EXT2_FS=y || EXT3_FS=y
	default m if EXT2_FS=m || EXT3_FS=m

config FS_POSIX_ACL
	bool
	depends on EXT2_FS_POSIX_ACL || EXT3_FS_POSIX_ACL || JFS_POSIX_ACL
	default y


  so, according to the above, i would *always* get RAMFS, no matter
what?  there's no way to turn this off?

  but what about UMSDOS_FS?  it's a non-displayed boolean, but
it has no dependencies, and more weirdly, no default value.
so what will it be set to?  and why *shouldn't* i be able to
select UMSDOS support or not?

  and if they're not displayed, why do some of them have help
screens?  and why can't i get to sleep?  argh.

rday

