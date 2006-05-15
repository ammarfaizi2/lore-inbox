Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965034AbWEOSCx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965034AbWEOSCx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 14:02:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965038AbWEOSCx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 14:02:53 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:35551 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S965034AbWEOSCw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 14:02:52 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=D5uWUKQH+NHJMYSDR7IHrHkmxZeu6A1aG0ree7GcDmQz98g5a/D/Hu55XOLk4wiac67XVTSaPxvTB4hY6nYF6Dny0kd6Ej3FtKAMU97Af0GCy1Yvopi5BilYHabgEnONzBiZDGFFUe1LwCiTfI11hvM2zzObzj/KFVI3JDyHaxU=
Date: Mon, 15 May 2006 22:01:39 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, phillip@hellewell.homeip.net,
       Michael Halcrow <mhalcrow@us.ibm.com>,
       David Howells <dhowells@redhat.com>
Subject: Re: 2.6.17-rc4-mm1
Message-ID: <20060515180139.GC10143@mipter.zuzino.mipt.ru>
References: <20060515005637.00b54560.akpm@osdl.org> <20060515164938.GB10143@mipter.zuzino.mipt.ru> <20060515100144.0aff41b1.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060515100144.0aff41b1.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 15, 2006 at 10:01:44AM -0700, Andrew Morton wrote:
> Alexey Dobriyan <adobriyan@gmail.com> wrote:
> >
> > >   - Added the ecryptfs filesystem
> > 
> >   CC [M]  fs/ecryptfs/super.o
> > fs/ecryptfs/super.c: In function `ecryptfs_statfs':
> > fs/ecryptfs/super.c:129: warning: passing arg 1 of `vfs_statfs' from incompatible pointer type
> > fs/ecryptfs/super.c: At top level:
> > fs/ecryptfs/super.c:207: warning: initialization from incompatible pointer type
> 
> hm, I wonder why I didn't notice that.
> 
> > * ->statfs wants vfsmount as first argument
> > * ecryptfs_statfs() is inlined
> 
> yup.  Fixed a bunch of those, let one slip through.
> 
> I don't immediately see how to fix this one, actually:
> 
> static inline int ecryptfs_statfs(struct super_block *sb, struct kstatfs *buf)
> {
> 	return vfs_statfs(ecryptfs_superblock_to_lower(sb), buf);
> }
> 
> Once we've run ecryptfs_superblock_to_lower() to get the "lower
> superblock", we need to turn that back into a vfsmount for vfs_statfs()..
> 
> (and that function needn't have been inlined - it's only ever called
> indirectly)
> 
> I think I'll be dropping the fs-cache patches (again) fairly soon.  They're
> intrusive, quite some effort to carry, they're not getting adequate review
> (afaict) and there doesn't seem to be a lot of demand for them, sorry.

Silly me. GFS2 is guilty too

fs/gfs2/ops_super.c:371: warning: initialization from incompatible pointer type

	static int gfs2_statfs(struct super_block *sb, struct kstatfs *buf)

