Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750831AbWC2Tci@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750831AbWC2Tci (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 14:32:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750830AbWC2Tci
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 14:32:38 -0500
Received: from palrel10.hp.com ([156.153.255.245]:57010 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S1750790AbWC2Tch convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 14:32:37 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: Fix unlock_buffer() to work the same way as bit_unlock()
Date: Wed, 29 Mar 2006 11:31:44 -0800
Message-ID: <65953E8166311641A685BDF71D865826A23D0E@cacexc12.americas.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Fix unlock_buffer() to work the same way as bit_unlock()
Thread-Index: AcZTZImszgwt3pN0QbmQN7kH+Vz3HgAARmYA
From: "Boehm, Hans" <hans.boehm@hp.com>
To: "Grundler, Grant G" <grant.grundler@hp.com>
Cc: "Christoph Lameter" <clameter@sgi.com>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       "Nick Piggin" <nickpiggin@yahoo.com.au>,
       "Zoltan Menyhart" <Zoltan.Menyhart@free.fr>, <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>, <linux-ia64@vger.kernel.org>
X-OriginalArrivalTime: 29 Mar 2006 19:31:45.0471 (UTC) FILETIME=[6A2D04F0:01C65367]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

That was actually based on a different, earlier paper.

Somewhat improved slides for the talk Grant is referring to are at
http://www.hpl.hp.com/personal/Hans_Boehm/misc_slides/pldi05_threads.pdf
.  The problem is also relevant for kernel development, though the title
doesn't fit, and it clearly needs to be addressed at the language spec
and compiler level.  (Note that the claim about gcc on slide 14 is
actually incorrect as it stands (I misread the .s file), but the claim
is correct if you add a conditional to the body of the example loop.
Thus you won't be led far astray.)  The PLDI paper on which the talk is
based contained a conjecture about required ordering for Posix locks,
which is disproved by the TR below.

It's hard to get this stuff right.  But we knew that.

Hans

> -----Original Message-----
> From: Grundler, Grant G 
> Sent: Wednesday, March 29, 2006 11:12 AM
> To: Boehm, Hans
> Cc: Christoph Lameter; Chen, Kenneth W; Nick Piggin; Zoltan 
> Menyhart; akpm@osdl.org; linux-kernel@vger.kernel.org; 
> linux-ia64@vger.kernel.org
> Subject: Re: Fix unlock_buffer() to work the same way as bit_unlock()
> 
> On Wed, Mar 29, 2006 at 10:33:57AM -0800, Boehm, Hans wrote:
> ...
> > - At user level, the ordering semantics required for something like
> > pthread_mutex_lock() are unfortunately unclear.  If you try to 
> > interpret the current standard, you arrive at the conclusion that
> > pthread_mutex_lock() basically needs a full barrier, though
> > pthread_mutex_unlock() doesn't.  (See
> > http://www.hpl.hp.com/techreports/2005/HPL-2005-217.html .)
> 
> Was the talk you presented at the May 2005 Gelato meeting in 
> Cupertino based on an earlier version of this paper?
> 
> That was a very good presentation that exposed the 
> deficiencies in the programming models and languages.  If the 
> slides and/or a recording are available, that might be 
> helpful here too.
> 
> thanks,
> grant
> 
