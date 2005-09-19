Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932675AbVISWyl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932675AbVISWyl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 18:54:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932723AbVISWyk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 18:54:40 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:62421
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S932675AbVISWyk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 18:54:40 -0400
Subject: Re: [ANNOUNCE] ktimers subsystem
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Christopher Friesen <cfriesen@nortel.com>
Cc: Christoph Lameter <clameter@engr.sgi.com>, linux-kernel@vger.kernel.org,
       mingo@elte.hu, akpm@osdl.org, george@mvista.com, johnstul@us.ibm.com,
       paulmck@us.ibm.com
In-Reply-To: <432F3E0F.1010002@nortel.com>
References: <20050919184834.1.patchmail@tglx.tec.linutronix.de>
	 <Pine.LNX.4.62.0509191500040.27238@schroedinger.engr.sgi.com>
	 <1127168232.24044.265.camel@tglx.tec.linutronix.de>
	 <432F3E0F.1010002@nortel.com>
Content-Type: text/plain
Organization: linutronix
Date: Tue, 20 Sep 2005 00:54:48 +0200
Message-Id: <1127170488.24044.291.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-09-19 at 16:39 -0600, Christopher Friesen wrote:
> Thomas Gleixner wrote:
> 
> > We should rather ask glibc people why gettimeofday() / clock_getttime()
> > is called inside the library code all over the place for non obvious
> > reasons.
> 
>  From an app point of view, there are any number of reasons to check the 
> time frequently.
> 
> --debugging

Non standard case.

> --flight-recorder style logs

If you want to implement such stuff efficiently you rely on rdtscll() on
x86 or other monotonic easy accessible time souces and not on a
permanent call to gettimeofday.

> --if you've got timers in your application, you may want to check to 
> make sure that you didn't get woken up early (the linux behaviour of 
> returning unused time in select is not portable)

#ifdef is portable


Please beware me of red herrings. If application developers code with
respect to random OS worst case behaviour then they should not complain
that OS N is having an additional add instruction in one of the pathes.

tglx


