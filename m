Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263064AbUB0RqJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 12:46:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263068AbUB0RqJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 12:46:09 -0500
Received: from fmr06.intel.com ([134.134.136.7]:24028 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S263064AbUB0RpC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 12:45:02 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MIMEOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: Why no interrupt priorities?
Date: Fri, 27 Feb 2004 09:44:44 -0800
Message-ID: <F760B14C9561B941B89469F59BA3A8470255F02D@orsmsx401.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Why no interrupt priorities?
Thread-Index: AcP9GrRf3jY94efATaGcszL17lzFiQAOsadw
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "Helge Hafting" <helgehaf@aitel.hist.no>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 27 Feb 2004 17:44:45.0560 (UTC) FILETIME=[63409780:01C3FD59]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Helge Hafting [mailto:helgehaf@aitel.hist.no] 
> Grover, Andrew wrote:
> > Is the assumption that hardirq handlers are superfast also 
> the reason
> > why Linux calls all handlers on a shared interrupt, even if 
> the first
> > handler reports it was for its device?
> > 
> No, it is the other way around.  hardirq handlers have to be superfast
> because linux usually _have to_ call all the handlers of a shared irq.
> 
> The fact that one device did indeed have an interrupt for us 
> doesn't mean
> that the others didn't.  So all of them have to be checked to be safe.

If a device later in the handler chain is also interrupting, then the
interrupt will immediately trigger again. The irq line will remain
asserted until nobody is asserting it.

If the LAST guy in the chain is the one with the interrupt, then you
basically get today's ISR "call each handler" behavior, but it should be
possible to in some cases to get less time spent in do_IRQ.

It is a trivial change to implement this behavior, but benchmarking
would have to be done to verify it really would be a worthwhile
optimization.

Regards -- Andy
