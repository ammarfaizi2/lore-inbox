Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751201AbWCaChs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751201AbWCaChs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 21:37:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751200AbWCaChs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 21:37:48 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:30160 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751194AbWCaChr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 21:37:47 -0500
Date: Thu, 30 Mar 2006 18:37:32 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       Zoltan Menyhart <Zoltan.Menyhart@bull.net>,
       "Boehm, Hans" <hans.boehm@hp.com>,
       "Grundler, Grant G" <grant.grundler@hp.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: RE: Synchronizing Bit operations V2
In-Reply-To: <200603310234.k2V2Ysg28086@unix-os.sc.intel.com>
Message-ID: <Pine.LNX.4.64.0603301835140.2884@schroedinger.engr.sgi.com>
References: <200603310234.k2V2Ysg28086@unix-os.sc.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Mar 2006, Chen, Kenneth W wrote:

> > > Option (1):
> > > 
> > > #define clear_bit                     clear_bit_mode(..., RELEASE)
> > > #define Smp_mb__before_clear_bit      do { } while (0)
> > > #define Smp_mb__after_clear_bit       smp_mb()
> > > 
> > > Or option (2):
> > > 
> > > #define clear_bit                     clear_bit_mode(..., ACQUIRE)
> > > #define Smp_mb__before_clear_bit      smp_mb()
> > > #define Smp_mb__after_clear_bit       do { } while (0)
> > > 
> > > I'm fine with either one.
> > 
> > Neither one is correct because there will always be one combination of 
> > clear_bit with these macros that does not generate the required memory 
> > barrier.
> 
> Can you give an example?  Which combination?

For Option(1)

smp_mb__before_clear_bit()
clear_bit(...)(

For Option(2)

clear_bit()
smb_mp_after_clear_bit();

Both have either acquire or release semantics but do not have the effect 
of a barrier as required by the macros.

Note that both before and after are used in the core kernel code. Both 
must work correctly.

