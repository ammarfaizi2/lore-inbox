Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751865AbWB1A6i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751865AbWB1A6i (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 19:58:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751863AbWB1A6h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 19:58:37 -0500
Received: from smtp.osdl.org ([65.172.181.4]:50830 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751865AbWB1A6g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 19:58:36 -0500
Date: Mon, 27 Feb 2006 16:48:12 -0800
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: holt@SGI.com, john@johnmccutchan.com, linux-kernel@vger.kernel.org,
       rml@novell.com, hch@lst.de, linux-fsdevel@vger.kernel.org,
       Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [patch] inotify: lock avoidance with parent watch status in
 dentry
Message-Id: <20060227164812.0159eb77.akpm@osdl.org>
In-Reply-To: <44007D6C.6020909@yahoo.com.au>
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
	<20060224185632.GB343@lnx-holt.americas.sgi.com>
	<44007D6C.6020909@yahoo.com.au>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <nickpiggin@yahoo.com.au> wrote:
>
>  Previous inotify work avoidance is good when inotify is completely
>  unused, but it breaks down if even a single watch is in place anywhere
>  in the system. Robin Holt notices that udev is one such culprit - it
>  slows down a 512-thread application on a 512 CPU system from 6 seconds
>  to 22 minutes.

A problem is that the audit tree (believe it or not) adds a pile of new
inotify functionality.  I don't know what those changes do and they might
conflict with the changes you've made (apart from giving us two copies of
inotify_inode_watched()) and the audit changes were apparently only
socialised on the linux-audit mailing list and my twice-sent patch to make
the audit tree compile has been ignored for a couple of weeks.

So I'm going to bitbucket the audit tree until a) it compiles and b) its
inotify changes have been explained and reviewed and c) we've reviewed
those changes against your optimisations.  I think fixes will be needed.

