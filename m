Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262176AbVCOAsN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262176AbVCOAsN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 19:48:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262175AbVCOApH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 19:45:07 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:206 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262143AbVCOAHX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 19:07:23 -0500
Date: Mon, 14 Mar 2005 16:01:34 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Matt Mackall <mpm@selenic.com>
cc: john stultz <johnstul@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>,
       Tim Schmielau <tim@physik3.uni-rostock.de>,
       George Anzinger <george@mvista.com>, albert@users.sourceforge.net,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Dominik Brodowski <linux@dominikbrodowski.de>,
       David Mosberger <davidm@hpl.hp.com>, Andi Kleen <ak@suse.de>,
       paulus@samba.org, schwidefsky@de.ibm.com,
       keith maanthey <kmannth@us.ibm.com>, Patricia Gaughen <gone@us.ibm.com>,
       Chris McDermott <lcm@us.ibm.com>, Max Asbock <masbock@us.ibm.com>,
       mahuja@us.ibm.com, Nishanth Aravamudan <nacc@us.ibm.com>,
       Darren Hart <darren@dvhart.com>, "Darrick J. Wong" <djwong@us.ibm.com>,
       Anton Blanchard <anton@samba.org>, donf@us.ibm.com
Subject: Re: [RFC][PATCH] new timeofday core subsystem (v. A3)
In-Reply-To: <20050314202702.GF32638@waste.org>
Message-ID: <Pine.LNX.4.58.0503141559330.15032@schroedinger.engr.sgi.com>
References: <1110590655.30498.327.camel@cog.beaverton.ibm.com>
 <20050313004902.GD3163@waste.org> <1110825765.30498.370.camel@cog.beaverton.ibm.com>
 <20050314192918.GC32638@waste.org> <1110829401.30498.383.camel@cog.beaverton.ibm.com>
 <20050314195110.GD32638@waste.org> <1110830647.30498.388.camel@cog.beaverton.ibm.com>
 <20050314202702.GF32638@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Mar 2005, Matt Mackall wrote:
> We can either stick all the generic mmio timer functions in the
> vsyscall page (they're tiny) or leave the vsyscall using type/ptr but
> have the kernel internally use only the function pointer. Someone
> who's more familiar with the vsyscall timer code should chime in here.

No we cannot do any function calls in a fastcall path on ia64. The current
design is ok. Why duplicate the functionality with additional indirect
function calls? Plus an indirect function  calls stalls pipelines on some
processors and will limit the performance of gettimeofday.

