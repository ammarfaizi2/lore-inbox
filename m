Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262534AbVA1SHr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262534AbVA1SHr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 13:07:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261503AbVA1SEq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 13:04:46 -0500
Received: from fw.osdl.org ([65.172.181.6]:21134 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261518AbVA1SCZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 13:02:25 -0500
Date: Fri, 28 Jan 2005 10:02:29 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: Lorenzo =?ISO-8859-1?B?SGVybuFuZGV6IEdhcmPtYS1IaWVycm8=?= 
	<lorenzo@gnu.org>
Cc: netdev@oss.sgi.co, linux-kernel@vger.kernel.org,
       Chris Wright <chrisw@osdl.org>
Subject: Re: [PATCH] OpenBSD Networking-related randomization port
Message-ID: <20050128100229.5c0e4ea1@dxpl.pdx.osdl.net>
In-Reply-To: <1106932637.3778.92.camel@localhost.localdomain>
References: <1106932637.3778.92.camel@localhost.localdomain>
Organization: Open Source Development Lab
X-Mailer: Sylpheed-Claws 0.9.13 (GTK+ 1.2.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Attached you can find a split up patch ported from grSecurity [1], as
> Linus commented that he wouldn't get a whole-sale patch, I was working
> on it and also studying what features of grSecurity can be implemented
> without a development or maintenance overhead, aka less-invasive
> implementations.
> 
> It adds support for advanced networking-related randomization, in
> concrete it adds support for TCP ISNs randomization, RPC XIDs
> randomization, IP IDs randomization and finally a sub-key under the
> Cryptographic options menu for Linux PRNG [2] enhancements (useful now
> and also for future patch submissions), which currently has an only-one
> option for poll sizes increasing (x2).
> 
> As it's impact is minimal (in performance and development/maintenance
> terms), I recommend to merge it, as it gives a basic prevention for the
> so-called system fingerprinting (which is used most by "kids" to know
> how old and insecure could be a target system, many time used as the
> first, even only-one, data to decide if attack or not the target host)
> among other things.
> 
> There's only a missing feature that is present on grSecurity, the
> sources ports randomization which seems achieved now by some changes
> that can be checked out in the Linux BKBits repository:
> http://linux.bkbits.net:8080/linux-2.6/diffs/net/ipv4/tcp_ipv4.c@1.105?nav=index.html|src/|src/net|src/net/ipv4|hist/net/ipv4/tcp_ipv4.c
> (net/ipv4/tcp_ipv4.c@1.105)
> 
> I'm not sure of the effectiveness of that changes, but I just prefer to
> keep it as most simple as possible.If there are thoughts on reverting to
> the old schema, and using obsd_rand.c code instead, just drop me a line
> and I will modify the patch.

Okay, but:
* Need to give better explanation of why this is required, 
  existing randomization code in network is compromise between
  performance and security. So you need to quantify the performance
  impact of this, and the security threat reduction.

* Why are the OpenBSD random functions better? because they have more
  security coolness factor?

* It is hard to have two levels of security based on config options.
  Think of a distro vendor, do they ship the fast or the secure system??

As always:
* Send networking stuff to netdev@oss.sgi.com
* Please split up patches.

