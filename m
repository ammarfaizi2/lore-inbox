Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264818AbUDWODi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264818AbUDWODi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 10:03:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264814AbUDWODi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 10:03:38 -0400
Received: from mx1.redhat.com ([66.187.233.31]:50088 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264818AbUDWOD2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 10:03:28 -0400
To: Linus Torvalds <torvalds@osdl.org>
Cc: Ingo Oeser <ioe-lkml@rameria.de>, linux-kernel@vger.kernel.org,
       arjanv@redhat.com, Dave Jones <davej@redhat.com>,
       Jeff Garzik <jgarzik@pobox.com>, viro@parcelfarce.linux.theplanet.co.uk,
       bfennema@falcon.csc.calpoly.edu
Subject: Re: Fix UDF-FS potentially dereferencing null
References: <20040416214104.GT20937@redhat.com>
	<Pine.LNX.4.58.0404161720450.3947@ppc970.osdl.org>
	<1082195458.4691.1.camel@laptop.fenrus.com>
	<200404171313.02784.ioe-lkml@rameria.de>
	<Pine.LNX.4.58.0404171009320.3947@ppc970.osdl.org>
	<or3c6vhi2x.fsf@free.redhat.lsd.ic.unicamp.br>
	<Pine.LNX.4.58.0404221339300.19703@ppc970.osdl.org>
From: Alexandre Oliva <aoliva@redhat.com>
Organization: Red Hat Global Engineering Services Compiler Team
Date: 23 Apr 2004 11:00:49 -0300
In-Reply-To: <Pine.LNX.4.58.0404221339300.19703@ppc970.osdl.org>
Message-ID: <orwu46iyjy.fsf@livre.redhat.lsd.ic.unicamp.br>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 22, 2004, Linus Torvalds <torvalds@osdl.org> wrote:

> In your example, both pointers were called "p", but they were obviously
> two different symbols from a compiler perspective. So there's a clear
> "assignment" from one "p" to the other "p" as part of the inline function
> call, so it's not like the back-end doesn't see that part - it's assigning
> from a non-safe pointer to a safe one _after_ doing the test on the
> non-safe one.

It does see the assignment, yes, but if the pointer happens to be a
constant, and constant propagation turns the assignment `p_i = p;'
into `p_i = constant;', you'd have to preserve the information that
this constant pointer can only be safely dereferenced after the test.
This is an admittedly convoluted example, since if p is constant and
the condition doesn't hold, the conditional dereferencing will
probably have already been optimized away by the time it could do any
damage, but it might not be depending on how the compiler orders its
optimization passes, and then you lose.

-- 
Alexandre Oliva             http://www.ic.unicamp.br/~oliva/
Red Hat Compiler Engineer   aoliva@{redhat.com, gcc.gnu.org}
Free Software Evangelist  oliva@{lsd.ic.unicamp.br, gnu.org}
