Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261647AbVCCV25@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261647AbVCCV25 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 16:28:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262159AbVCCVZJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 16:25:09 -0500
Received: from relay.uni-heidelberg.de ([129.206.100.212]:63679 "EHLO
	relay.uni-heidelberg.de") by vger.kernel.org with ESMTP
	id S262403AbVCCVQm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 16:16:42 -0500
From: Bernd Schubert <bernd-schubert@web.de>
To: linux-kernel@vger.kernel.org
Subject: Re: x86_64: 32bit emulation problems
Date: Thu, 3 Mar 2005 22:16:30 +0100
User-Agent: KMail/1.6.2
Cc: Andi Kleen <ak@muc.de>, Trond Myklebust <trond.myklebust@fys.uio.no>,
       Andreas Schwab <schwab@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200502282154.08009.bernd.schubert@pci.uni-heidelberg.de> <1109782387.9667.11.camel@lade.trondhjem.org> <20050303091908.GC5215@muc.de>
In-Reply-To: <20050303091908.GC5215@muc.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200503032216.31859.bernd-schubert@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 03 March 2005 10:19, Andi Kleen wrote:
> On Wed, Mar 02, 2005 at 08:53:07AM -0800, Trond Myklebust wrote:
> > on den 02.03.2005 Klokka 12:33 (+0100) skreiv Bernd Schubert:
> > > > I can see no good reason for truncating inode number values on
> > > > platforms that actually do support 64-bit inode numbers, but I can
> > > > see several
> > >
> > > Well, at least we would have a reason ;)
> >
> > A 32-bit emulation mode is clearly a "platform" which does NOT support
> > 64-bit inode numbers, however there is (currently) no way for the kernel
> > to detect that you are running that. Any extra truncation should
> > therefore ideally be done by the emulation layer rather than the kernel
> > itself.
>
> The problem here is that glibc uses stat64() which supports
> 64bit inode numbers. But glibc does the overflow checking itself
> and generates the EOVERFLOW in user space. Nothing we can do
> about that. The 64bit inodes work under 32bit too, so your
> code checking for 64bitness is totally bogus.
>
> The old stat interface doesn't check that case currently either
> (will fix that), but that's not the problem here.
>
> But in general the emulation layer cannot do truncation because
> it doesn't know if it is ok to do for the low level file system.
> If anything this has to be done in the fs.
>

So what do you actually suggest? On the one hand you say even 32bit userspace 
supports 64bit inodes, if it wants. On the other hand you say the truncation 
needs to be done on file system level. 
To my mind this is contradicting, the first statement suggests to do the 
truncation in userspace, the second says it can only be done in the kernel?

Cheers,
 Bernd
