Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751418AbWEOE2w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751418AbWEOE2w (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 00:28:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751420AbWEOE2v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 00:28:51 -0400
Received: from py-out-1112.google.com ([64.233.166.178]:48907 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751418AbWEOE2u convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 00:28:50 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Out0N8ZFHzmWCMffSYfuSHtJEnr0VgOftnxsm5IumKteH/fD/qxC/p8k759NC/Drw0+n3wCA8zVEtBYn5pLxTQgWw+KVa2t7zZupIG1OsFFtQvhw9Et9ttyhEuIoGEs6wXFNXfkEGyvD7is+sr2xpa3x+4XviyBCM9eQcM/WQqQ=
Message-ID: <bda6d13a0605142128p4ef3423cr1cbe9dd364e45086@mail.gmail.com>
Date: Sun, 14 May 2006 21:28:49 -0700
From: "Joshua Hudson" <joshudson@gmail.com>
To: "Kyle Moffett" <mrmacman_g4@mac.com>, linux-kernel@vger.kernel.org
Subject: Re: Which process context does /sbin/hotplug run in?
In-Reply-To: <6BCF90AC-FF8B-48BC-8659-DBE0DD00E270@mac.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200605121421.00044.rob@landley.net>
	 <F68E5CEA-AB95-4E1C-9923-0882394AE16E@mac.com>
	 <200605142008.39420.rob@landley.net>
	 <6BCF90AC-FF8B-48BC-8659-DBE0DD00E270@mac.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> > And I'm not _complaining_ about it.  Just fiddling around with fun
> > stuff.  If I get really bored I'll figure a way to split the tree
> > so there are two completely unconnected mount trees in different
> > processes.  (Get a private  namespace that's chrooted into
> > something that somebody else does a umount -l on from their space.
> > Or without using umount -l, just have two processes chroot into
> > other mount points which should theoretically garbage collect the
> > old root if no processes still references it, which presumably
> > means one of the processes is init...)
>
> Well, actually, it isn't that hard.  Just run something like this:
>
> #! /bin/sh
> mkdir /a
> mkdir /b
> mount -t tmpfs tmpfs /a
> mount -t tmpfs tmpfs /b
> mkdir /a/old
> mkdir /b/old
> tool_to_fork_in_new_namespace sh -c "pivot_root /a /a/old && umount -
> l /a/old && read"
> pivot_root /b /b/old && umount -l /b/old && read
>
> All you need to write is tool_to_fork_in_new_namespace which does
> clone(CLONE_NEWNS) followed by exec().
>
> Cheers,
> Kyle Moffett
>
I've done that "two disconnected trees" in 2.0 kernel. Boot with an initrd.
/linuxrc runs something in the background (telnet server, just for kicks)
/initrd doesn't exist ont the new root.
So, try mount new root succeeds, but try unmount old root fails.
Presto. Two disconnected trees.

I wonder if it still works.
