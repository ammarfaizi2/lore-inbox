Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262608AbUCaWhA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 17:37:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262547AbUCaWg7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 17:36:59 -0500
Received: from mail1.slu.se ([130.238.96.11]:36575 "EHLO mail1.slu.se")
	by vger.kernel.org with ESMTP id S262608AbUCaWg5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 17:36:57 -0500
From: Robert Olsson <Robert.Olsson@data.slu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16491.18384.536778.338660@robur.slu.se>
Date: Thu, 1 Apr 2004 00:36:00 +0200
To: Andrea Arcangeli <andrea@suse.de>
Cc: Dipankar Sarma <dipankar@in.ibm.com>,
       Robert Olsson <Robert.Olsson@data.slu.se>,
       "David S. Miller" <davem@redhat.com>, kuznet@ms2.inr.ac.ru,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com, paulmck@us.ibm.com,
       akpm@osdl.org
Subject: Re: route cache DoS testing and softirqs
In-Reply-To: <20040331212817.GQ2143@dualathlon.random>
References: <20040329222926.GF3808@dualathlon.random>
	<200403302005.AAA00466@yakov.inr.ac.ru>
	<20040330211450.GI3808@dualathlon.random>
	<20040330133000.098761e2.davem@redhat.com>
	<20040330213742.GL3808@dualathlon.random>
	<20040331171023.GA4543@in.ibm.com>
	<16491.4593.718724.277551@robur.slu.se>
	<20040331203750.GB4543@in.ibm.com>
	<20040331212817.GQ2143@dualathlon.random>
X-Mailer: VM 7.17 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrea Arcangeli writes:

 > Maybe the problem is simply that NAPI should be tuned more aggressively,
 > it may have to poll for a longer time before giving up.

 It cannot poll much more... 20 Million packets were injected in total
 there were 250 RX irq's. Most from my ssh sessions. There are some TX 
 interrupts... it's another story

 Packet flooding is just our way to generate load and kernel locking must 
 work with and without irq's. As far as I understand the real problem is 
 when do_softirq is run from irqexit etc.

 Some thoughts...

 If we tag the different do_softirq sources (look in my testpatch) we can 
 control the softirqs better. For example; do_softirq's from irqexit etc 
 could be given low a "max_restart" this to move processing to ksoftird 
 maybe even dynamic.

 Cheers.
						--ro
