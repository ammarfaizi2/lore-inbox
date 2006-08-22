Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751034AbWHVIAu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751034AbWHVIAu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 04:00:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751173AbWHVIAu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 04:00:50 -0400
Received: from mail.gmx.net ([213.165.64.20]:5862 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750713AbWHVIAt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 04:00:49 -0400
X-Authenticated: #5039886
Date: Tue, 22 Aug 2006 10:00:46 +0200
From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Paul Mackerras <paulus@samba.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>, Andrew Morton <akpm@osdl.org>,
       rusty@rustcorp.com.au, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH] introduce kernel_execve function to replace __KERNEL_SYSCALLS__
Message-ID: <20060822080046.GA22572@atjola.homenet>
Mail-Followup-To: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Arnd Bergmann <arnd@arndb.de>, Paul Mackerras <paulus@samba.org>,
	Russell King <rmk+lkml@arm.linux.org.uk>,
	Andrew Morton <akpm@osdl.org>, rusty@rustcorp.com.au,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
References: <20060819073031.GA25711@atjola.homenet> <200608201913.39989.arnd@arndb.de> <17641.30.670343.779791@cargo.ozlabs.ibm.com> <200608211712.17780.arnd@arndb.de> <1156231742.21752.101.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1156231742.21752.101.camel@localhost.localdomain>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2006.08.22 17:29:02 +1000, Benjamin Herrenschmidt wrote:
> On Mon, 2006-08-21 at 17:12 +0200, Arnd Bergmann wrote:
> > On Monday 21 August 2006 02:36, Paul Mackerras wrote:
> > > > Iit turned out most of the architectures that already implement
> > > > their own execve() call instead of using the _syscall3 function
> > > > for it end up passing the return value of sys_execve down, 
> > > > instead of setting errno.
> > > 
> > > I really don't like having an "errno" variable in the kernel.  What if
> > > two processes are doing an execve concurrently?
> > 
> > The point is that we have two different schemes in the kernel that
> > conflict:
> > 
> > alpha, arm{,26}, ia64, parisc, powerpc and x86_64 pass the error
> > code from execve, all others pass -1 and set the global errno.
> 
> All other need to be fixed then... having an errno is just plain wrong.

I'm working on a patch loosely based on Arnd's that changes the
in-kernel syscall macros to directly return the error codes. Once
kernel_execve is implemented for each arch, only um should remain as a
user and I found only two calls there that care about the exact
non-zero return value, both are simple to adapt.
That should allow to get rid of errno completely. If someone knows a
reason why this is destined to fail (maybe syscalls returning char?!),
please let me know before I waste too much time on it ;)

Björn
