Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261443AbVARWDj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261443AbVARWDj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 17:03:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261446AbVARWDj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 17:03:39 -0500
Received: from gate.crashing.org ([63.228.1.57]:3550 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261443AbVARWDh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 17:03:37 -0500
Subject: Re: [patch 0/3] kallsyms: Add gate page and all symbols support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Keith Owens <kaos@ocs.com.au>
Cc: Sam Ravnborg <sam@ravnborg.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <15379.1106053651@ocs3.ocs.com.au>
References: <15379.1106053651@ocs3.ocs.com.au>
Content-Type: text/plain
Date: Wed, 19 Jan 2005 09:03:04 +1100
Message-Id: <1106085784.4500.95.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> > - I dislike the fact that you now define the prototype of the function
> >in the __HAVE_ARCH_GATE_AREA case. I want my arch .h to be the one doing
> >so, since i want to inline it
> 
> Maybe.  I dislike copying definitions to multiple asm headers.  If you
> think that the win of inlining the ppc64 version of these functions
> outweighs the header duplication then send a patch.  Don't forget to
> duplicate the definition in include/asm-x86_64 as well.

Well, I just want to inline it as en empty function ... 

>(to nothing in the ppc64 case since the
> >vDSO I'm implementing doesn't need any special treatement of the gate
> >area, it's a normal VMA added to the mm's at exec time).
> 
> Added to specific task's mm or to all tasks?  If the gate VMA varies
> according to the task then you have to support the kallsyms "is this a
> possible gate address for any task?" question, like x86-64.

each task mm can have it differently. why would I need kallsym support ?
the ppc64 vDSO support will not be part of the kernel address ranges,
but will be somewhere in the normal userland areas.

Ben.


