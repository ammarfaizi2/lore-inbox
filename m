Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752301AbWKBABy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752301AbWKBABy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 19:01:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752308AbWKBABy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 19:01:54 -0500
Received: from ozlabs.org ([203.10.76.45]:57504 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1752297AbWKBABx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 19:01:53 -0500
Subject: Re: [PATCH 4/7] paravirtualization: Allow selected bug checks to
	be skipped by paravirt kernels
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andrew Morton <akpm@osdl.org>
Cc: Andi Kleen <ak@muc.de>, Andi Kleen <ak@suse.de>,
       virtualization@lists.osdl.org, Chris Wright <chrisw@sous-sol.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20061101152946.14f95f79.akpm@osdl.org>
References: <20061029024504.760769000@sous-sol.org>
	 <20061029024607.401333000@sous-sol.org> <200610290831.21062.ak@suse.de>
	 <1162178936.9802.34.camel@localhost.localdomain>
	 <20061030231132.GA98768@muc.de>
	 <1162376827.23462.5.camel@localhost.localdomain>
	 <1162376894.23462.7.camel@localhost.localdomain>
	 <1162376981.23462.10.camel@localhost.localdomain>
	 <1162377043.23462.12.camel@localhost.localdomain>
	 <20061101152946.14f95f79.akpm@osdl.org>
Content-Type: text/plain
Date: Thu, 02 Nov 2006 11:01:50 +1100
Message-Id: <1162425710.6848.9.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-11-01 at 15:29 -0800, Andrew Morton wrote:
> On Wed, 01 Nov 2006 21:30:43 +1100
> Rusty Russell <rusty@rustcorp.com.au> wrote:
> 
> > --- a/include/asm-i386/bugs.h
> > +++ b/include/asm-i386/bugs.h
> > @@ -21,6 +21,7 @@
> >  #include <asm/processor.h>
> >  #include <asm/i387.h>
> >  #include <asm/msr.h>
> > +#include <asm/paravirt.h>
> 
> In many other places you have
> 
> #ifdef CONFIG_PARAVIRT
> #include <asm/paravirt.h>
> ...
> 
> But not here.
> 
> Making <asm/paravirt.h> invulnerable would be the more typical approach.

It *is* actually safe.  The "#ifdef CONFIG_PARAVIRT / #include
<asm/paravirt.h> / #else / <... native versions...>" is to give a big
hint to the reader to look in paravirt.h for the real definitions.

Originally I had a noparavirt.h where all these lived, and people hated
it.  So we did it this way, which minimizes churn.

Rusty.



