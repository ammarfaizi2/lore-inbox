Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262543AbVDYGly@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262543AbVDYGly (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 02:41:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262547AbVDYGly
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 02:41:54 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:19936 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262543AbVDYGlp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 02:41:45 -0400
Subject: Re: [PATCH] private mounts
From: Ram <linuxram@us.ibm.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: jamie@shareable.org, viro@parcelfarce.linux.theplanet.co.uk,
       hch@infradead.org, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
In-Reply-To: <E1DPwdo-0006xF-00@dorka.pomaz.szeredi.hu>
References: <E1DPnOn-0000T0-00@localhost>
	 <20050424201820.GA28428@infradead.org> <E1DPo3I-0000V0-00@localhost>
	 <20050424205422.GK13052@parcelfarce.linux.theplanet.co.uk>
	 <E1DPoCg-0000W0-00@localhost>
	 <20050424210616.GM13052@parcelfarce.linux.theplanet.co.uk>
	 <20050424213822.GB9304@mail.shareable.org>
	 <E1DPwdo-0006xF-00@dorka.pomaz.szeredi.hu>
Content-Type: text/plain
Organization: IBM 
Message-Id: <1114411302.4480.70.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 24 Apr 2005 23:41:42 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-04-24 at 23:00, Miklos Szeredi wrote:
> > > 
> > > ... is the same as for the same question with "set of mounts" replaced
> > > with "environment variables".
> > 
> > Not quite.
> > 
> > After changing environment variables in .profile, you can copy them to
> > other shells using ". ~/.profile".
> > 
> > There is no analogous mechanism to copy namespaces.
> > 
> > I agree with you that Miklos' patch is not the right way to do it.
> 
> I'm not sure that it is either.  But, see bellow...
> 
> > Much better is the proposal to make namespaces first-class objects,
> > that can be switched to.  Then users can choose to have themselves a
> > namespace containing their private mounts, if they want it, with
> > login/libpam or even a program run from .profile switching into it.
> 
> It would be good if it could be done just in libpam.  But that would
> require every libpam user to call into it after the fork() or
> whatever, so unshare() and join_namespace() don't mess up the server
> running environment.
> 
> If not, then it would mean modifying numerous programs, having these
> modifications integrated, then having distributions pick up the
> changes, etc.  I would imagine quite a long cycle for this to be
> acutally useful.
> 
> > While users can be allowed to create their own namespaces which affect
> > the path traversal of their _own_ directories, it's important that the
> > existence of such namespaces cannot affect path traversal of other
> > directories such as /etc, or /autofs/whatever - and that creation of
> > namespaces by a user cannot prevent the unmounting of a non-user
> > filesystem either.
> > 
> > The way to do that is shared subtrees, or something along those lines.
> 
> Yes, but we would be achieving essentially the same as my patch, just
> with more complexity.  And my patch achieves what FUSE does in 2 lines
> of code, namely hide the mount from other users by returning -EACCESS
> in case fsuid does not mach the mount owner.
> 

I have not yet sure how invisible mount can be used to solve the FUSE
problem.  

Again my understanding of the basic requirement of FUSE is:

1. A user being able to setup his own VFS-mount environment which
  	 is only visible to the user. 
2. The same user being able to see exactly the same VFS-mount  
	environment from any login session.

RP

> I aggree that your solution is more flexible, but it's also hugely
> more complex.  If somebody want's to implement it, fine.  But don't
> expect me to do it, unless some company hires my for fs development
> (hint, hint ;) 



> 
> Thanks,
> Miklos
> -
> To unsubscribe from this list: send the line "unsubscribe linux-fsdevel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

