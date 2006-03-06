Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750805AbWCFLZd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750805AbWCFLZd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 06:25:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750819AbWCFLZd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 06:25:33 -0500
Received: from ozlabs.org ([203.10.76.45]:27831 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1750805AbWCFLZc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 06:25:32 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17420.7204.375377.273773@cargo.ozlabs.ibm.com>
Date: Mon, 6 Mar 2006 22:25:24 +1100
From: Paul Mackerras <paulus@samba.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Matthew Grant <grantma@anathoth.gen.nz>, dwmw2@infradead.org,
       linux-kernel@vger.kernel.org
Subject: Re: PROBLEM:  rt_sigsuspend() does not return EINTR on 2.6.16-rc2+
In-Reply-To: <20060306024512.4594b58d.akpm@osdl.org>
References: <1141521960.7628.9.camel@localhost.localdomain>
	<1141557862.3764.47.camel@pmac.infradead.org>
	<1141633685.7634.13.camel@localhost.localdomain>
	<20060306024512.4594b58d.akpm@osdl.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton writes:

> Matthew Grant <grantma@anathoth.gen.nz> wrote:
> >
> > OK, a major piece of software is broken for mounting removable media. A
> >  kernel upgrade from 2.6.15 SHOULDn't do that.  
> 
> Yes, this is a serious problem and we need to get to the bottom of it.

I have been looking at the equivalent code on powerpc.  This looks to
me like we aren't calling do_signal on the way back out of the system
call to userspace on x86 when the _TIF_RESTORE_SIGMASK thread_info
flag is set.  I had a look at the code in arch/i386/kernel and I can't
see why we wouldn't be getting to do_signal, but x86 assembly is not
my strong point.

The fact that userspace is seeing the -ERESTARTNOHAND return value
from the rt_sigsuspend strongly suggests that we aren't actually
calling do_signal, though.

Paul.

