Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262563AbTDYB6q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 21:58:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262659AbTDYB6q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 21:58:46 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:48748 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S262563AbTDYB6q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 21:58:46 -0400
Date: Thu, 24 Apr 2003 19:10:50 -0700
Message-Id: <200304250210.h3P2AoU12348@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
       Ulrich Drepper <drepper@redhat.com>
Subject: Re: [PATCH] i386 vsyscall DSO implementation
In-Reply-To: Jeff Garzik's message of  Thursday, 24 April 2003 21:49:33 -0400 <3EA8942D.4050201@pobox.com>
X-Windows: even not doing anything would have been better than nothing.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> We already embed a cpio archive into __initdata space.  What about 
> putting the images in there, and either copying the data out of 
> initramfs, or, directly referencing the pages that store each image?

It doesn't matter to me, but I don't see the benefit to doing that.  It's
rather unlike what initramfs is used for now and would need a bunch of
extra code to accomplish something very simple.  

The DSO images are not stored page-aligned and padded in the kernel image,
so the pages can't be used directly.  Storing them that way would use more
space in the kernel image on disk, and then you'd want to free initdata
page containing the unused one.
