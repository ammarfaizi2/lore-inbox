Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315040AbSDWDfx>; Mon, 22 Apr 2002 23:35:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315045AbSDWDfw>; Mon, 22 Apr 2002 23:35:52 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:55499 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S315040AbSDWDfv>;
	Mon, 22 Apr 2002 23:35:51 -0400
Date: Mon, 22 Apr 2002 23:35:51 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Keith Owens <kaos@ocs.com.au>
cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] race in request_module() 
In-Reply-To: <10621.1019532649@kao2.melbourne.sgi.com>
Message-ID: <Pine.GSO.4.21.0204222333120.5686-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 23 Apr 2002, Keith Owens wrote:

> There is no such thing as a failing modprobe.  It either works and the
> module is loaded or modprobe does not work and the module is not
> loaded.  This excludes the case where a module oops during init, but
> that is not what you are worried about.
> 
> When a module is loaded, it is marked !MOD_USED_ONCE.  An explicit
> rmmod will get rid of the module but rmmod -a will not.  rmmod -a will
> not remove a module unless __MOD_INC_USE_COUNT has been issued on the
> module at least once, or the module is loaded to satisfy unresolved
> symbols from another module.


Which is still racy - open()/close() bringing stuff from the same module
during the window in question and there we go.

IOW, echo </dev/foo will merrily set MOD_USED_ONCE.

