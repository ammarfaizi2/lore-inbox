Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932275AbWCMEt7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932275AbWCMEt7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 23:49:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932302AbWCMEt7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 23:49:59 -0500
Received: from smtp.osdl.org ([65.172.181.4]:17331 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932275AbWCMEt7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 23:49:59 -0500
Date: Sun, 12 Mar 2006 20:47:36 -0800
From: Andrew Morton <akpm@osdl.org>
To: Neil Brown <neilb@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc6-mm1 (NFS tree ... busy inodes ... relatively
 harmless)
Message-Id: <20060312204736.3102c314.akpm@osdl.org>
In-Reply-To: <17428.63369.446803.958721@cse.unsw.edu.au>
References: <20060312031036.3a382581.akpm@osdl.org>
	<17428.63369.446803.958721@cse.unsw.edu.au>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown <neilb@suse.de> wrote:
>
> On Sunday March 12, akpm@osdl.org wrote:
> > 
> > - The NFS tree is a bit sick - you may see the `busy inodes - self destruct
> >   in five seconds" message when performing NFS unmounts.  It seems relatively
> >   harmless.
> 
> I think the term is "mostly harmless" ... see the entry for "Earth" in
> The Hitch-Hikers Guide To The Galaxy... :-)
> 
> I don't believe this is harmless at all, and I have an oops to prove
> it - though it is with NFSv4 which is still EXPERIMENTAL.
> 
> I don't believe it is an NFS bug at all, but a VFS bug.  It happens
> more with NFS because iput on nfs can be a lot slower due to the
> required network activity, so the race is easier to hit.

It's 100% repeatable for me, with nfsv3 unmounts.  First the busy inodes,
then a use-after-free oops if CONFIG_DEBUG_PAGEALLOC (if that workaround
patch I have in there isn't applied).

Not a race, methinks.

