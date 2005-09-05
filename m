Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964928AbVIEXI3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964928AbVIEXI3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 19:08:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964926AbVIEXI3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 19:08:29 -0400
Received: from smtp.osdl.org ([65.172.181.4]:35972 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964928AbVIEXI2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 19:08:28 -0400
Date: Mon, 5 Sep 2005 16:06:13 -0700
From: Andrew Morton <akpm@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: teigland@redhat.com, Joel.Becker@oracle.com, ak@suse.de,
       linux-cluster@redhat.com, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [Linux-cluster] Re: GFS, what's remaining
Message-Id: <20050905160613.7b0ee7fc.akpm@osdl.org>
In-Reply-To: <1125962411.8714.46.camel@localhost.localdomain>
References: <20050901104620.GA22482@redhat.com>
	<20050903183241.1acca6c9.akpm@osdl.org>
	<20050904030640.GL8684@ca-server1.us.oracle.com>
	<200509040022.37102.phillips@istop.com>
	<20050903214653.1b8a8cb7.akpm@osdl.org>
	<20050904045821.GT8684@ca-server1.us.oracle.com>
	<20050903224140.0442fac4.akpm@osdl.org>
	<20050905043033.GB11337@redhat.com>
	<20050905015408.21455e56.akpm@osdl.org>
	<20050905092433.GE17607@redhat.com>
	<20050905021948.6241f1e0.akpm@osdl.org>
	<1125922894.8714.14.camel@localhost.localdomain>
	<20050905125309.4b657b08.akpm@osdl.org>
	<1125962411.8714.46.camel@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>
> On Llu, 2005-09-05 at 12:53 -0700, Andrew Morton wrote:
>  > >  - How are they ref counted
>  > >  - What are the cleanup semantics
>  > >  - How do I pass a lock between processes (AF_UNIX sockets wont work now)
>  > >  - How do I poll on a lock coming free. 
>  > >  - What are the semantics of lock ownership
>  > >  - What rules apply for inheritance
>  > >  - How do I access a lock across threads.
>  > >  - What is the permission model. 
>  > >  - How do I attach audit to it
>  > >  - How do I write SELinux rules for it
>  > >  - How do I use mount to make namespaces appear in multiple vservers
>  > > 
>  > >  and thats for starters...
>  > 
>  > Return an fd from create_lockspace().
> 
>  That only answers about four of the questions. The rest only come out if
>  create_lockspace behaves like a file system - in other words
>  create_lockspace is better known as either mkdir or mount.

But David said that "We export our full dlm API through read/write/poll on
a misc device.".  That miscdevice will simply give us an fd.  Hence my
suggestion that the miscdevice be done away with in favour of a dedicated
syscall which returns an fd.

What does a filesystem have to do with this?
