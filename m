Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269243AbUIBWv4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269243AbUIBWv4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 18:51:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269234AbUIBWsF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 18:48:05 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:32149 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S269185AbUIBWq4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 18:46:56 -0400
Date: Thu, 2 Sep 2004 15:42:15 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: john stultz <johnstul@us.ibm.com>
cc: lkml <linux-kernel@vger.kernel.org>, tim@physik3.uni-rostock.de,
       george anzinger <george@mvista.com>, albert@users.sourceforge.net,
       Ulrich.Windl@rz.uni-regensburg.de, Len Brown <len.brown@intel.com>,
       linux@dominikbrodowski.de, David Mosberger <davidm@hpl.hp.com>,
       Andi Kleen <ak@suse.de>, paulus@samba.org, schwidefsky@de.ibm.com,
       jimix@us.ibm.com, keith maanthey <kmannth@us.ibm.com>,
       greg kh <greg@kroah.com>, Patricia Gaughen <gone@us.ibm.com>,
       Chris McDermott <lcm@us.ibm.com>
Subject: Re: [RFC][PATCH] new timeofday core subsystem (v.A0)
In-Reply-To: <1094164096.14662.345.camel@cog.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.58.0409021536450.28532@schroedinger.engr.sgi.com>
References: <1094159238.14662.318.camel@cog.beaverton.ibm.com> 
 <1094159379.14662.322.camel@cog.beaverton.ibm.com> 
 <Pine.LNX.4.58.0409021512360.28532@schroedinger.engr.sgi.com>
 <1094164096.14662.345.camel@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Sep 2004, john stultz wrote:

> What about my idea from yesterday of inverting the fastcall
> relationship? Instead of creating a structure that exports values and
> pointers the fastcall can use to create a time of day, why not use the
> fast call to read the raw time and return it back to the time of day
> code (which may be running in user context)? This avoids the duplication
> of having to re-implement the timeofday/clock_gettime functions in
> fastcall asm code.

"Read raw time"? How can you read the raw time in a fast call if the
fast call needs to do additional function calls (as defined in the
proposed time structure) in the kernel context in order to retrieve time?

A fast call cannot do any function calls in the kernel context or
otherwise.

The overhead of the function calls will reduce the performance of time
access significantly.


