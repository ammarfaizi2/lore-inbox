Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030405AbWHXXcD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030405AbWHXXcD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 19:32:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030409AbWHXXcD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 19:32:03 -0400
Received: from ozlabs.tip.net.au ([203.10.76.45]:20947 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1030405AbWHXXcB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 19:32:01 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17646.14056.102017.127644@cargo.ozlabs.ibm.com>
Date: Fri, 25 Aug 2006 09:31:52 +1000
From: Paul Mackerras <paulus@samba.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: Dong Feng <middle.fengdong@gmail.com>, linux-kernel@vger.kernel.org,
       ak@suse.de
Subject: Re: Unnecessary Relocation Hiding?
In-Reply-To: <Pine.LNX.4.64.0608241125140.4394@schroedinger.engr.sgi.com>
References: <a2ebde260608230500o3407b108hc03debb9da6e62c@mail.gmail.com>
	<Pine.LNX.4.64.0608241125140.4394@schroedinger.engr.sgi.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter writes:

> On Wed, 23 Aug 2006, Dong Feng wrote:
> 
> > I have a question. Why shall we need a RELOC_HIDE() macro in the
> > definition of per_cpu()? Maybe the question is actually why we need
> > macro RELOC_HIDE() at all. I changed the following line in
> > include/asm-generic/percpu.h, from
> 
> Guess it was copied from IA64 but the semantics were not preserved.
> I think it should either be changed the way you suggest or the 
> implementation needs to be fixed to actually do a linker relocation.

No, RELOC_HIDE came from ppc originally.  The reason for it is that
gcc assumes that if you add something on to the address of a symbol,
the resulting address is still inside the bounds of the symbol, and do
optimizations based on that.  The RELOC_HIDE macro is designed to
prevent gcc knowing that the resulting pointer is obtained by adding
an offset to the address of a symbol.  As far as gcc knows, the
resulting pointer could point to anything.

It has nothing to do with linker relocations.

Paul.
