Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750816AbWCTSGH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750816AbWCTSGH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 13:06:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751178AbWCTSGH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 13:06:07 -0500
Received: from pat.uio.no ([129.240.130.16]:14296 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1750816AbWCTSGF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 13:06:05 -0500
Subject: Re: NFS superblock sharing implies mount flags bug
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Aurelien Degremont <aurelien.degremont@cea.fr>
Cc: viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net,
       Jacques-Charles Lafoucriere <jc.lafoucriere@cea.fr>
In-Reply-To: <441EAC05.7020903@cea.fr>
References: <200603151038.LAA21392@styx.bruyeres.cea.fr>
	 <441EAC05.7020903@cea.fr>
Content-Type: text/plain
Date: Mon, 20 Mar 2006 13:05:46 -0500
Message-Id: <1142877946.7991.2.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.848, required 12,
	autolearn=disabled, AWL 1.15, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-03-20 at 14:20 +0100, Aurelien Degremont wrote:
> Nobody is interested by this issue ?
> It could be easily reproduced. All recent versions are concerned.
> 
> Aurelien

Check the linux-fsdevel and lkml archives.

There has been plenty of work on this issue both by Herbert Poetzl and
(more recently) by Christoph Hellwig.

Cheers,
  Trond



> Aurelien Degremont wrote:
> > Hello
> > 
> > I'm facing incorrect using of mount flags when dealing with NFS mounts 
> > and I think it could be seen as a bug.
> > 
> > The error occurs when mounting the same NFS export many times, on the 
> > same machine but *with different mount flags*, particularly concerning 
> > RO/RW flags.
> > 
> > As the NFS client code re-uses superblocks when it detects that it is 
> > the same export (same server/same port/same exported directory) and that 
> > the read-only flag is managed as a per-superblock flag, if a NFS exports 
> > is mounted a second time, the superblock of the first mount is re-used 
> > and the specified mount flag is ignored.
> > 
> > # mount foo:/bar /bar_ro -o ro
> > # mount foo:/bar /bar_rw -o rw
> > $ touch /bar_rw/bar
> > touch: cannot touch `/bar_rw/bar': Read-only file system
> > 
> > Ideally, the best solution to fix this is to move the RDONLY flag from 
> > its per-superblock basis to a per-mountpoint (vfsmount) basis. I do not 
> > know is there is a something that prevent that except that this implies 
> > many changes as many codes do not use macros but access s_flags directly.
> > 
> > It seems quite clear that the superblock sharing couldn't be changed (to 
> > avoid incoherency, inode aliasing and so on...) ?
> > 
> > Do you have a (better) solution ?
> > I can help if needed.
> > 
> > 
> > Cordially
> > 
> 
> 

