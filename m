Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264502AbUEXSGS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264502AbUEXSGS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 14:06:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264669AbUEXSGS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 14:06:18 -0400
Received: from dh132.citi.umich.edu ([141.211.133.132]:3203 "EHLO
	lade.trondhjem.org") by vger.kernel.org with ESMTP id S264502AbUEXSGQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 14:06:16 -0400
Subject: Re: [PATCH/RFC] Lustre VFS patch
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: hch@infradead.org
Cc: "Peter J. Braam" <braam@clusterfs.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       "'Phil Schwan'" <phil@clusterfs.com>
In-Reply-To: <20040524120521.GD26863@infradead.org>
References: <20040524114009.96CE13100E2@moraine.clusterfs.com>
	 <20040524120521.GD26863@infradead.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-Id: <1085421973.6385.74.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 24 May 2004 14:06:13 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

På må , 24/05/2004 klokka 08:05, skreiv hch@infradead.org:
> I can't comment on the exact change, you need to talk to trond about
> these.  But as-is they change the API exported to filesystems and thus
> it's and absolute no-go for 2.6.   Where have you been when Trond's
> intent patches went in?  Hiding under a rock?

To be fair: At the time, Peter and I did indeed discuss the changes that
were needed in order to support both Lustre and NFS. The main reason why
I ended up sending in the "NFS minimal" patch was IIRC that Peter was
not ready at the time to send in a full Lustre client that could make
use of this interface.

Peter, I have a couple of objections here

        vfs_intent-flags_rename-vanilla-2.6.patch and
        vfs-intent_exec-vanilla-2.6.patch breaks NFS (though ironically
        it fixes CIFS) due to that gratuitous change of semantics from
        FMODE_READ/FMODE_WRITE to O_RDONLY/O_WRONLY/O_RDWR. Exactly why
        couldn't Lustre work with the native VFS semantics?
        
        vfs_intent-flags_rename-vanilla-2.6.patch also reverts the
        format from being a union of intents for various operations to
        being a single structure. This goes against what was agreed upon
        on linux-fsdevel when this issue was discussed last summer (in
        fact Linus was the one who requested the union approach). What
        justification exists now for a change?

        The vfs-intent_lustre-vanilla-2.6.patch + the "intent_release()"
        code. What if you end up crossing a mountpoint? How do you then
        know to which superblock/filesystem the private field belongs if
        there are more than one user of this mechanism?

        vfs-revalidate_counter-vanilla-2.6.patch: can't "counter" be put
        into the private part of your intent structure so that the whole
        test may be done within Lustre?

        vfs-revalidate_special-vanilla-2.6.patch: see the use of the
        flag FS_REVAL_DOT in order to enable the revalidation of the
        current directory for those filesystems that need to do so.

Cheers,
  Trond
