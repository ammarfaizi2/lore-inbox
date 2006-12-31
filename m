Return-Path: <linux-kernel-owner+w=401wt.eu-S933105AbWLaJwU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933105AbWLaJwU (ORCPT <rfc822;w@1wt.eu>);
	Sun, 31 Dec 2006 04:52:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933106AbWLaJwU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Dec 2006 04:52:20 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:57541
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S933105AbWLaJwT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Dec 2006 04:52:19 -0500
Date: Sun, 31 Dec 2006 01:52:10 -0800 (PST)
Message-Id: <20061231.015210.112627311.davem@davemloft.net>
To: wmb@firmworks.com
Cc: devel@laptop.org, linux-kernel@vger.kernel.org, jg@laptop.org,
       dmk@flex.com
Subject: Re: [PATCH] Open Firmware device tree virtual filesystem
From: David Miller <davem@davemloft.net>
In-Reply-To: <459784AD.1010308@firmworks.com>
References: <459714A6.4000406@firmworks.com>
	<20061230.211941.74748799.davem@davemloft.net>
	<459784AD.1010308@firmworks.com>
X-Mailer: Mew version 5.1.52 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mitch Bradley <wmb@firmworks.com>
Date: Sat, 30 Dec 2006 23:36:45 -1000

> The base interface function is callofw(), which is effectively identical 
> to call_prom_ret() in  arch/powerpc/kernel/prom_init.c .  So it seems 
> that PowerPC could use it.  I suppose I could change the name of 
> callofw() to call_prom_ret(), thus making the base interface identical 
> to PowerPC's.  All it does is argument marshalling, translating between 
> C varargs argument lists and the OFW argarray format.

Please create explicit function calls for each operation, this
way the caller is immune to open-firmware implementation details.

> SPARC should be able to use that same base interface function directly.  
> It is written to the standard OFW client interface.

Sparc 32-bit predates the OFW specification and does things differently.

Please use a functional interface using a C function for each device
tree operation, then the implementation behind it doesn't matter.

> It wouldn't work on ancient Sun machines with the sunmon romvec 
> interface, but Sun stopped making such machines something like 16 years ago.

Yet we still support them in the 32-bit sparc port.  And it's so
easy to support this properly, please use the clean stuff we've
created for this.

> I did consider first creating a memory data structure identical to the 
> powerpc/sparc one, but that looked like it was going to be essentially 
> twice as much code for no extra capability.  The code to traverse the 
> device tree and create the memory data structure is roughly the same as 
> the code to create the filesystem structure.  I just didn't see the 
> value of an intermediate representation for systems that don't otherwise 
> need it.

Since we put it in memory, we have zero reason to call into the
firmware for device tree access and this simplifies things a lot.

But all of that really doesn't matter, if you use a functional
C interface for each device tree access operation, it doesn't
matter what's behind it right?
