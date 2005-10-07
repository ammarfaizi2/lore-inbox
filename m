Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030474AbVJGQBn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030474AbVJGQBn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 12:01:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030475AbVJGQBn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 12:01:43 -0400
Received: from pat.uio.no ([129.240.130.16]:34525 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1030474AbVJGQBl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 12:01:41 -0400
Subject: Re: [RFC] atomic create+open
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <E1ENtzt-0005Jb-00@dorka.pomaz.szeredi.hu>
References: <E1ENWt1-000363-00@dorka.pomaz.szeredi.hu>
	 <1128616864.8396.32.camel@lade.trondhjem.org>
	 <E1ENZ8u-0003JS-00@dorka.pomaz.szeredi.hu>
	 <E1ENZCQ-0003K3-00@dorka.pomaz.szeredi.hu>
	 <1128619526.16534.8.camel@lade.trondhjem.org>
	 <E1ENZZl-0003OO-00@dorka.pomaz.szeredi.hu>
	 <1128620528.16534.26.camel@lade.trondhjem.org>
	 <E1ENZu1-0003SP-00@dorka.pomaz.szeredi.hu>
	 <1128623899.31797.14.camel@lade.trondhjem.org>
	 <E1ENani-0003c4-00@dorka.pomaz.szeredi.hu>
	 <1128626258.31797.34.camel@lade.trondhjem.org>
	 <E1ENcAr-0003jz-00@dorka.pomaz.szeredi.hu>
	 <1128633138.31797.52.camel@lade.trondhjem.org>
	 <E1ENlI2-0004Gt-00@dorka.pomaz.szeredi.hu>
	 <1128692289.8519.75.camel@lade.trondhjem.org>
	 <E1ENslH-00057W-00@dorka.pomaz.szeredi.hu>
	 <1128696477.8583.17.camel@lade.trondhjem.org>
	 <E1ENtzt-0005Jb-00@dorka.pomaz.szeredi.hu>
Content-Type: text/plain
Date: Fri, 07 Oct 2005 12:01:32 -0400
Message-Id: <1128700892.8583.46.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.887, required 12,
	autolearn=disabled, AWL 1.11, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

fr den 07.10.2005 Klokka 17:18 (+0200) skreiv Miklos Szeredi:

> > > You can replace the inode in ->create_open() if you want to.  Or let
> > > the VFS redo the lookup (as if d_revalidate() returned 0).
> > 
> > ...but I cannot do that once I get to dentry_open(). You are ignoring
> > the case of generic file open without creation.
> 
> You can't do open by inode number (or file handle, whatever)?  Only by
> name?  In that case yes, I see your problem.

As I believe I said earlier, open by inode number/filehandle/... don't
exist in the NFSv4 protocol due to the potential for races.

> > > NFS does OPEN (O_CREAT), file is opened, dentry replaced (this is not
> > > ellaborated in the pseudocode).
> > 
> > Which again only deals with the case of open(O_CREAT). My point is that
> > the race exists for the case of generic open().
> 
> And so does for setattr() etc.  You can safely return -ENOENT in these
> cases.  O_CREAT is problematic only because it cannot return -ENOENT
> if the file was removed between ->lookup and ->open.

No. There is no race for setattr() etc since they only do one lookup
(and they don't set up any state on the server).

open() is the only case where we currently have to look things up twice
(and I remind you that the second "lookup" is in fact the OPEN
operation).

Trond

