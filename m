Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281887AbRKSECg>; Sun, 18 Nov 2001 23:02:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281800AbRKSEC1>; Sun, 18 Nov 2001 23:02:27 -0500
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:49623 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S281751AbRKSECR>; Sun, 18 Nov 2001 23:02:17 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Alexander Viro <viro@math.psu.edu>
Date: Mon, 19 Nov 2001 15:02:40 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15352.33888.506871.191768@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Devlinks.  Code.  (Dcache abuse?)
In-Reply-To: message from Alexander Viro on Friday November 16
In-Reply-To: <15348.58752.207182.488419@notabene.cse.unsw.edu.au>
	<Pine.GSO.4.21.0111160528020.5234-100000@weyl.math.psu.edu>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday November 16, viro@math.psu.edu wrote:
> 
> 
> On Fri, 16 Nov 2001, Neil Brown wrote:
> 
> > +	if (!(nd->mnt->mnt_flags & MNT_NODEV)
> > +	    && dentry->d_inode
> > +	    && (dentry->d_inode->i_mode & S_ISVTX)) {
> > +		dentry = devlink_find(dentry, link);
> 
> You are breaking vfsmount refcounting.  Badly.

I looked, and I cannot see it.
I never change the refcound on any vfsmount, nor to I make
or destroy any references to any vfsmount.
In this piece of code we don't even own a reference to "dentry" (the
caller does) so assigning over it isn't a problem either.

About the only thing that might be a bit odd here is that we change
nd->dentry a few lines later without changing nd->mnt.  But the new
dentry is always in the same dentry tree (though it is in owned
by a different filesystem).

Would you care to give a few more details?

NeilBrown
