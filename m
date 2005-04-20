Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261739AbVDTTxP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261739AbVDTTxP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Apr 2005 15:53:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261754AbVDTTxP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Apr 2005 15:53:15 -0400
Received: from mail-in-09.arcor-online.net ([151.189.21.49]:9660 "EHLO
	mail-in-09.arcor-online.net") by vger.kernel.org with ESMTP
	id S261739AbVDTTxK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Apr 2005 15:53:10 -0400
From: "Bodo Eggert <harvested.in.lkml@posting.7eggert.dyndns.org>" 
	<7eggert@gmx.de>
Subject: Re: [RFC] FUSE permission modell (Was: fuse review bits)
To: Mike Waychison <mike@waychison.com>,
       Eric Van Hensbergen <ericvh@gmail.com>,
       Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, hch@infradead.org, akpm@osdl.org,
       viro@parcelfarce.linux.theplanet.co.uk
Reply-To: 7eggert@gmx.de
Date: Wed, 20 Apr 2005 21:52:31 +0200
References: <3UrQt-2Js-3@gated-at.bofh.it> <3SpIW-6UA-17@gated-at.bofh.it> <3SpIW-6UA-19@gated-at.bofh.it> <3SpIW-6UA-21@gated-at.bofh.it> <3UrQt-2Js-5@gated-at.bofh.it> <3UrQt-2Js-1@gated-at.bofh.it> <3UZyS-55i-39@gated-at.bofh.it> <3V2wG-7HR-19@gated-at.bofh.it> <3V2PX-7Vh-23@gated-at.bofh.it> <3V6Ae-2Ce-17@gated-at.bofh.it> <3V6JW-2K9-49@gated-at.bofh.it> <3VeHl-NF-3@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Message-Id: <E1DOLFQ-0002S6-EP@be1.7eggert.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Waychison <mike@waychison.com> wrote:

> Consider the following pseudo example:
> 
> main():
> chdir("/");
> fd = open(".", O_RDONLY);
> clone(cloned_func, cloned_stack, CLONE_NEWNS, NULL);
> 
> cloned_func:
> fchdir(fd);
> chdir("..");
> 
> if main is run within a chroot where it's "/" is on the same vfsmount as
>  it's "..", then the application can step out of the chroot using clone(2).
> 
> Note: using chdir in a vfsmount outside of your namespace works, however
> you won't be able to walk off that vfsmount (to its parent or children).

IMO the '..' file descriptor should be attached to it's chroot domain.
This should avoid all chroot-escapes, even with fd-passing etc.

I wonder why nobody thought of that. Either it's too obvious or too stupid.
-- 
Funny quotes:
7. You have the right to remain silent. Anything you say will be misquoted,
   then used against you.

