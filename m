Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264377AbTGKQtN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 12:49:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264376AbTGKQtN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 12:49:13 -0400
Received: from air-2.osdl.org ([65.172.181.6]:59624 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264374AbTGKQtJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 12:49:09 -0400
Date: Fri, 11 Jul 2003 10:03:44 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux FSdevel <linux-fsdevel@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.75 Support dentry revalidation under open(".")
In-Reply-To: <16142.54383.804882.881178@charged.uio.no>
Message-ID: <Pine.LNX.4.44.0307110955180.3452-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 11 Jul 2003, Trond Myklebust wrote:
>
>   The following patch provides a way to do such revalidation for NFS
> without impacting other filesystems.

I'm not sure. It may not impact other filesystems, but it impacts the
internal consistency of the dentry tree, and can cause some really nasty
aliasing issues.

If d_invalidate() returns a failure, that means that the dentry is still
hashed (because it was busy), and returning NULL and leaving the dentry
there sounds very wrong, since it can never be fixed with a new lookup.

				Linus

