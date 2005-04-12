Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262057AbVDLG3L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262057AbVDLG3L (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 02:29:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262040AbVDLG3I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 02:29:08 -0400
Received: from rev.193.226.232.28.euroweb.hu ([193.226.232.28]:989 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S262021AbVDLG2H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 02:28:07 -0400
To: dan@debian.org
CC: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       hch@infradead.org, akpm@osdl.org,
       viro@parcelfarce.linux.theplanet.co.uk
In-reply-to: <20050411221324.GA10541@nevyn.them.org> (message from Daniel
	Jacobowitz on Mon, 11 Apr 2005 18:13:24 -0400)
Subject: Re: [RFC] FUSE permission modell (Was: fuse review bits)
References: <20050331200502.GA24589@infradead.org> <E1DJsH6-0004nv-00@dorka.pomaz.szeredi.hu> <20050411114728.GA13128@infradead.org> <E1DL08S-0008UH-00@dorka.pomaz.szeredi.hu> <20050411153619.GA25987@nevyn.them.org> <E1DL1Gj-000091-00@dorka.pomaz.szeredi.hu> <20050411181717.GA1129@nevyn.them.org> <E1DL4J4-0000Py-00@dorka.pomaz.szeredi.hu> <20050411192223.GA3707@nevyn.them.org> <E1DL51J-0000To-00@dorka.pomaz.szeredi.hu> <20050411221324.GA10541@nevyn.them.org>
Message-Id: <E1DLEsQ-00015Z-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 12 Apr 2005 08:27:58 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Well the sanity check on the "server" side is always enforced.  You
> > can't "trick" sftp or ftp to not check permissions.  So checking on
> > the "client" side too (where the fuse daemon is running) makes no
> > sense, does it?
> 
> That argument doesn't make much sense to me.  But we're at the end of
> my useful contributions to this discussion; I'm going to be quiet now
> and hope some folks who know more about filesystems have more useful
> responses.

I'm sorry if this isn't clear enough.  My explanatory powers are not
very strong, so please bear with me.

Imagine an sftp session.  You list the files on the remote server.
You want download a file for which there are very limited permission
(e.g. only readable to owner).  You don't _know_ if you are the owner
since the uid on the file does not ring any bells, but you still try,
since you want that file badly.  And you succeed.

Would it make sense if the sftp client would try to interpret the
uid/gid/permission on each file?  Obviously not.

The same is true for the case when you mount an sshfs.  Since you
entered your password (or have a passwordless login to the server) you
are authorized to browse the files on the server, but only with the
capabilities you have there as a user.  The server does the
authorization.  The same is true for an NFS mount btw.  It's not the
client that checks the permissions.

So do you see why I argue in favor of having an option _not_ to check
permissions on the client by the kernel?

Thanks,
Miklos

