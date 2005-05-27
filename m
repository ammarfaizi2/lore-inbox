Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261720AbVE0EUQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261720AbVE0EUQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 00:20:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261824AbVE0EUQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 00:20:16 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:63664 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261720AbVE0EUL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 00:20:11 -0400
Date: Fri, 27 May 2005 05:20:41 +0100
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: blaisorblade@yahoo.it
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [patch 4/4] uml: make it link in tt mode against NPTL glibc
Message-ID: <20050527042041.GC29811@parcelfarce.linux.theplanet.co.uk>
References: <20050527004024.606961AEE9A@zion.home.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050527004024.606961AEE9A@zion.home.lan>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 27, 2005 at 02:40:24AM +0200, blaisorblade@yahoo.it wrote:
> 
> To make sure switcheroo() can execute when we remap all the executable image,
> we used a trick to make it use a local copy of errno... this trick does not
> work with NPTL glibc, only with LinuxThreads, so use another (simpler) one to
> make it work anyway.
> 
> Might need compile testing on different host archs, since it changes
> __syscall_return from <asm/unistd.h>.

For one thing, it's broken since mmap2() doesn't exist on amd64.  This stuff
*is* low-level - as low-level as it gets.  It's clearly per-architecture.
See ftp.linux.org.uk/pub/people/viro/UM14-unmap-RC12-rc4 for a fix...
