Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261258AbUDGXfa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 19:35:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261234AbUDGXfa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 19:35:30 -0400
Received: from ns.suse.de ([195.135.220.2]:7581 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261258AbUDGXfY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 19:35:24 -0400
Date: Thu, 8 Apr 2004 01:35:22 +0200
From: Andi Kleen <ak@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: mbligh@aracnet.com, colpatch@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: NUMA API for Linux
Message-Id: <20040408013522.294f0322.ak@suse.de>
In-Reply-To: <20040407155225.14936e8a.akpm@osdl.org>
References: <1081373058.9061.16.camel@arrakis>
	<20040407145130.4b1bdf3e.akpm@osdl.org>
	<5840000.1081377504@flay>
	<20040408003809.01fc979e.ak@suse.de>
	<20040407155225.14936e8a.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Apr 2004 15:52:25 -0700
Andrew Morton <akpm@osdl.org> wrote:

> Andi Kleen <ak@suse.de> wrote:
> >
> > We can discuss changes when someone shows numbers that additional 
> > optimizations are needed. I haven't seen such numbers and I'm not convinced
> > sharing is even a good idea from a design standpoint.  For the first version 
> > I just aimed to get something working with straight forward code.
> > 
> > To put it all in perspective: a policy is 12 bytes on a 32bit machine
> > (assuming MAX_NUMNODES <= 32) and 16 bytes on a 64bit machine
> > (with MAX_NUMNODES <= 64)
> 
> sizeof(vm_area_struct) is a very sensitive thing on ia32.  If you expect
> that anyone is likely to actually use the numa API on 32-bit, sharing
> will be important.

I don't really believe that. If it was that way someone would have already
done all the obvious space optimizations left on the table...
(like using rb_next or merging the rb color into flags)

NUMA API adds a new pointer, but all sharing in the world couldn't fix that.

When you set a policy != default you will also pay the 12 or 16 bytes overhead
for the object for each "policy region"

> It should be useful for SMT, yes?

Nope. Only for real NUMA.

-Andi
