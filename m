Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262626AbRFBRAw>; Sat, 2 Jun 2001 13:00:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262628AbRFBRAm>; Sat, 2 Jun 2001 13:00:42 -0400
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:15112
	"EHLO roc-24-169-102-121.rochester.rr.com") by vger.kernel.org
	with ESMTP id <S262626AbRFBRAZ>; Sat, 2 Jun 2001 13:00:25 -0400
Date: Sat, 02 Jun 2001 13:00:15 -0400
From: Chris Mason <mason@suse.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
cc: linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net
Subject: Re: [NFS] Re: [RFC] yet another knfsd-reiserfs patch
Message-ID: <280230000.991501215@tiny>
In-Reply-To: <shssnhj267k.fsf@charged.uio.no>
X-Mailer: Mulberry/2.0.8 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Saturday, June 02, 2001 12:19:59 AM +0200 Trond Myklebust
<trond.myklebust@fys.uio.no> wrote:

> 
> Hi Chris,
> 
> Do you really need the parent inode in the filehandle?
> 
> That screws rename up pretty badly, since the filehandle changes when
> you rename into a different directory. It means for instance that when
> I do
> 
> open(foo)
> mv foo bar/
> write (foo)
> close(foo)
> 
> then I have a pretty good chance of getting an ESTALE on the write()
> statement.
> 

Hmmm, didn't realize I had only answered this in private mail.

The patch doesn't change when the parent dir's ino is included in the
filehandle, it just adds wrappers for storing it and getting it out.

For ext2, the parent inum is only sent for files when the subtree checks
are turned on (_fh_update is unchanged if no fill_fh func is provided).  

The reiserfs one always puts the parent inum into the fh, but
find_fh_dentry only pulls it out for directories or subtree checks so I
didn't add the extra logic to the reiserfs fill_fh func.

-chris

