Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315612AbSECJJ4>; Fri, 3 May 2002 05:09:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315613AbSECJJz>; Fri, 3 May 2002 05:09:55 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:34794 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S315612AbSECJJy>;
	Fri, 3 May 2002 05:09:54 -0400
Date: Fri, 3 May 2002 05:09:53 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Paul Menage <pmenage@ensim.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Replace exec_permission_lite() with inlined vfs_permission()
In-Reply-To: <E173Yyh-0004zD-00@pmenage-dt.ensim.com>
Message-ID: <Pine.GSO.4.21.0205030504490.18432-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 3 May 2002, Paul Menage wrote:

> 
> How about something like the patch below?
> 
> - i_op->permission() now takes an extra argument, "dcache_locked", and 
> should return -EAGAIN if it's called with the dcache_lock held and it 
> can't handle it.

Argument-dependent locking rules are Wrong.  In any case, what does it
buy you compared to extra method?  You need to change every instance
since you are adding an argument.  Moreover, the thing you had proposed
for procfs means that we'll need to check the argument and grab dcache_lock
if it's 0.  Plus similar fun with unlocking.

