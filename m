Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261663AbTIZGmC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 02:42:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261959AbTIZGmC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 02:42:02 -0400
Received: from palrel12.hp.com ([156.153.255.237]:21737 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S261663AbTIZGmA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 02:42:00 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16243.57269.841441.275949@napali.hpl.hp.com>
Date: Thu, 25 Sep 2003 23:41:57 -0700
To: "David S. Miller" <davem@redhat.com>
Cc: Manfred Spraul <manfred@colorfullife.com>, linux-kernel@vger.kernel.org
Subject: Re: NS83820 2.6.0-test5 driver seems unstable on IA64
In-Reply-To: <20030925230702.4ef87780.davem@redhat.com>
References: <3F73D9C4.1050201@colorfullife.com>
	<20030925230702.4ef87780.davem@redhat.com>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Thu, 25 Sep 2003 23:07:02 -0700, "David S. Miller" <davem@redhat.com> said:

  David> On Fri, 26 Sep 2003 08:16:36 +0200 Manfred Spraul
  David> <manfred@colorfullife.com> wrote:

  >> Is that really the right solution? Add a full-packet copy to
  >> every driver?

  David> In the short term, yes it is.

I know nothing about the ns83820, but page 22 of the data sheet
(http://www.national.com/pf/DP/DP83820.html) suggests that it would be
possible to setup _two_ descriptors for each incoming packet: the
first one would cover the Ethernet header (14 bytes), the second the
rest.  That way, IP-header would be 8-byte aligned (since the
ns83820's DMA engine seems to require 8-byte alignment for incoming
data).

If so, this would let you get the IP-header and on aligned at the cost
of extra descriptor fetching.  The cost of fetching the extra
descriptor will be big enough that you'd only want to do this when
unaligned accesses are expensive, but hopefully it would be cheaper
than copying the entire packet.

	--david
