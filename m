Return-Path: <linux-kernel-owner+w=401wt.eu-S933235AbWLaV0M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933235AbWLaV0M (ORCPT <rfc822;w@1wt.eu>);
	Sun, 31 Dec 2006 16:26:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933234AbWLaV0M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Dec 2006 16:26:12 -0500
Received: from gw-e.panasas.com ([65.194.124.178]:36216 "EHLO
	cassoulet.panasas.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933230AbWLaV0K convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Dec 2006 16:26:10 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [nfsv4] RE: Finding hardlinks
Date: Sun, 31 Dec 2006 16:25:17 -0500
Message-ID: <E472128B1EB43941B4E7FB268020C89B149CF1@riverside.int.panasas.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [nfsv4] RE: Finding hardlinks
Thread-Index: AccrNC0ix2DuQyhtRMKBAR17Om8GtQB7UK7n
References: <Pine.LNX.4.64.0612200942060.28362@artax.karlin.mff.cuni.cz><E1GwzsI-0004Y1-00@dorka.pomaz.szeredi.hu><20061221185850.GA16807@delft.aura.cs.cmu.edu><Pine.LNX.4.64.0612220038520.4677@artax.karlin.mff.cuni.cz><1166869106.3281.587.camel@laptopd505.fenrus.org><Pine.LNX.4.64.0612231458060.5182@artax.karlin.mff.cuni.cz><4593890C.8030207@panasas.com> <4593C524.8070209@poochiereds.net><4593DEF8.5020609@panasas.com><Pine.LNX.4.64.0612281916230.2960@artax.karlin.mff.cuni.cz><E472128B1EB43941B4E7FB268020C89B149CEC@riverside.int.panasas.com> <1167388129.6106.45.camel@lade.trondhjem.org>
From: "Halevy, Benny" <bhalevy@panasas.com>
To: "Trond Myklebust" <trond.myklebust@fys.uio.no>
Cc: "Mikulas Patocka" <mikulas@artax.karlin.mff.cuni.cz>,
       "Jan Harkes" <jaharkes@cs.cmu.edu>,
       "Miklos Szeredi" <miklos@szeredi.hu>, <linux-kernel@vger.kernel.org>,
       <nfsv4@ietf.org>, <linux-fsdevel@vger.kernel.org>,
       "Jeff Layton" <jlayton@poochiereds.net>,
       "Arjan van de Ven" <arjan@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust wrote:
>  
> On Thu, 2006-12-28 at 15:07 -0500, Halevy, Benny wrote:
> > Mikulas Patocka wrote:
> 
> > >BTW. how does (or how should?) NFS client deal with cache coherency if 
> > >filehandles for the same file differ?
> > >
> > 
> > Trond can probably answer this better than me...
> > As I read it, currently the nfs client matches both the fileid and the
> > filehandle (in nfs_find_actor). This means that different filehandles
> > for the same file would result in different inodes :(.
> > Strictly following the nfs protocol, comparing only the fileid should
> > be enough IF fileids are indeed unique within the filesystem.
> > Comparing the filehandle works as a workaround when the exported filesystem
> > (or the nfs server) violates that.  From a user stand point I think that
> > this should be configurable, probably per mount point.
> 
> Matching files by fileid instead of filehandle is a lot more trouble
> since fileids may be reused after a file has been deleted. Every time
> you look up a file, and get a new filehandle for the same fileid, you
> would at the very least have to do another GETATTR using one of the
> 'old' filehandles in order to ensure that the file is the same object as
> the one you have cached. Then there is the issue of what to do when you
> open(), read() or write() to the file: which filehandle do you use, are
> the access permissions the same for all filehandles, ...
> 
> All in all, much pain for little or no gain.

See my answer to your previous reply.  It seems like the current
implementation is in violation of the nfs protocol and the extra pain
is required.

> 
> Most servers therefore take great pains to ensure that clients can use
> filehandles to identify inodes. The exceptions tend to be broken in
> other ways

This is true maybe in linux, but not necessarily in non-linux based nfs
servers.

> (Note: knfsd without the no_subtree_check option is one of
> these exceptions - it can break in the case of cross-directory renames).
> 
> Cheers,
>   Trond


