Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267460AbUHPGaV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267460AbUHPGaV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 02:30:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267465AbUHPGaV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 02:30:21 -0400
Received: from mx1.redhat.com ([66.187.233.31]:47558 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267460AbUHPGaQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 02:30:16 -0400
Date: Sun, 15 Aug 2004 23:27:54 -0700
From: "David S. Miller" <davem@redhat.com>
To: Andi Kleen <ak@suse.de>
Cc: shemminger@osdl.org, alan@lxorguk.ukuu.org.uk, tytso@mit.edu,
       netdev@oss.sgi.com, linux-kernel@vger.kernel.org,
       greearb@candelatech.com
Subject: Re: [RFC] enhanced version of net_random()
Message-Id: <20040815232754.2464e731.davem@redhat.com>
In-Reply-To: <20040813212857.7dd50320.ak@suse.de>
References: <20040812104835.3b179f5a@dell_ss3.pdx.osdl.net>
	<20040812124854.646f1936.davem@redhat.com>
	<20040813115140.0f09d889@dell_ss3.pdx.osdl.net>
	<20040813212857.7dd50320.ak@suse.de>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Aug 2004 21:28:57 +0200
Andi Kleen <ak@suse.de> wrote:

> On Fri, 13 Aug 2004 11:51:40 -0700
> Stephen Hemminger <shemminger@osdl.org> wrote:
> 
> > Here is another alternative, using tansworthe generator.  It uses percpu
> > state. The one small semantic change is the net_srandom() only affects
> > the current cpu's seed.  The problem was that having it change all cpu's
> > seed would mean adding locking 
> 
> I would just update the other CPUs without locking. Taking
> a random number from a partially updated state shouldn't be a big 
> issue.

I personally don't think we need to touch the other cpus
at all, and that having a different current seed on each
cpu might actually be a good thing.

Stephen, I like this one a lot, especially compared to
what we had before.  I'm going to add this to my tree for
the time being.
