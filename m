Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129341AbRBTBfE>; Mon, 19 Feb 2001 20:35:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129358AbRBTBex>; Mon, 19 Feb 2001 20:34:53 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.29]:32775 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S129341AbRBTBem>; Mon, 19 Feb 2001 20:34:42 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Chris Mason <mason@suse.com>
Date: Tue, 20 Feb 2001 12:34:28 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14993.51620.380828.269557@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net
Subject: Re: problems with reiserfs + nfs using 2.4.2-pre4
In-Reply-To: message from Chris Mason on Monday February 19
In-Reply-To: <14993.48376.203279.390285@notabene.cse.unsw.edu.au>
	<1633680000.982631746@tiny>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday February 19, mason@suse.com wrote:
> 
> 
> On Tuesday, February 20, 2001 11:40:24 AM +1100 Neil Brown
> <neilb@cse.unsw.edu.au> wrote:
> > 
> >   When reiserfs came along, it abused this, and re-interpreted the
> >   opaque datum to contain information for recalling (locating) an
> >   inode - if read_inode2 was defined.  I think this is wrong.
> >
> 
> I suggested to Al Viro a while ago to break iget up into two calls, and
> then got sucked into something else and didn't follow up.  Independently,
> he came up with the below message during a thread on fs-devel about
> read_inode.  I think it is very similar to what you've described, and it
> should work.  I'm willing to help integrate/code once things settle down
> for 2.4.

I must have missed that thread...
Yes, what Al Viro suggests is exactly the same idea as mine, except
that I suggest leaving iget as it is and getting the filesystem to do
a bit of locking.

> 
> His last paragraph is also important, I'd rather see this as a new
> call...BTW, I believe XFS and GFS actually have 64 bit inode numbers, while
> reiserfs has a unique 32 bit inode number (objectid) and a unique 32 bit
> packing locality that are both required to find the object.

I think the particular need for a new call is to handle long inode
identifiers better.  The current iget4 is a bit ugly.
If/when a new iget is done to handle long identifiers elegantly, it
would probably be good to include the I_NEW stuff as well, but for now
(2.4) both long identifiers and delayed fill-in can be done without
changing iget.

NeilBrown

(what's happened to Al Viro anyway, he has been awfully quite lately?)
