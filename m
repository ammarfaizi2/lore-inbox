Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262047AbVCAVsg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262047AbVCAVsg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 16:48:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262073AbVCAVsg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 16:48:36 -0500
Received: from colin2.muc.de ([193.149.48.15]:265 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S262047AbVCAVsd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 16:48:33 -0500
Date: 1 Mar 2005 22:48:32 +0100
Date: Tue, 1 Mar 2005 22:48:32 +0100
From: Andi Kleen <ak@muc.de>
To: Bernd Schubert <bernd-schubert@web.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       nfs@lists.sourceforge.net
Subject: Re: x86_64: 32bit emulation problems
Message-ID: <20050301214832.GA44624@muc.de>
References: <200502282154.08009.bernd.schubert@pci.uni-heidelberg.de> <20050301202417.GA40466@muc.de> <200503012207.02915.bernd-schubert@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503012207.02915.bernd-schubert@web.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 01, 2005 at 10:07:01PM +0100, Bernd Schubert wrote:
> Hello Andi,
> 
> sorry, due to some mail sending/refusing problems, I had to resend to the 
> nfs-list, which prevented the answers there to be posted to the other CCs.
> 
> > It is most likely some kind of user space problem.  I would change
> > it to int err = stat(dir, &buf);
> > and then go through it with gdb and see what value err gets assigned.
> >
> > I cannot see any kernel problem.
> 
> The err value will become -1 here.

strace didn't say so, and normally it doesn't lie about things like this.

> > bernd@hitchcock tests>./test_stat32 /mnt/test/yp
> > stat for /mnt/test/yp failed
> > ernno: 75 (Value too large for defined data type)

errno is undefined unless a system call returned -1 before or
you set it to 0 before.

> > But why does stat64() on a 64-bit kernel tries to fill in larger data than

A 64bit kernel has no stat64(). All stats are 64bit.

> > on a 32-bit kernel and larger data also only for nfs-mount points? Hmm, I
> > will tomorrow compare the tcp-packges sent by the server.
> 
> So I still think thats a kernel bug.

Your data so far doesn't support this assertion.

-Andi
