Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751670AbWHXTYg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751670AbWHXTYg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 15:24:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751660AbWHXTYg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 15:24:36 -0400
Received: from cantor2.suse.de ([195.135.220.15]:5560 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750760AbWHXTYg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 15:24:36 -0400
From: Andi Kleen <ak@suse.de>
To: Christoph Lameter <clameter@sgi.com>
Subject: Re: Unnecessary Relocation Hiding?
Date: Thu, 24 Aug 2006 21:24:14 +0200
User-Agent: KMail/1.9.3
Cc: Dong Feng <middle.fengdong@gmail.com>, linux-kernel@vger.kernel.org
References: <a2ebde260608230500o3407b108hc03debb9da6e62c@mail.gmail.com> <Pine.LNX.4.64.0608241125140.4394@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.64.0608241125140.4394@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608242124.14504.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 24 August 2006 20:26, Christoph Lameter wrote:
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

The reason the original code is like it is because gcc assumes there
is no wrapping on arithmetic on symbol addresses (it is allowed to assume
that because it is undefined in the C standard). And in same cases wrapping
can happen. There was at least one miscompilation in the past that lead to the 
current construct.

-Andi
