Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284778AbRLKBX1>; Mon, 10 Dec 2001 20:23:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284776AbRLKBXR>; Mon, 10 Dec 2001 20:23:17 -0500
Received: from rj.SGI.COM ([204.94.215.100]:32964 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S284772AbRLKBXH>;
	Mon, 10 Dec 2001 20:23:07 -0500
Date: Tue, 11 Dec 2001 12:22:58 +1100
From: Timothy Shimmin <tes@boing.melbourne.sgi.com>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Nathan Scott <nathans@sgi.com>, Andreas Gruenbacher <ag@bestbits.at>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@oss.sgi.com
Subject: Re: [PATCH] Revised extended attributes interface
Message-ID: <20011211122258.V61575@boing.melbourne.sgi.com>
In-Reply-To: <20011205143209.C44610@wobbly.melbourne.sgi.com> <20011207202036.J2274@redhat.com> <20011208155841.A56289@wobbly.melbourne.sgi.com> <20011210115209.C1919@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0us
In-Reply-To: <20011210115209.C1919@redhat.com>; from sct@redhat.com on Mon, Dec 10, 2001 at 11:52:09AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2001 at 11:52:09AM +0000, Stephen C. Tweedie wrote:
> On Sat, Dec 08, 2001 at 03:58:41PM +1100, Nathan Scott wrote:
> > On Fri, Dec 07, 2001 at 08:20:36PM +0000, Stephen C. Tweedie wrote:
> > 
> > > This is looking OK as far as EAs go.  However, there is still no
> > > mention of ACLs specifically, except an oblique reference to
> > > "system.posix_acl_access".  
> > 
> > Yup - there's little mention of ACLs because they are only an
> > optional, higher-level consumer of the API, & so didn't seem
> > appropriate to document here.
> 
> Unfortunately, if there are many filesystems wanting to use posix
> ACLs, then standardising the API is still desirable.
True.

> 
> > We have implemented POSIX ACLs above this interface - there
> > is source to new versions of Andreas' user tools here:
> > http://oss.sgi.com/cgi-bin/cvsweb.cgi/linux-2.4-xfs/cmd/acl2
> > These have been tested with XFS and seem to work fine, so we
> > are ready to transition over from our old implementation to
> > this new one.
> 
> But the ACL encoding is still hobbled: there's no namespace for
> credentials other than uid/gid.  This has been brought up before, but
> it's worth going over some of the things we'd like to be able to do
> with extended credentials again:
> 
[credential examples deleted] 

> 
> Authentication is about *much* more than just local uid/gids, but the
> current EA/ACL specs are creating an implicit standard for ACLs
> without addressing any of these concerns.
> 
> > The existence of a POSIX ACL implementation using attributes
> > system.posix_acl_access and system.posix_acl_default doesn't
> > preclude other types of ACLs from being implemented (obviously
> > using different attributes) as well of course, if someone had
> > an itch to scratch.
> 
> I am not talking about other types of ACLs!  I am talking about
> *POSIX* ACLs, but using a credentials namespace which is more than
> just uid/gid.  Only the credentials change: the rest of the POSIX
> semantics still apply.  The CITI NFSv4 implementation is already doing
> POSIX ACLs and GSSAPI krb5 authentication on top of the bestbits API,
> so we already have at least one application ready and waiting to use
> such an extension.
> 

So you are particularly interested in more general "qualifiers" 
(in posix acl entry speak:).
Some people are also interested in more general "permissions" for ACEs.

Could this not be catered for independent of the proposed EA interface
for getting/setting/removing EAs ?
One could come up with more general data structures and functions
for ACLs/ACEs than what we currently propose, 
and yet still use the same EA interface.

--Tim
