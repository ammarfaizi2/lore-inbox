Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030192AbWBYKNY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030192AbWBYKNY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 05:13:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030196AbWBYKNY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 05:13:24 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:32689 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1030192AbWBYKNX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 05:13:23 -0500
Date: Sat, 25 Feb 2006 10:13:18 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Christoph Hellwig <hch@infradead.org>, Ulrich Drepper <drepper@redhat.com>,
       akpm@osdl.org, linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH] flags parameter for linkat
Message-ID: <20060225101317.GI27946@ftp.linux.org.uk>
References: <200602231410.k1NEAMk1021578@devserv.devel.redhat.com> <20060225091606.GA22749@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060225091606.GA22749@infradead.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 25, 2006 at 09:16:07AM +0000, Christoph Hellwig wrote:
> Please stop adding these crappy flags argument everywhere, they're also
> creaping like a cancer through the other *at stuff.  Just make linkat
> do the righ thing per posix spec for link, and then you can implement
> a posix link based on it in glibc if the user compiles with XOPEN_SOURCE
> or whatever.

It's a bloody bad idea, since XOPEN_SOURCE is nowhere near fine-grained
enough and could be forced by any number of things.

The _real_ issue with flags is the lack of filtering.  I.e. we blindly
pass userland argument there, exposing both internal flag values _and_
flags that really shouldn't be exposed that way at all.
