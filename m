Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265909AbUGZUUr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265909AbUGZUUr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 16:20:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265777AbUGZUSu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 16:18:50 -0400
Received: from dh132.citi.umich.edu ([141.211.133.132]:42133 "EHLO
	lade.trondhjem.org") by vger.kernel.org with ESMTP id S265879AbUGZThe convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 15:37:34 -0400
Subject: Re: bug with multiple mounts of filesystems in 2.6
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: John S J Anderson <jacobs@genehack.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <86oem2hgv8.fsf@mendel.genehack.org>
References: <86oem2hgv8.fsf@mendel.genehack.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-Id: <1090870651.6809.62.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 26 Jul 2004 15:37:31 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

På må , 26/07/2004 klokka 12:29, skreiv John S J Anderson:
>   Hi --
> 
>   We're working on migrating to the 2.6 kernel series, and one big
>   problem has popped up: we have a number of NFS mounts that are
>   mounted read-only in one location and read-write in a distinct
>   location (on the same machine). With 2.4 series kernels, this worked
>   without issue, but with 2.6, it doesn't: it's not possible to mount
>   the same filesystem twice with different options for each mount; the
>   two mount points have to share the same mount options.

That behaviour is no longer supported as it meant that you would have
different superblocks (and hence different out-of-sync caches) between
the 2 mountpoint. It is in any case not a behaviour that is supported on
any other Linux filesystems.

If you want readonly to be an exception, then you will have to move the
MS_RDONLY flag from being a superblock option to being a vfsmount
option, then propagate that vfsmount information down to all the tests
of IS_RDONLY(inode). Not a trivial task, and not one that looms high on
my list of priorities...

Cheers,
  Trond
