Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261418AbUDHB4l (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 21:56:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261422AbUDHB4l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 21:56:41 -0400
Received: from ozlabs.org ([203.10.76.45]:64485 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261418AbUDHB4j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 21:56:39 -0400
Date: Thu, 8 Apr 2004 11:50:43 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Andi Kleen <ak@suse.de>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, benh@kernel.crashing.org,
       anton@samba.org, paulus@samba.org, linuxppc64-dev@lists.linuxppc.org
Subject: Re: RFC: COW for hugepages
Message-ID: <20040408015043.GA20320@zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Andi Kleen <ak@suse.de>, akpm@osdl.org, linux-kernel@vger.kernel.org,
	benh@kernel.crashing.org, anton@samba.org, paulus@samba.org,
	linuxppc64-dev@lists.linuxppc.org
References: <20040407074239.GG18264@zax> <20040407143447.4d8f08af.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040407143447.4d8f08af.ak@suse.de>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 07, 2004 at 02:34:47PM +0200, Andi Kleen wrote:
> On Wed, 7 Apr 2004 17:42:39 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
> 
> > Currently the kernel does not implement copy-on-write for huge pages -
> > in fact any sort of page fault on a hugepage results in a SIGBUS.
> > This means that hugepages *always* have MAP_SHARED semantics, even if
> > MAP_PRIVATE is requested, and in particular that they are always
> > shared across a fork().  Particularly when using hugetlbfs as just a
> > source of quasi-anonymous memory, those are rather strange semantics.
> 
> [...]
> 
> Implementing this for ppc64 only is just wrong. Before you do this 
> I would suggest to factor out the common code in the various hugetlbpage
> implementations and then implement it in common code.

Yes, I know it needs to be implemented for the other archs, but I
wanted to get some feedback on the concept before diving into the
other arch details to figure out how to implement it there.

-- 
David Gibson			| For every complex problem there is a
david AT gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
