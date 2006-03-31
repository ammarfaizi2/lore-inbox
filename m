Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751105AbWCaA4k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751105AbWCaA4k (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 19:56:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751102AbWCaA4j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 19:56:39 -0500
Received: from mga03.intel.com ([143.182.124.21]:36673 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1751099AbWCaA4i convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 19:56:38 -0500
X-IronPort-AV: i="4.03,148,1141632000"; 
   d="scan'208"; a="17147412:sNHT1751827224"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: Synchronizing Bit operations V2
Date: Thu, 30 Mar 2006 16:56:25 -0800
Message-ID: <B8E391BBE9FE384DAA4C5C003888BE6F061AAF44@scsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Synchronizing Bit operations V2
Thread-Index: AcZUXP2iCRCwJ58hSJSnVMMomE3boQAAIjTA
From: "Luck, Tony" <tony.luck@intel.com>
To: "Christoph Lameter" <clameter@sgi.com>,
       "David Mosberger-Tang" <David.Mosberger@acm.org>
Cc: "Nick Piggin" <nickpiggin@yahoo.com.au>,
       "Zoltan Menyhart" <Zoltan.Menyhart@bull.net>,
       "Boehm, Hans" <hans.boehm@hp.com>,
       "Grundler, Grant G" <grant.grundler@hp.com>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>, <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>, <linux-ia64@vger.kernel.org>
X-OriginalArrivalTime: 31 Mar 2006 00:56:26.0298 (UTC) FILETIME=[F01111A0:01C6545D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Also some higher level functions may want to have the mode passed to them 
> as parameters. See f.e. include/linux/buffer_head.h. Without the 
> parameters you will have to maintain farms of definitions for all cases.

But if any part of the call chain from those higher level functions
down to these low level functions is not inline, then the compiler
won't be able to collapse out the "switch (mode)" ... so we'd end up
with a ton of extra object code.

-Tony
