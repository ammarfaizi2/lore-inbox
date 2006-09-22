Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750880AbWIVKjg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750880AbWIVKjg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 06:39:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750883AbWIVKjg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 06:39:36 -0400
Received: from mx1.redhat.com ([66.187.233.31]:18562 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750869AbWIVKjf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 06:39:35 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <Pine.LNX.4.64.0609171022160.27242@sheep.housecafe.de> 
References: <Pine.LNX.4.64.0609171022160.27242@sheep.housecafe.de>  <20060912000618.a2e2afc0.akpm@osdl.org> 
To: Christian Kujau <evil@g-house.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc6-mm2: __fscache_register_netfs compile error 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Fri, 22 Sep 2006 11:39:26 +0100
Message-ID: <13720.1158921566@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hmmm...  It looks like a configurator problem:

	warthog>grep 'NFS\|CACHE' .config 
	CONFIG_X86_L1_CACHE_BYTES=128
	CONFIG_X86_L1_CACHE_SHIFT=7
	CONFIG_X86_INTERNODE_CACHE_BYTES=128
	# CONFIG_IP_ROUTE_MULTIPATH_CACHED is not set
	CONFIG_IRDA_CACHE_LAST_LSAP=y
	# CONFIG_CDROM_PKTCDVD_WCACHE is not set
	CONFIG_FS_MBCACHE=y
 --->	CONFIG_FSCACHE=m
	# CONFIG_CACHEFILES is not set
 --->	CONFIG_NFS_FS=y
	CONFIG_NFS_V3=y
	CONFIG_NFS_V3_ACL=y
	CONFIG_NFS_V4=y
	CONFIG_NFS_FSCACHE=y
	CONFIG_NFS_DIRECTIO=y
	CONFIG_NFSD=m
	CONFIG_NFSD_V2_ACL=y
	CONFIG_NFSD_V3=y
	CONFIG_NFSD_V3_ACL=y
	CONFIG_NFSD_V4=y
	CONFIG_NFSD_TCP=y
	CONFIG_NFS_ACL_SUPPORT=y
	CONFIG_NFS_COMMON=y
	CONFIG_NCPFS_NFS_NS=y

I'm not sure what I can do about that.  NFS_FS doesn't depend on FSCACHE, and
so isn't forced to become a module when FSCACHE is.  The dependency is through
one of NFS's configuation options.

David
