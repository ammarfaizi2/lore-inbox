Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283607AbRLDXH4>; Tue, 4 Dec 2001 18:07:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283606AbRLDXHj>; Tue, 4 Dec 2001 18:07:39 -0500
Received: from khan.acc.umu.se ([130.239.18.139]:7872 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id <S283581AbRLDXGY>;
	Tue, 4 Dec 2001 18:06:24 -0500
Date: Wed, 5 Dec 2001 00:05:53 +0100
From: David Weinehall <tao@acc.umu.se>
To: Keith Owens <kaos@ocs.com.au>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, kbuild-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [kbuild-devel] Converting the 2.5 kernel to kbuild 2.5
Message-ID: <20011205000553.L360@khan.acc.umu.se>
In-Reply-To: <E16BKBw-0002xO-00@the-village.bc.nu> <30228.1007506832@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <30228.1007506832@ocs3.intra.ocs.com.au>; from kaos@ocs.com.au on Wed, Dec 05, 2001 at 10:00:32AM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2001 at 10:00:32AM +1100, Keith Owens wrote:
> On Tue, 4 Dec 2001 18:21:15 +0000 (GMT), 
> Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> >> make bzlilo modules modules_install: it would be a simble
> >> make install: (and you configure with CML1/CML2 what install
> >> means).
> >
> >How does it handle that when install means different things on each box of
> >a set of them NFS sharing the kernel tree. This is a real world example
> 
> I made kbuild 2.5 install very flexible to cater for cases like this.
> The answer depends on whether you want every compile to be the same
> with different install steps on the target machines or each compile is
> different.
> 
> In the different compile case you have a single source tree (mounted
> read only if you like) and separate object trees for each compile run.
> The .config lives in the object directory so is machine local.  The
> object trees can be NFS mounted or can use local disk on each build
> machine, as a bonus this avoids NFS writes and runs much faster.
> 
> If you want a common compile on one machine followed by different
> installs on each machine then you have three choices.
> 
> (1) make install with an install prefix path (say /var/tmp) will
>     install the kernel, modules, System.map and .config in a holding
>     directory on the build machine, the other machines can then copy
>     the install data to wherever they need it.  Whether the copy is
>     done from the build machine to the target directories or on the
>     target machine is an NFS implementation detail.
> 
> (2) make installable (the default target) on the build machine then run
>     make install with overrides on the target machines.  All the
>     install config variables are exposed for override on the install
>     step.
> 
> (3) make installable on the build machine with .config specifying an
>     install script name.  Then make install on each target system, the
>     version of the install script is local to the target machine.
> 
> If none of those suit your environment, let me know what you are trying
> to achieve and I will see about adding support to kbuild 2.5.

Would it be easy to add hooks for make-rpm and make-kpkg and alike,
as methods for make installable?


/David
  _                                                                 _
 // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </
