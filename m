Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264917AbTFQUEv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 16:04:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264918AbTFQUEu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 16:04:50 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:25656 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S264917AbTFQUEu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 16:04:50 -0400
Date: Tue, 17 Jun 2003 13:19:27 -0700
From: Andrew Morton <akpm@digeo.com>
To: sct@redhat.com, roy@karlsbakk.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] O_DIRECT for ext3 (2.4.21)
Message-Id: <20030617131927.2ac04150.akpm@digeo.com>
In-Reply-To: <20030617130142.50775749.akpm@digeo.com>
References: <20030615110106.GA8404@karlsbakk.net>
	<1055861357.4240.11.camel@sisko.scot.redhat.com>
	<20030617130142.50775749.akpm@digeo.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 17 Jun 2003 20:18:45.0529 (UTC) FILETIME=[A75DB890:01C3350D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@digeo.com> wrote:
>
> I think the check should be implemented in (the new) ext3_open().  Because
>  checking the return from open() is the way in which a good application would
>  determine whether the underlying fs supports O_DIRECT.
> 
>  Unfortunately O_DIRECT can also be set with fcntl(F_SETFL), and we seem to
>  have forgotten to provide a way for the fs to be told about fcntl.

It works out OK in 2.5, and we should do it this way in 2.4 too:

- dentry_open() checks for inode->i_mapping->a_ops->direct_IO

- setfl() checks for inode->i_mapping->a_ops->direct_IO

- the a_ops for data-journalled inodes have a null ->direct_IO.


