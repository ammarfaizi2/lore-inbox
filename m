Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261891AbTJIW06 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 18:26:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261956AbTJIW06
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 18:26:58 -0400
Received: from fw.osdl.org ([65.172.181.6]:51168 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261891AbTJIW05 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 18:26:57 -0400
Date: Thu, 9 Oct 2003 15:26:47 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
cc: Ulrich Drepper <drepper@redhat.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: statfs() / statvfs() syscall ballsup...
In-Reply-To: <16261.56894.8109.858323@charged.uio.no>
Message-ID: <Pine.LNX.4.44.0310091525200.20936-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 9 Oct 2003, Trond Myklebust wrote:
> 
> Question: how we're supposed to reconcile the two cases for something
> like NFS, where these 2 values are supposed to differ?

I'd suggest going for "optimal block size everywhere".

> Note that f_bsize is usually larger than f_frsize, hence conversions
> from the former to the latter are subject to rounding errors...

User space shouldn't know or care about frsize, and it doesn't even 
necessarily make any sense on a lot of filesystems, so make it easy for 
the user. It's not as if the rounding errors really matter.

		Linus

