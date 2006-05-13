Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932455AbWEMPpP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932455AbWEMPpP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 11:45:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932453AbWEMPpO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 11:45:14 -0400
Received: from smtp.osdl.org ([65.172.181.4]:25296 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932452AbWEMPpN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 11:45:13 -0400
Date: Sat, 13 May 2006 08:42:08 -0700
From: Andrew Morton <akpm@osdl.org>
To: Paul Clements <paul.clements@steeleye.com>
Cc: neilb@suse.de, linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 008 of 8] md/bitmap: Change md/bitmap file handling to
 use bmap to file blocks.
Message-Id: <20060513084208.0857ff52.akpm@osdl.org>
In-Reply-To: <4465FB5C.6070808@steeleye.com>
References: <20060512160121.7872.patches@notabene>
	<1060512060809.8099@suse.de>
	<20060512104750.0f5cb10a.akpm@osdl.org>
	<17509.22160.118149.49714@cse.unsw.edu.au>
	<20060512235934.4f609019.akpm@osdl.org>
	<4465FB5C.6070808@steeleye.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Clements <paul.clements@steeleye.com> wrote:
>
> Andrew Morton wrote:
> 
> > The loss of pagecache coherency seems sad.  I assume there's never a
> > requirement for userspace to read this file.
> 
> Actually, there is. mdadm reads the bitmap file, so that would be 
> broken. Also, it's just useful for a user to be able to read the bitmap 
> (od -x, or similar) to figure out approximately how much more he's got 
> to resync to get an array in-sync. Other than reading the bitmap file, I 
> don't know of any way to determine that.

Read it with O_DIRECT :(
