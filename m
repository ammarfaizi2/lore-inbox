Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261794AbVCCJXa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261794AbVCCJXa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 04:23:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261752AbVCCJVv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 04:21:51 -0500
Received: from colin2.muc.de ([193.149.48.15]:60434 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S261761AbVCCJTL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 04:19:11 -0500
Date: 3 Mar 2005 10:19:08 +0100
Date: Thu, 3 Mar 2005 10:19:08 +0100
From: Andi Kleen <ak@muc.de>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Bernd Schubert <bernd-schubert@web.de>, Andreas Schwab <schwab@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: x86_64: 32bit emulation problems
Message-ID: <20050303091908.GC5215@muc.de>
References: <200502282154.08009.bernd.schubert@pci.uni-heidelberg.de> <20050302081858.GA7672@muc.de> <1109754818.10407.48.camel@lade.trondhjem.org> <200503021233.57341.bernd-schubert@web.de> <1109782387.9667.11.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1109782387.9667.11.camel@lade.trondhjem.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 02, 2005 at 08:53:07AM -0800, Trond Myklebust wrote:
> on den 02.03.2005 Klokka 12:33 (+0100) skreiv Bernd Schubert:
> 
> > > I can see no good reason for truncating inode number values on platforms
> > > that actually do support 64-bit inode numbers, but I can see several
> > 
> > Well, at least we would have a reason ;)
> 
> A 32-bit emulation mode is clearly a "platform" which does NOT support
> 64-bit inode numbers, however there is (currently) no way for the kernel
> to detect that you are running that. Any extra truncation should
> therefore ideally be done by the emulation layer rather than the kernel
> itself.

The problem here is that glibc uses stat64() which supports
64bit inode numbers. But glibc does the overflow checking itself
and generates the EOVERFLOW in user space. Nothing we can do
about that. The 64bit inodes work under 32bit too, so your
code checking for 64bitness is totally bogus.

The old stat interface doesn't check that case currently either
(will fix that), but that's not the problem here.

But in general the emulation layer cannot do truncation because
it doesn't know if it is ok to do for the low level file system.
If anything this has to be done in the fs.

-Andi
