Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932419AbWCaVPe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932419AbWCaVPe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 16:15:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932418AbWCaVPe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 16:15:34 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:18356 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932268AbWCaVPc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 16:15:32 -0500
Date: Fri, 31 Mar 2006 13:15:17 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
cc: "'Nick Piggin'" <nickpiggin@yahoo.com.au>,
       Zoltan Menyhart <Zoltan.Menyhart@bull.net>,
       "Boehm, Hans" <hans.boehm@hp.com>,
       "Grundler, Grant G" <grant.grundler@hp.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: RE: Synchronizing Bit operations V2
In-Reply-To: <200603311940.k2VJeRg05420@unix-os.sc.intel.com>
Message-ID: <Pine.LNX.4.64.0603311313530.8003@schroedinger.engr.sgi.com>
References: <200603311940.k2VJeRg05420@unix-os.sc.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Mar 2006, Chen, Kenneth W wrote:

> > They are not. They provide equivalent barrier when performed
> > before/after a clear_bit, there is a big difference.
> 
> Just to give another blunt brutal example, what is said here is equivalent
> to say kernel requires:
> 
>    <end of critical section>
>    smp_mb_before_spin_unlock
>    spin_unlock
> 
> Because it is undesirable to have spin_unlock to leak into the critical
> Section and allow critical section to leak after spin_unlock.  This is
> just plain brain dead.

I think we could say that lock semantics are different from barriers. They 
are more like acquire and release on IA64. The problem with smb_mb_*** is 
that the coder *explicitly* requested a barrier operation and we do not 
give it to him.

