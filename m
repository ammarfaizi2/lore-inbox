Return-Path: <linux-kernel-owner+w=401wt.eu-S1426040AbWLHRZd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1426040AbWLHRZd (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 12:25:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1426038AbWLHRZc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 12:25:32 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:41383 "EHLO omx2.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1426035AbWLHRZb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 12:25:31 -0500
Date: Fri, 8 Dec 2006 09:23:57 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: Russell King <rmk+lkml@arm.linux.org.uk>
cc: David Howells <dhowells@redhat.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       torvalds@osdl.org, akpm@osdl.org,
       linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH] WorkStruct: Implement generic UP cmpxchg() where an arch
 doesn't support it
In-Reply-To: <20061208171816.GG31068@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.64.0612080919220.16029@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.64.0612061054360.27047@schroedinger.engr.sgi.com>
 <20061206190025.GC9959@flint.arm.linux.org.uk>
 <Pine.LNX.4.64.0612061111130.27263@schroedinger.engr.sgi.com>
 <20061206195820.GA15281@flint.arm.linux.org.uk> <4577DF5C.5070701@yahoo.com.au>
 <20061207150303.GB1255@flint.arm.linux.org.uk> <4578BD7C.4050703@yahoo.com.au>
 <20061208085634.GA25751@flint.arm.linux.org.uk> <4595.1165597017@redhat.com>
 <Pine.LNX.4.64.0612080903370.15959@schroedinger.engr.sgi.com>
 <20061208171816.GG31068@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Dec 2006, Russell King wrote:

> As proven previously the reverse is also true.  And as shown previously
> the cheaper out of the two for all platforms is the LL/SC based
> implementation, where the architecture specific implementation can
> be _either_ LL/SC based or cmpxchg based depending on what is
> supported in their hardware.

As also shown in this thread: There are restrictions on what you can do 
between ll/sc. You would not want to use C code there. ll/sc is an thing 
that needs to be restricted to asm code. So this is not a viable proposal 
at all. ll/sc is useful to construct various atomic functions but cannot 
be directly used in C code. cmpxchg can be effectively realized using 
ll/sc.
