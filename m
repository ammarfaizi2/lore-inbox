Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751348AbWC3R5o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751348AbWC3R5o (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 12:57:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751347AbWC3R5o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 12:57:44 -0500
Received: from palrel11.hp.com ([156.153.255.246]:51382 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S1751316AbWC3R5n convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 12:57:43 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: Fix unlock_buffer() to work the same way as bit_unlock()
Date: Thu, 30 Mar 2006 09:57:40 -0800
Message-ID: <65953E8166311641A685BDF71D865826A23E13@cacexc12.americas.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Fix unlock_buffer() to work the same way as bit_unlock()
Thread-Index: AcZUHeLDn6UW9u8tSwSczrtdT7k49gABJZHQ
From: "Boehm, Hans" <hans.boehm@hp.com>
To: "Christoph Lameter" <clameter@sgi.com>,
       "Zoltan Menyhart" <Zoltan.Menyhart@bull.net>
Cc: "Nick Piggin" <nickpiggin@yahoo.com.au>,
       "Grundler, Grant G" <grant.grundler@hp.com>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>, <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>, <linux-ia64@vger.kernel.org>
X-OriginalArrivalTime: 30 Mar 2006 17:57:41.0135 (UTC) FILETIME=[704D71F0:01C65423]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Christoph Lameter 
> 
> On Thu, 30 Mar 2006, Zoltan Menyhart wrote:
> 
> > Form semantical point of view, the forms:
> > 
> > 	bit_foo(..., mode)
> > and
> > 	bit_foo_mode(...)
> > 
> > are equivalent.
> 
> Correct but the above form leads to less macro definitions.
>  
> > However, I do not think your implementation would be 
> efficient due to 
> > selecting the ordering mode at run time:
> 
> The compiler will select that at compile time. One has the 
> option of also generating run time seletion by specifying a 
> variable instead of a constant when callig these functions.
I would view the latter as a disadvantage, since I can't think of a case
in which you wouldn't want it reported as an error instead, at least if
you care about performance.  If you know of one, I'd be very interested.

The first form does have the advantage that it's possible to build up
more complicated primitives from simpler ones without repeating the
definition four times.

I'm not sure there's a clear winner here.

In the C++ case, I currently expect we will go with template arguments,
which are guaranteed to be static, but are an option you don't have ...

Hans
