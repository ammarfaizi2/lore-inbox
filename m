Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750774AbWBXHRT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750774AbWBXHRT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 02:17:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750777AbWBXHRT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 02:17:19 -0500
Received: from smtp.osdl.org ([65.172.181.4]:52697 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750774AbWBXHRT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 02:17:19 -0500
Date: Thu, 23 Feb 2006 23:16:21 -0800
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: john@johnmccutchan.com, holt@sgi.com, linux-kernel@vger.kernel.org,
       rml@novell.com, arnd@arndb.de, hch@lst.de, dipankar@in.ibm.com
Subject: Re: udevd is killing file write performance.
Message-Id: <20060223231621.0f5d5b8a.akpm@osdl.org>
In-Reply-To: <43FEB0BF.6080403@yahoo.com.au>
References: <20060222134250.GE20786@lnx-holt.americas.sgi.com>
	<1140626903.13461.5.camel@localhost.localdomain>
	<20060222175030.GB30556@lnx-holt.americas.sgi.com>
	<1140648776.1729.5.camel@localhost.localdomain>
	<20060222151223.5c9061fd.akpm@osdl.org>
	<1140651662.2985.2.camel@localhost.localdomain>
	<20060223161425.4388540e.akpm@osdl.org>
	<20060224054724.GA8593@johnmccutchan.com>
	<20060223220053.2f7a977e.akpm@osdl.org>
	<43FEB0BF.6080403@yahoo.com.au>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <nickpiggin@yahoo.com.au> wrote:
>
> @@ -538,7 +579,7 @@ void inotify_dentry_parent_queue_event(s
>   	struct dentry *parent;
>   	struct inode *inode;
>   
>  -	if (!atomic_read (&inotify_watches))
>  +	if (!(dentry->d_flags & DCACHE_INOTIFY_PARENT_WATCHED))

Yeah, I think that would work.  One would need to wire up d_move() also -
for when a file is moved from a watched to non-watched directory and
vice-versa.

