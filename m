Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266892AbUH1GJO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266892AbUH1GJO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 02:09:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266891AbUH1GJO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 02:09:14 -0400
Received: from fw.osdl.org ([65.172.181.6]:64457 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266838AbUH1GJI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 02:09:08 -0400
Date: Fri, 27 Aug 2004 23:06:37 -0700
From: Andrew Morton <akpm@osdl.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: paulus@samba.org, ak@muc.de, davem@davemloft.net, ak@suse.de,
       wli@holomorphy.com, davem@redhat.com, raybry@sgi.com,
       benh@kernel.crashing.org, manfred@colorfullife.com,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       vrajesh@umich.edu, hugh@veritas.com
Subject: Re: page fault scalability patch final : i386 tested, x86_64
 support added
Message-Id: <20040827230637.6b3eb2ac.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0408272256030.17485@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0408151924250.4480@schroedinger.engr.sgi.com>
	<20040816143903.GY11200@holomorphy.com>
	<B6E8046E1E28D34EB815A11AC8CA3129027B679F@mtv-atc-605e--n.corp.sgi.com>
	<B6E8046E1E28D34EB815A11AC8CA3129027B67A9@mtv-atc-605e--n.corp.sgi.com>
	<B6E8046E1E28D34EB815A11AC8CA3129027B67B4@mtv-atc-605e--n.corp.sgi.com>
	<Pine.LNX.4.58.0408271616001.14712@schroedinger.engr.sgi.com>
	<20040827233602.GB1024@wotan.suse.de>
	<Pine.LNX.4.58.0408271717400.15597@schroedinger.engr.sgi.com>
	<20040827172337.638275c3.davem@davemloft.net>
	<20040827173641.5cfb79f6.akpm@osdl.org>
	<20040828010253.GA50329@muc.de>
	<20040827183940.33b38bc2.akpm@osdl.org>
	<16687.59671.869708.795999@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.58.0408272021070.16607@schroedinger.engr.sgi.com>
	<20040827204241.25da512b.akpm@osdl.org>
	<Pine.LNX.4.58.0408272121300.16949@schroedinger.engr.sgi.com>
	<20040827223954.7d021aac.akpm@osdl.org>
	<Pine.LNX.4.58.0408272256030.17485@schroedinger.engr.sgi.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter <clameter@sgi.com> wrote:
>
> > As I said - for both these applications we need a new type which is
>  > atomic64_t on 64-bit and atomic_t on 32-bit.
> 
>  That is simply a new definition in include/asm-*/atomic.h
> 
>  so
> 
>  #define atomic_long atomic64_t
> 
>  on 64 bit
> 
>  and
> 
>  #define atomic_long atomic_t
> 
>  on 32bit?

No, a whole host of wrappers are needed - atomic_long_inc/dec/set/read,
etc.  For page->_count we'll also need the fancier functions such as
atomic_long_add_return().

As I said: let's address this later on.  It's probably not an issue for RSS
until 4-level pagetables come along.
