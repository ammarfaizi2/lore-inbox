Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262608AbVCCV6l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262608AbVCCV6l (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 16:58:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262421AbVCCVvR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 16:51:17 -0500
Received: from colin2.muc.de ([193.149.48.15]:34834 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S262527AbVCCVq0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 16:46:26 -0500
Date: 3 Mar 2005 22:46:22 +0100
Date: Thu, 3 Mar 2005 22:46:22 +0100
From: Andi Kleen <ak@muc.de>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Bernd Schubert <bernd-schubert@web.de>, Andreas Schwab <schwab@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: x86_64: 32bit emulation problems
Message-ID: <20050303214622.GA1497@muc.de>
References: <200502282154.08009.bernd.schubert@pci.uni-heidelberg.de> <20050302081858.GA7672@muc.de> <1109754818.10407.48.camel@lade.trondhjem.org> <200503021233.57341.bernd-schubert@web.de> <1109782387.9667.11.camel@lade.trondhjem.org> <20050303091908.GC5215@muc.de> <1109885846.10094.21.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1109885846.10094.21.camel@lade.trondhjem.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 03, 2005 at 01:37:26PM -0800, Trond Myklebust wrote:
> to den 03.03.2005 Klokka 10:19 (+0100) skreiv Andi Kleen:
> > The problem here is that glibc uses stat64() which supports
> > 64bit inode numbers. But glibc does the overflow checking itself
> > and generates the EOVERFLOW in user space. Nothing we can do
> > about that. The 64bit inodes work under 32bit too, so your
> > code checking for 64bitness is totally bogus.
> 
> As far as the kernel is concerned, asm/posix_types defines
> __kernel_ino_t as "unsigned long" on most platforms (except a few which
> define is as "unsigned int). We don't care what size type glibc itself
> uses.

That could easily be changed and even pass out 64bit inodes
on 32bit systems.  The stat64 syscall ABI allows this.

Perhaps that should be done and then you could drop the truncation
code. 

Of couse this would expose the glibc Bug Bernd ran into on 32bit
too, but at some point they have to fix that bogosity anyways.


> So I don't see how the file system would be able to do a better job of
> truncation here. In principle you should *never* truncate inode numbers.

Agreed, except we are stuck with broken user land here.

But - if you ever chose to truncate you should do it on 64bit
system too to avoid problems with the 32bit emulation.

-Andi
