Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266220AbTIKH3N (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 03:29:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266223AbTIKH3N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 03:29:13 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:15763 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266220AbTIKH3L
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 03:29:11 -0400
Date: Thu, 11 Sep 2003 08:29:09 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Local DoS on single_open?
Message-ID: <20030911072909.GT454@parcelfarce.linux.theplanet.co.uk>
References: <3F5FFF3D.9040707@cyberone.com.au> <5196.1063263888@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5196.1063263888@kao2.melbourne.sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 11, 2003 at 05:04:48PM +1000, Keith Owens wrote:
> On Thu, 11 Sep 2003 14:51:09 +1000, 
> Nick Piggin <piggin@cyberone.com.au> wrote:
> >Keith Owens wrote:
> >
> >>single_open() requires the kernel to kmalloc a buffer which lives until
> >>the userspace caller closes the file.  What prevents a malicious user
> >>opening the same /proc entry multiple times, allocating lots of kmalloc
> >>space and causing a local DoS?
> >>  
> >>
> >
> >ulimit?
> 
> ulimit has no effect on kmalloc usage.

You do realize that struct file is also kmalloc'ed?  So are dentries and
inodes, for that matter.  It's the same situation as with pipes and sockets.
