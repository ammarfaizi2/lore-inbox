Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030462AbWI2JNV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030462AbWI2JNV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 05:13:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030499AbWI2JNV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 05:13:21 -0400
Received: from colin.muc.de ([193.149.48.1]:35858 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S1030462AbWI2JNV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 05:13:21 -0400
Date: 29 Sep 2006 11:13:19 +0200
Date: Fri, 29 Sep 2006 11:13:19 +0200
From: Andi Kleen <ak@muc.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, linux-kernel@vger.kernel.org,
       Hugh Dickens <hugh@veritas.com>,
       Michael Ellerman <michael@ellerman.id.au>,
       Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH RFC 1/4] Generic BUG handling.
Message-ID: <20060929091319.GB41098@muc.de>
References: <20060928225444.439520197@goop.org> <20060928225452.229936605@goop.org> <20060929085745.GA41098@muc.de> <20060929021019.19058b98.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060929021019.19058b98.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 29, 2006 at 02:10:19AM -0700, Andrew Morton wrote:
> On 29 Sep 2006 10:57:45 +0200
> Andi Kleen <ak@muc.de> wrote:
> 
> > > Some architectures (powerpc) implement WARN using the same mechanism;
> > > if the illegal instruction was the result of a WARN, then report_bug()
> > > returns 1; otherwise it returns 0.
> > 
> > In theory we could do that on x86 too (and skipping the instruction), 
> > the only problem 
> > is that the only guaranteed to fault opcode is ud2 :/. Ok maybe we could
> > reserve some int XXX vector.
> > 
> > % gid WARN_ON | grep -v arch | wc -l
> > 299
> 
> powerpc sets a bit in the __LINE__ number to indicate that it was a
> WARN_ON.  That'll work on all architectures.

We still would need an architecture dependent way to skip the opcode
though (just returning would raise it again). On x86

regs->eip += 2     (rip on x86-64) 

should be enough 

-Andi
