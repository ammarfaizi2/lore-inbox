Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264806AbUEYIXu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264806AbUEYIXu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 04:23:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264808AbUEYIXu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 04:23:50 -0400
Received: from moraine.clusterfs.com ([66.246.132.190]:53199 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S264806AbUEYIXp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 04:23:45 -0400
From: "braam" <braam@clusterfs.com>
To: "'Trond Myklebust'" <trond.myklebust@fys.uio.no>, <hch@infradead.org>
Cc: "'Linus Torvalds'" <torvalds@osdl.org>, "'Andrew Morton'" <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>, "'Phil Schwan'" <phil@clusterfs.com>,
       <oleg@clusterfs.com>
Subject: RE: [PATCH/RFC] Lustre VFS patch
Date: Tue, 25 May 2004 16:21:29 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
Thread-Index: AcRBuc7yARBI1RBhSSWvl+ArV9PetgAdj2LQ
In-Reply-To: <1085421973.6385.74.camel@lade.trondhjem.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Message-Id: <20040525082224.49F2E31017D@moraine.clusterfs.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Trond,

Thanks for your very helpful reply ... Here are a few comments. 

> Peter, I have a couple of objections here
> 
>         vfs_intent-flags_rename-vanilla-2.6.patch and
>         vfs-intent_exec-vanilla-2.6.patch breaks NFS (though 
> ironically
>         it fixes CIFS) due to that gratuitous change of semantics from
>         FMODE_READ/FMODE_WRITE to O_RDONLY/O_WRONLY/O_RDWR. 
> Exactly why
>         couldn't Lustre work with the native VFS semantics?

Our error (this patch was wrong) - you are right we should use FMODE_READ.

>         vfs_intent-flags_rename-vanilla-2.6.patch also reverts the
>         format from being a union of intents for various operations to
>         being a single structure. This goes against what was 
> agreed upon
>         on linux-fsdevel when this issue was discussed last summer (in
>         fact Linus was the one who requested the union approach). What
>         justification exists now for a change?

Justification: Linus asked me to.  He said, there is only intent data for
open really so please remove the union.  I don't particularly care.

>         The vfs-intent_lustre-vanilla-2.6.patch + the 
> "intent_release()"
>         code. What if you end up crossing a mountpoint? How 
> do you then
>         know to which superblock/filesystem the private field 
> belongs if
>         there are more than one user of this mechanism?

Well spotted.  This is only used during the last component of lookup, so we
don't much care about this as we travers intermediate path names.  Have I
missed something else here?

>         vfs-revalidate_counter-vanilla-2.6.patch: can't 
> "counter" be put
>         into the private part of your intent structure so 
> that the whole
>         test may be done within Lustre?

Clever, we will do that.

>         vfs-revalidate_special-vanilla-2.6.patch: see the use of the
>         flag FS_REVAL_DOT in order to enable the revalidation of the
>         current directory for those filesystems that need to do so.

Didn't know this flag was there, we will use FS_REVAL_DOT.

Oleg Drokin is reworking the patches for these issues.

Thanks, this simplifies things!

- Peter -

