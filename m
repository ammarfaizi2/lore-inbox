Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262374AbUKRCzN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262374AbUKRCzN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 21:55:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262376AbUKRCzN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 21:55:13 -0500
Received: from pool-151-203-245-3.bos.east.verizon.net ([151.203.245.3]:20996
	"EHLO ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S262374AbUKRCzJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 21:55:09 -0500
Message-Id: <200411180508.iAI58iQ3007886@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: Ian Pratt <Ian.Pratt@cl.cam.ac.uk>
cc: Dave Hansen <haveblue@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Keir.Fraser@cl.cam.ac.uk,
       Christian.Limpach@cl.cam.ac.uk
Subject: Re: [patch 2] Xen core patch : arch_free_page return value 
In-Reply-To: Your message of "Thu, 18 Nov 2004 01:19:15 GMT."
             <E1CUaxA-0006Fa-00@mta1.cl.cam.ac.uk> 
References: <E1CUaxA-0006Fa-00@mta1.cl.cam.ac.uk> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 18 Nov 2004 00:08:44 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ian.Pratt@cl.cam.ac.uk said:
> Pages that have been allocated by our custom allocators get passed
> into standard linux subsystems where we get no control over how
> they're freed. We want the normal page ref counting etc to happen as
> per normal, we just want to intercept the final free so that we can
> return it to our allocator rather than the standard one.

I have to agree with Dave - this is just a wierd solution.  I added 
arch_free_page to do arch-specific, invisible-to-the-generic-kernel things.
My intent may not be the be-all and end-all for this, but I think the semantics
you want to add to it are not that reasonable.

My gut reaction (without knowing your problem in any detail) would be that 
you need too add some more structure to whatever mechanism you have
so that the pages land in your allocator automatically, like a slab or a new
zone or something.


				Jeff

