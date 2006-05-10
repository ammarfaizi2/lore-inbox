Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964885AbWEJKQh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964885AbWEJKQh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 06:16:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964887AbWEJKQh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 06:16:37 -0400
Received: from mx1.redhat.com ([66.187.233.31]:63120 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964885AbWEJKQf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 06:16:35 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1147245709.32448.74.camel@localhost.localdomain> 
References: <1147245709.32448.74.camel@localhost.localdomain>  <17505.26159.807484.477212@cargo.ozlabs.ibm.com> <20060510051649.GD1794@lixom.net> <17505.34919.750295.170941@cargo.ozlabs.ibm.com> <20060509.233958.73723993.davem@davemloft.net> 
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: "David S. Miller" <davem@davemloft.net>, olof@lixom.net,
       linux-arch@vger.kernel.org, paulus@samba.org,
       linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: Re: [RFC/PATCH] Make powerpc64 use __thread for per-cpu variables 
X-Mailer: MH-E 7.92+cvs; nmh 1.1; GNU Emacs 22.0.50.4
Date: Wed, 10 May 2006 11:14:53 +0100
Message-ID: <14201.1147256093@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> > That first cache line of current_thread_info() should be so hot that
> > it's probably just fine to use current_thread_info()->task since
> > you're just doing a mask on a fixed register (r1) to implement that.
> 
> Iirc, he tried that, though it did bloat the kernel size a bit due the
> the amount of occurences of current-> in there. We are now thinking
> about either dedicating a register to current (that would avoid the
> problem of printk() using it in start_kernel before we get the per-cpu
> areas setup) in addition to __thread (heh, we have lots of registers on
> ppc :) or maybe putting current back in the paca...

I dedicated registers to current and current threadinfo in the FRV arch.  As I
recall doing that improved both performance and code size quite a bit.  It also
means that I get sensible bug panic reports when the stack pointer overruns the
stack space.

David
