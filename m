Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261534AbSJILXs>; Wed, 9 Oct 2002 07:23:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261535AbSJILXr>; Wed, 9 Oct 2002 07:23:47 -0400
Received: from ns.suse.de ([213.95.15.193]:33030 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S261534AbSJILXr> convert rfc822-to-8bit;
	Wed, 9 Oct 2002 07:23:47 -0400
Content-Type: text/plain; charset=US-ASCII
From: Andreas Gruenbacher <agruen@suse.de>
Organization: SuSE Linux AG
To: "Theodore Ts'o" <tytso@mit.edu>, "Stephen C. Tweedie" <sct@redhat.com>
Subject: Re: [Ext2-devel] [RFC] [PATCH 3/4] Add extended attributes to ext2/3
Date: Wed, 9 Oct 2002 13:29:28 +0200
User-Agent: KMail/1.4.3
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net
References: <E17yymK-00021n-00@think.thunk.org> <20021008214143.O2717@redhat.com> <20021008221710.GA9842@think.thunk.org>
In-Reply-To: <20021008221710.GA9842@think.thunk.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210091329.28153.agruen@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 09 October 2002 00:17, Theodore Ts'o wrote:
> On Tue, Oct 08, 2002 at 09:41:43PM +0100, Stephen C. Tweedie wrote:
> > On Tue, Oct 08, 2002 at 08:20:38PM +0100, Christoph Hellwig wrote:
> > > On Tue, Oct 08, 2002 at 09:14:00PM +0200, Andreas Gruenbacher wrote:
> > > > Users might just fill up all xattr space leaving no space for ACLs
> > > > (or similar). If user xattrs are disabled this can no longer occur,
> > > > so some administrators might be happy to have a choice.
> > >
> > > Umm, that's why we have quota..
> >
> > It's the per-inode extended attribute space that's at risk here,
> > quotas don't help.
>
> Well, how about this as a compromise?  We define a new superblock
> field which reserves a certain amount of space in the EA block for
> "system" attributes.  The default will be zero, but if we want to
> reserve space for the ACL, we can do that by adjusting the superblock
> field.  (I'll add support into tune2fs for that purpose.)
>
> I'll then remove the CONFIG #ifdef's and the user_xattr mount options.
> (I hate having too many mount options, and this sort of thing should
> be a per-filesystem run-time decision, not a compile-time option.)
>
> Andreas, does that sound good to you?

I'd rather not store such policy things on the file system permanently, and 
make it a mount option. I'm wondering how many installations this would 
affect; to me it seems that it's not worth a super block flag.

Eventually we will hopefully move to a more flexible xattr storage mechanism; 
that hack will then just become baggage.

--Andreas.

