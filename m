Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751172AbWCaBNT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751172AbWCaBNT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 20:13:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751099AbWCaBNS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 20:13:18 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:35274 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751172AbWCaBNQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 20:13:16 -0500
Date: Thu, 30 Mar 2006 17:13:07 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       Zoltan Menyhart <Zoltan.Menyhart@bull.net>,
       "Boehm, Hans" <hans.boehm@hp.com>,
       "Grundler, Grant G" <grant.grundler@hp.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: RE: Synchronizing Bit operations V2
In-Reply-To: <200603310103.k2V13cg27083@unix-os.sc.intel.com>
Message-ID: <Pine.LNX.4.64.0603301709440.2553@schroedinger.engr.sgi.com>
References: <200603310103.k2V13cg27083@unix-os.sc.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Mar 2006, Chen, Kenneth W wrote:

> > Arch specific code should make this explicit too and not rely on implied 
> > semantics. Otherwise one has to memorize that functions have to work with 
> > different semantics in arch code and core code which makes the source 
> > code difficult to maintain.
> 
> I don't know whether we are talking about the same thing: I propose for 
> ia64: 
>clear_bit to have release semantic,

Inconsistent with other bit operations.

>smp_mb__before_clear_bit will be a noop,

Then there will no barrier since clear_bit only has acquire semantics. This is a 
bug in bit operations since smb_mb__before_clear_bit does not work as 
documentted.

>smp_mb_after_clear_bit will be a smp_mb().

Ok.

> Caller are still required to use smp_mb__before_clear_bit if it requires, on
> ia64, that function will simply be a noop.

Well ultimately I wish we could move away from these 
smb_mb__before/after_xx macros and use explicit synchronization ordering 
instead.

If there is agreement on this patch then we can use explicit ordering in 
core kernel code and slowly get rid of smb_mb__xxx.

