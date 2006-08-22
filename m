Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932069AbWHVHa1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932069AbWHVHa1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 03:30:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932071AbWHVHa1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 03:30:27 -0400
Received: from gate.crashing.org ([63.228.1.57]:8105 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S932069AbWHVHa0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 03:30:26 -0400
Subject: Re: [PATCH] introduce kernel_execve function to replace
	__KERNEL_SYSCALLS__
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Paul Mackerras <paulus@samba.org>,
       =?ISO-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>, Andrew Morton <akpm@osdl.org>,
       rusty@rustcorp.com.au, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
In-Reply-To: <200608211712.17780.arnd@arndb.de>
References: <20060819073031.GA25711@atjola.homenet>
	 <200608201913.39989.arnd@arndb.de>
	 <17641.30.670343.779791@cargo.ozlabs.ibm.com>
	 <200608211712.17780.arnd@arndb.de>
Content-Type: text/plain
Date: Tue, 22 Aug 2006 17:29:02 +1000
Message-Id: <1156231742.21752.101.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-08-21 at 17:12 +0200, Arnd Bergmann wrote:
> On Monday 21 August 2006 02:36, Paul Mackerras wrote:
> > > Iit turned out most of the architectures that already implement
> > > their own execve() call instead of using the _syscall3 function
> > > for it end up passing the return value of sys_execve down, 
> > > instead of setting errno.
> > 
> > I really don't like having an "errno" variable in the kernel.  What if
> > two processes are doing an execve concurrently?
> 
> The point is that we have two different schemes in the kernel that
> conflict:
> 
> alpha, arm{,26}, ia64, parisc, powerpc and x86_64 pass the error
> code from execve, all others pass -1 and set the global errno.

All other need to be fixed then... having an errno is just plain wrong.


