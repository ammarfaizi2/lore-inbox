Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261744AbVAXXdI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261744AbVAXXdI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 18:33:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261741AbVAXXcj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 18:32:39 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:60891 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261664AbVAXX33 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 18:29:29 -0500
Date: Mon, 24 Jan 2005 15:29:01 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: john stultz <johnstul@us.ibm.com>
cc: lkml <linux-kernel@vger.kernel.org>,
       Tim Schmielau <tim@physik3.uni-rostock.de>,
       George Anzinger <george@mvista.com>, albert@users.sourceforge.net,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Dominik Brodowski <linux@dominikbrodowski.de>,
       David Mosberger <davidm@hpl.hp.com>, Andi Kleen <ak@suse.de>,
       paulus@samba.org, schwidefsky@de.ibm.com,
       keith maanthey <kmannth@us.ibm.com>, Patricia Gaughen <gone@us.ibm.com>,
       Chris McDermott <lcm@us.ibm.com>, Max Asbock <amax@us.ibm.com>,
       mahuja@us.ibm.com, Nishanth Aravamudan <nacc@us.ibm.com>,
       Darren Hart <darren@dvhart.com>, "Darrick J. Wong" <djwong@us.ibm.com>,
       Anton Blanchard <anton@samba.org>
Subject: Re: [RFC][PATCH] new timeofday arch specific timesources (v. A2)
In-Reply-To: <1106607215.30884.14.camel@cog.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.58.0501241525020.17986@schroedinger.engr.sgi.com>
References: <1106607089.30884.10.camel@cog.beaverton.ibm.com> 
 <1106607153.30884.12.camel@cog.beaverton.ibm.com>
 <1106607215.30884.14.camel@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Jan 2005, john stultz wrote:

> +/* helper macro to atomically read both cyclone counter registers */
> +#define read_cyclone_counter(low,high) \
> +	do{ \
> +		high = cyclone_timer[1]; low = cyclone_timer[0]; \
> +	} while (high != cyclone_timer[1]);

This is only necessary on 32 bit platforms. On ia64 an atomic read would
do the job. Maybe that logic needs to go into the custom defined readq for
32 bit? Then you could avoid repeating the code for drivers that read 64
bit clocks on 32bit processors.
