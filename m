Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263015AbUFNP3V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263015AbUFNP3V (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 11:29:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263154AbUFNP3V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 11:29:21 -0400
Received: from fmr05.intel.com ([134.134.136.6]:47016 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S263015AbUFNP3T
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 11:29:19 -0400
From: Mark Gross <mgross@linux.jf.intel.com>
Organization: Intel
To: ganzinger@mvista.com, George Anzinger <george@mvista.com>,
       Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [ANNOUNCE] high-res-timers patches for 2.6.6
Date: Mon, 14 Jun 2004 08:28:08 -0700
User-Agent: KMail/1.5.4
Cc: ganzinger@mvista.com, Geoff Levand <geoffrey.levand@am.sony.com>,
       high-res-timers-discourse@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
References: <40C7BE29.9010600@am.sony.com> <20040611062256.GB13100@devserv.devel.redhat.com> <40CA3342.9020105@mvista.com>
In-Reply-To: <40CA3342.9020105@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200406140828.08924.mgross@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 11 June 2004 15:33, George Anzinger wrote:
> I have been thinking of a major rewrite which would leave this code alone,
> but would introduce an additional list and, of course, overhead for
> high-res timers. This will take some time and be sub optimal, so I wonder
> if it is needed.

What would your goal for the major rewrite be?
Redesign the implementation?
Clean up / re-factor the current design?
Add features?

I've been wondering lately if a significant restructuring of the 
implementation could be done.  Something bottom's up that enabled changing / 
using different time bases without rebooting and coexisted nicely with HPET.

Something along the lines of;
* abstracting the time base's, calibration and computation of the next 
interrupt time into a polymorphic interface along with the implementation of 
a few of your time bases (ACPI, TSC) as a stand allown patch.
* implement yet another polymorphic interface for the interrupt source used by 
the patch, along with a few interrupt sources (PIT, APIC, HPET <-- new )
* Implement a simple RTC-like charactor driver using the above for testing and 
integration.  
* Finally a patch to integrate the first 3 with the POSIX timers code.

What do you think?


--mgross

