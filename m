Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264461AbUFLA1y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264461AbUFLA1y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 20:27:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264452AbUFLA1y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 20:27:54 -0400
Received: from opersys.com ([64.40.108.71]:35341 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S264461AbUFLA1w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 20:27:52 -0400
Message-ID: <40CA4D23.2010006@opersys.com>
Date: Fri, 11 Jun 2004 20:24:03 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: Geoff Levand <geoffrey.levand@am.sony.com>
CC: high-res-timers-discourse@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, George Anzinger <george@mvista.com>
Subject: Re: [ANNOUNCE] high-res-timers patches for 2.6.6
References: <40C7BE29.9010600@am.sony.com>
In-Reply-To: <40C7BE29.9010600@am.sony.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Geoff Levand wrote:
> For those interested, the set of three patches provide POSIX high-res 
> timer support for linux-2.6.6.  The core and i386 patches are updates of 
> George Anzinger's hrtimers-2.6.5-1.0.patch available on SourceForge 
> <http://sourceforge.net/projects/high-res-timers/>.  The ppc32 port is 
> not available on SourceForge yet.

I've got to ask:

Just reading from the Posix 1003.1b section 14 spec referenced by the HRT
main project page, I see the following:
------------------------------------------------------------------------------
Realtime applications must be able to operate on data within strict timing
constraints in order to schedule application or system events. Timing
requirements can be in response to the need for either high system throughput
or fast response time. Applications requiring high throughput may process
large amounts of data and use a continuous stream of data points equally
spaced in time. For example, electrocardiogram research uses a continuous
stream of data for qualitative and quantitative analysis.
------------------------------------------------------------------------------

If this is really the goal here, then why not just integrate Adeos into
the kernel and make some form of HRT as a loadable module that uses Adeos to
provide its services?

Currently Adeos runs on x86, ARM (MMU-full and MMU-less), PPC, so portability
is not an issue. Plus, the interface provided can either be directly used
by drivers to get hard-rt interrupts or it can be used by another layer to
provide more elaborate services (like RTAI or, potentially, HRT.) Using the
virtual interrupts that can be dynamically allocated at runtime, it's rather
easy to send signals between domains.

Sure, you may not have the exact Posix 1003.1b API, but I don't remember there
being any persistent goal of having the kernel conform to any standard.

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546


