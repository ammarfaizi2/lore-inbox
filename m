Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751090AbWCaBDl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751090AbWCaBDl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 20:03:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751108AbWCaBDl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 20:03:41 -0500
Received: from mga02.intel.com ([134.134.136.20]:37698 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751020AbWCaBDk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 20:03:40 -0500
X-IronPort-AV: i="4.03,148,1141632000"; 
   d="scan'208"; a="17436624:sNHT35973672"
Message-Id: <200603310103.k2V13cg27083@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Christoph Lameter'" <clameter@sgi.com>
Cc: "Nick Piggin" <nickpiggin@yahoo.com.au>,
       "Zoltan Menyhart" <Zoltan.Menyhart@bull.net>,
       "Boehm, Hans" <hans.boehm@hp.com>,
       "Grundler, Grant G" <grant.grundler@hp.com>, <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>, <linux-ia64@vger.kernel.org>
Subject: RE: Synchronizing Bit operations V2
Date: Thu, 30 Mar 2006 17:04:23 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcZUXcoG8OBgzjxFREOJmG9SwqA9WAAAMvEg
In-Reply-To: <Pine.LNX.4.64.0603301653200.2068@schroedinger.engr.sgi.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote on Thursday, March 30, 2006 4:55 PM
> > We are talking about arch specific implementation of clear_bit and smp_mb_*.
> > Yes, for generic code, clear_bit has no implication of memory ordering, but
> > for arch specific code, one should optimize those three functions with the
> > architecture knowledge of exactly what's happening under the hood.
> 
> Arch specific code should make this explicit too and not rely on implied 
> semantics. Otherwise one has to memorize that functions have to work with 
> different semantics in arch code and core code which makes the source 
> code difficult to maintain.

I don't know whether we are talking about the same thing: I propose for ia64:
clear_bit to have release semantic, smp_mb__before_clear_bit will be a noop, smp_mb_after_clear_bit will be a smp_mb().

Caller are still required to use smp_mb__before_clear_bit if it requires, on
ia64, that function will simply be a noop.

- Ken
