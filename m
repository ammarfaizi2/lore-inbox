Return-Path: <linux-kernel-owner+w=401wt.eu-S965102AbXABXWH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965102AbXABXWH (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 18:22:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965086AbXABXWG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 18:22:06 -0500
Received: from pat.uio.no ([129.240.10.15]:42579 "EHLO pat.uio.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965129AbXABXWE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 18:22:04 -0500
Subject: RE: [nfsv4] RE: Finding hardlinks
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: "Halevy, Benny" <bhalevy@panasas.com>
Cc: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
       Jan Harkes <jaharkes@cs.cmu.edu>, Miklos Szeredi <miklos@szeredi.hu>,
       linux-kernel@vger.kernel.org, nfsv4@ietf.org,
       linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@poochiereds.net>,
       Arjan van de Ven <arjan@infradead.org>
In-Reply-To: <E472128B1EB43941B4E7FB268020C89B149CF1@riverside.int.panasas.com>
References: <Pine.LNX.4.64.0612200942060.28362@artax.karlin.mff.cuni.cz>
	 <E1GwzsI-0004Y1-00@dorka.pomaz.szeredi.hu>
	 <20061221185850.GA16807@delft.aura.cs.cmu.edu>
	 <Pine.LNX.4.64.0612220038520.4677@artax.karlin.mff.cuni.cz>
	 <1166869106.3281.587.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.64.0612231458060.5182@artax.karlin.mff.cuni.cz>
	 <4593890C.8030207@panasas.com> <4593C524.8070209@poochiereds.net>
	 <4593DEF8.5020609@panasas.com>
	 <Pine.LNX.4.64.0612281916230.2960@artax.karlin.mff.cuni.cz>
	 <E472128B1EB43941B4E7FB268020C89B149CEC@riverside.int.panasas.com>
	 <1167388129.6106.45.camel@lade.trondhjem.org>
	 <E472128B1EB43941B4E7FB268020C89B149CF1@riverside.int.panasas.com>
Content-Type: text/plain
Date: Wed, 03 Jan 2007 00:21:37 +0100
Message-Id: <1167780097.6090.104.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-7.6, required=12.0, autolearn=ham, BAYES_00=-2.599,UIO_MAIL_IS_INTERNAL=-5)
X-UiO-Scanned: F5E92C552B1C3A374D3491DC5B09E4FD9F575F7F
X-UiO-SPAM-Test: 83.109.147.16 spam_score -75 maxlevel 200 minaction 2 bait 0 blacklist 0 greylist 0 ratelimit 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-12-31 at 16:25 -0500, Halevy, Benny wrote:
> Trond Myklebust wrote:
> >  
> > On Thu, 2006-12-28 at 15:07 -0500, Halevy, Benny wrote:
> > > Mikulas Patocka wrote:
> > 
> > > >BTW. how does (or how should?) NFS client deal with cache coherency if 
> > > >filehandles for the same file differ?
> > > >
> > > 
> > > Trond can probably answer this better than me...
> > > As I read it, currently the nfs client matches both the fileid and the
> > > filehandle (in nfs_find_actor). This means that different filehandles
> > > for the same file would result in different inodes :(.
> > > Strictly following the nfs protocol, comparing only the fileid should
> > > be enough IF fileids are indeed unique within the filesystem.
> > > Comparing the filehandle works as a workaround when the exported filesystem
> > > (or the nfs server) violates that.  From a user stand point I think that
> > > this should be configurable, probably per mount point.
> > 
> > Matching files by fileid instead of filehandle is a lot more trouble
> > since fileids may be reused after a file has been deleted. Every time
> > you look up a file, and get a new filehandle for the same fileid, you
> > would at the very least have to do another GETATTR using one of the
> > 'old' filehandles in order to ensure that the file is the same object as
> > the one you have cached. Then there is the issue of what to do when you
> > open(), read() or write() to the file: which filehandle do you use, are
> > the access permissions the same for all filehandles, ...
> > 
> > All in all, much pain for little or no gain.
> 
> See my answer to your previous reply.  It seems like the current
> implementation is in violation of the nfs protocol and the extra pain
> is required.

...and we should care because...?

Trond

