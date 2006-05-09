Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751358AbWEIDjl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751358AbWEIDjl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 23:39:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751359AbWEIDjl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 23:39:41 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:7820 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751358AbWEIDjl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 23:39:41 -0400
Date: Mon, 8 May 2006 20:38:55 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Pekka Enberg <penberg@cs.helsinki.fi>
cc: Linus Torvalds <torvalds@osdl.org>,
       Daniel Hokka Zakrisson <daniel@hozac.com>, linux-kernel@vger.kernel.org,
       =?ISO-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>,
       greg@kroah.com, matthew@wil.cx, manfred@colorfullife.com, akpm@osdl.org
Subject: Re: [PATCH] fs: fcntl_setlease defies lease_init assumptions
In-Reply-To: <1147116991.11282.3.camel@localhost>
Message-ID: <Pine.LNX.4.64.0605082031580.23431@schroedinger.engr.sgi.com>
References: <445E80DD.9090507@hozac.com>  <Pine.LNX.4.64.0605072030280.3718@g5.osdl.org>
  <84144f020605080131r58ce2a93w6c7ba784a266bbeb@mail.gmail.com> 
 <84144f020605080134q7e16f37fl385359c634ece8ca@mail.gmail.com> 
 <Pine.LNX.4.64.0605080807430.3718@g5.osdl.org>  <1147104412.22096.8.camel@localhost>
  <Pine.LNX.4.64.0605080913240.3718@g5.osdl.org> <1147116991.11282.3.camel@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 May 2006, Pekka Enberg wrote:

> > I think it sounds like it's worth it, but I'm not going to really push it.
> 
> Sounds good to me. Andrew?

virt_to_page is not cheap on NUMA.

On IA64 virt_to_page is:

#define virt_to_page(kaddr)     pfn_to_page(__pa(kaddr) >> PAGE_SHIFT)

# define pfn_to_page(pfn)       (vmem_map + (pfn))

vmem_map is not a linear map but a virtual mapping that may require 
several faults to get the information.

