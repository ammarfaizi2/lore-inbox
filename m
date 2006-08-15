Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030199AbWHOKsf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030199AbWHOKsf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 06:48:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030203AbWHOKsf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 06:48:35 -0400
Received: from ns2.suse.de ([195.135.220.15]:64199 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030199AbWHOKse (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 06:48:34 -0400
Date: Tue, 15 Aug 2006 12:47:09 +0200
From: Andi Kleen <ak@muc.de>
To: "Jan Beulich" <jbeulich@novell.com>
Cc: "Andi Kleen" <ak@suse.de>, "Chuck Ebbert" <76306.1226@compuserve.com>,
       "Jesper Juhl" <jesper.juhl@gmail.com>, "Andrew Morton" <akpm@osdl.org>,
       "Dave Jones" <davej@redhat.com>,
       "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: Re: [patch] i386: fix one case of stuck dwarf2 unwinder II
Message-Id: <20060815124709.e62d9c57.ak@muc.de>
In-Reply-To: <44E1BF37.76E4.0078.0@novell.com>
References: <200608061212_MC3-1-C747-C2AD@compuserve.com>
	<44D70F42.76E4.0078.0@novell.com>
	<200608071004.37849.ak@suse.de>
	<44E1BF37.76E4.0078.0@novell.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Aug 2006 12:33:59 +0200
"Jan Beulich" <jbeulich@novell.com> wrote:

> >> So it would seem to me. Nevertheless, in my opinion the proper fix is
> to annotate the call site
> >> (in head.S) to specify a zero EIP as return address (which denotes
> the bottom of a frame).
> >
> >Can you please send a patch to do that?
> >
> >That seems to be missing in some other places too, e.g. i386 sysenter
> path, x86-64 kernel_thread,
> >more?
> 
> Attaching both an i386 version (boot/idle thread only, you did
> kernel_thread already)
> and an x86-64 one (boot/idle and kernel_thread). The i386 sysenter path
> is a different
> thing,

Ok added thanks.

Re One open question: Should this added push perhaps be made conditional
upon CONFIG_STACK_UNWIND or CONFIG_UNWIND_INFO?

I don't think that's needed because they are all slow paths.

 there we have an actual caller (though outside of the kernel),
> which I'd like to
> continue to reflect/catch through arch_unw_user_mode().

Ok, but does it work now? I thought it didn't.
I've also seen a stuck on the x86-64 sysenter path on x86-64.

-Andi 
