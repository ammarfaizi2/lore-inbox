Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290835AbSARVaL>; Fri, 18 Jan 2002 16:30:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290836AbSARVaC>; Fri, 18 Jan 2002 16:30:02 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:32267 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S290835AbSARV37>; Fri, 18 Jan 2002 16:29:59 -0500
Date: Fri, 18 Jan 2002 21:29:49 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: "David S. Miller" <davem@redhat.com>
Cc: dan@embeddededge.com, hozer@drgw.net, linux-kernel@vger.kernel.org,
        groudier@free.fr, mattl@mvista.com
Subject: Re: pci_alloc_consistent from interrupt == BAD
Message-ID: <20020118212949.H2059@flint.arm.linux.org.uk>
In-Reply-To: <20020118130209.J14725@altus.drgw.net> <3C4875DB.9080402@embeddededge.com> <20020118.123221.85715153.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020118.123221.85715153.davem@redhat.com>; from davem@redhat.com on Fri, Jan 18, 2002 at 12:32:21PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2002 at 12:32:21PM -0800, David S. Miller wrote:
> The ARM and PPC ports could set __GFP_HIGH in their page table
> allocation calls when invoked via pci_alloc_consistent, and this is
> the change I suggest they make.  It is a trivial fix whereas backing
> out this ability to call pci_alloc_consistent from interrupts is not
> a trivial change at all.

ARM will get fixed some way if and when it becomes a requirement to fix
it.  "requirement" here is defined by someone wanting to use such a
driver on an ARM system.  Currently, there is no call for it, so there's
not much point in implementing it.

However, if it becomes easy to implement without impacting the code too
much, then it will get fixed in due coarse.  The problem currently is
that there is no way for the page table allocation functions to know
that they should be using atomic and emergency pool memory allocations.

Its a balance of pain vs gain.  Pain is currently high, gain is currently
zero.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

