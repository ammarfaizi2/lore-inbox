Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262081AbVDLGM2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262081AbVDLGM2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 02:12:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262061AbVDLGMT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 02:12:19 -0400
Received: from rev.193.226.232.28.euroweb.hu ([193.226.232.28]:59100 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S262082AbVDLGLV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 02:11:21 -0400
To: jamie@shareable.org
CC: dan@debian.org, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, hch@infradead.org, akpm@osdl.org,
       viro@parcelfarce.linux.theplanet.co.uk
In-reply-to: <20050411214123.GF32535@mail.shareable.org> (message from Jamie
	Lokier on Mon, 11 Apr 2005 22:41:23 +0100)
Subject: Re: [RFC] FUSE permission modell (Was: fuse review bits)
References: <20050331200502.GA24589@infradead.org> <E1DJsH6-0004nv-00@dorka.pomaz.szeredi.hu> <20050411114728.GA13128@infradead.org> <E1DL08S-0008UH-00@dorka.pomaz.szeredi.hu> <20050411153619.GA25987@nevyn.them.org> <E1DL1Gj-000091-00@dorka.pomaz.szeredi.hu> <20050411181717.GA1129@nevyn.them.org> <E1DL4J4-0000Py-00@dorka.pomaz.szeredi.hu> <20050411192223.GA3707@nevyn.them.org> <E1DL51J-0000To-00@dorka.pomaz.szeredi.hu> <20050411214123.GF32535@mail.shareable.org>
Message-Id: <E1DLEby-00013d-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 12 Apr 2005 08:10:58 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I think that would be _much_ nicer implemented as a mount which is
> invisible to other users, rather than one which causes the admin's
> scripts to spew error messages.

Spew is a strong word.  It'll get a single EACCES at the mountpoint.
The same is true for directories not accessible by 'nobody' under an
NFS mount exported with root squash.  

> Is the namespace mechanism at all suitable for that?

It is certainly the right tool for this.  However currently private
namespaces are quite limited.  The only sane usage I can think of is
that before mounting the user starts a shell with CLONE_NS, and does
the mount in this.  However all the other programs he already has
running (editor, browser, desktop environment) won't be able to access
the mount.

Shared subtrees and more support in userspace tools is needed before
private namespaces can become really useful.

> It would also be nice to generalise and have virtual filesystems which
> are able to present different views to different users.  Can FUSE do
> that already - is the userspace part told which user is doing each
> operation?

Yes.

> With that, the desire for virtual filesystems which cannot be read
> by your sysadmin (by accident) is easy to satisfy - and that kind of
> mechanism would probably be acceptable to all.

The problem is that this way the responsibility goes to the userspace
program, which can't be trusted.

Either the kernel has to enforce that uid/gid on each file are set to
the mount owner, or the kernel has to enforce that no other user has
access to the mountpoint.  Some policy _must_ be kept in kernel.

I think both these policies have valid uses, so I wouldn't want to
limit FUSE to a single one.  Hmm?

Thanks,
Miklos
