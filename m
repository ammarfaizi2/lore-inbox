Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269107AbTGJJWx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 05:22:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269117AbTGJJWx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 05:22:53 -0400
Received: from ns.suse.de ([213.95.15.193]:30738 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S269107AbTGJJWw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 05:22:52 -0400
Date: Thu, 10 Jul 2003 11:37:31 +0200
From: Andi Kleen <ak@suse.de>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: davidm@hpl.hp.com, linux-kernel@vger.kernel.org, torvalds@transmeta.com,
       ak@suse.de
Subject: Re: per_cpu fixes
Message-ID: <20030710093731.GC17798@wotan.suse.de>
References: <200307092120.h69LKTBH002759@napali.hpl.hp.com> <20030710015208.1E7A22C44B@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030710015208.1E7A22C44B@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> When I implemented this, I imagined archs putting their per-cpu offset
> inside a register, so they could get to their vars in one instruction,
> but not the IA64 remapping thing.  We are now suffering because of my
> limited imagination (which David has commented on before 8).

x86-64 has similar problems. While the virtual addresses are different
the direct access using the segment register doesn't yield an address
(there is no LEA instruction to read from segment registers). It can be
worked around, but you have to follow an indirect pointer.
For most efficient access you can't take the address.

[currently the code doesn't use the Segment access for per_cpu data,
but I plan to readd this eventually]

-Andi
