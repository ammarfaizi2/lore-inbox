Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266500AbUFUWvN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266500AbUFUWvN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 18:51:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266505AbUFUWvN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 18:51:13 -0400
Received: from mail8.fw-bc.sony.com ([160.33.98.75]:31185 "EHLO
	mail8.fw-bc.sony.com") by vger.kernel.org with ESMTP
	id S266500AbUFUWuz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 18:50:55 -0400
Message-ID: <40D7662A.2030006@am.sony.com>
Date: Mon, 21 Jun 2004 15:50:18 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031030
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mark Gross <mgross@linux.jf.intel.com>
CC: ganzinger@mvista.com, George Anzinger <george@mvista.com>,
       Arjan van de Ven <arjanv@redhat.com>,
       high-res-timers-discourse@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] high-res-timers patches for 2.6.6
References: <40C7BE29.9010600@am.sony.com> <20040611062256.GB13100@devserv.devel.redhat.com> <40CA3342.9020105@mvista.com> <200406140828.08924.mgross@linux.intel.com>
In-Reply-To: <200406140828.08924.mgross@linux.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Gross wrote:
> On Friday 11 June 2004 15:33, George Anzinger wrote:
> 
>>I have been thinking of a major rewrite which would leave this code alone,
>>but would introduce an additional list and, of course, overhead for
>>high-res timers. This will take some time and be sub optimal, so I wonder
>>if it is needed.
> 
> 
> What would your goal for the major rewrite be?
> Redesign the implementation?
> Clean up / re-factor the current design?
> Add features?
> 
> I've been wondering lately if a significant restructuring of the 
> implementation could be done.  Something bottom's up that enabled changing / 
> using different time bases without rebooting and coexisted nicely with HPET.
> 
> Something along the lines of;
> * abstracting the time base's, calibration and computation of the next 
> interrupt time into a polymorphic interface along with the implementation of 
> a few of your time bases (ACPI, TSC) as a stand allown patch.
> * implement yet another polymorphic interface for the interrupt source used by 
> the patch, along with a few interrupt sources (PIT, APIC, HPET <-- new )
> * Implement a simple RTC-like charactor driver using the above for testing and 
> integration.  
> * Finally a patch to integrate the first 3 with the POSIX timers code.
> 
> What do you think?
> 
> 
> --mgross
> 

Mark,

Generally I agree with your ideas on what needs fixing up, but I'm 
concerned that the run-time binding of this kind of design would have 
too much overhead for time-critical code paths.  Do you think it is 
useful to have run-time selection of the time base and interrupt source? 
   In my work we have a known fixed hardware configuration that has 
limited timers, so I don't really see a need for runtime configuration 
there.

-Geoff

