Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964777AbVISWoI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964777AbVISWoI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 18:44:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964776AbVISWoI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 18:44:08 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:51669
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S964775AbVISWoG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 18:44:06 -0400
Subject: Re: [ANNOUNCE] ktimers subsystem
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu, akpm@osdl.org,
       george@mvista.com, johnstul@us.ibm.com, paulmck@us.ibm.com
In-Reply-To: <Pine.LNX.4.62.0509191521400.27238@schroedinger.engr.sgi.com>
References: <20050919184834.1.patchmail@tglx.tec.linutronix.de>
	 <Pine.LNX.4.62.0509191500040.27238@schroedinger.engr.sgi.com>
	 <1127168232.24044.265.camel@tglx.tec.linutronix.de>
	 <Pine.LNX.4.62.0509191521400.27238@schroedinger.engr.sgi.com>
Content-Type: text/plain
Organization: linutronix
Date: Tue, 20 Sep 2005 00:44:09 +0200
Message-Id: <1127169849.24044.279.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-09-19 at 15:24 -0700, Christoph Lameter wrote:

> > We should rather ask glibc people why gettimeofday() / clock_getttime()
> > is called inside the library code all over the place for non obvious
> > reasons.
> 
> You can ask lots of application vendors the same question because its all 
> over lots of user space code. The fact is that gettimeofday() / 
> clock_gettime() efficiency is very critical to the performance of many 
> applications on Linux. That is why the addtion of one add instruction may 
> better be carefully considered. 

Hmm. I don't understand the argument line completely. 

1. The kernel has to provide ugly mechanisms because a lot of
applications implementations are doing the Wrong Thing ?

2. All gettimeofday implementations I have looked at do a lot of math
anyway, so its definitely more interesting to look at those oddities
rather than discussing a single add. John Stulz timeofday rework have a
clean solution for this - please do not argue about the div64 in his
original patches which he is reworking at the moment.

> Many platforms can execute gettimeofday 
> without having to enter the kernel.

Which ones ? How is this achieved with respect to all the time adjust,
correction... code ?

tglx


