Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261264AbVBYT4U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261264AbVBYT4U (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 14:56:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261268AbVBYT4U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 14:56:20 -0500
Received: from fire.osdl.org ([65.172.181.4]:51690 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261264AbVBYT4Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 14:56:16 -0500
Date: Fri, 25 Feb 2005 11:57:03 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: David Howells <dhowells@redhat.com>
cc: Andrew Morton <akpm@osdl.org>, kwc@citi.umich.edu,
       Kernel Mailing List <linux-kernel@vger.kernel.org>, nfsv4@linux-nfs.org
Subject: Re: [PATCH] Properly share process and session keyrings with
 CLONE_THREAD
In-Reply-To: <25723.1109339172@redhat.com>
Message-ID: <Pine.LNX.4.58.0502251149320.9237@ppc970.osdl.org>
References: <25723.1109339172@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 25 Feb 2005, David Howells wrote:
> 
> The attached patch causes process and session keyrings to be shared properly
> when CLONE_THREAD is in force. It does this by moving the keyring pointers
> into struct signal_struct[*].

I do not see the point of associating keys with signal state. 

And it _is_ signal state, even if some people mistakenly think that it's 
about "processes". Linux still hasn't fallen into the trap of believing 
that POSIX threads are somehow magical and the only way to do things.

The kernel very much believes in various shared resources. Signal state
(tty, resource limits, and actual signals handlers) is one such shared
thing, but so is VM state, file table state etc etc. Why would keys
logically be associated with signals, and not with the file table, for
example? Or the VM? Or just per-thread?

In other words, what does this buy us, if anything? From a logical 
standpoint, I'd have said that it makes more sense to associate this with 
the filesystem information, since keys would tend to mostly go together 
with the notion of permissions on file descriptors.

Making keys be associated with signals just doesn't seem to make any 
sense.

			Linus
