Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261432AbTIZRrQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 13:47:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261491AbTIZRrQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 13:47:16 -0400
Received: from palrel11.hp.com ([156.153.255.246]:55715 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S261432AbTIZRrP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 13:47:15 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16244.31648.766419.56901@napali.hpl.hp.com>
Date: Fri, 26 Sep 2003 10:47:12 -0700
To: Andi Kleen <ak@muc.de>
Cc: davidm@hpl.hp.com, linux-kernel@vger.kernel.org
Subject: Re: NS83820 2.6.0-test5 driver seems unstable on IA64
In-Reply-To: <m37k3viiqp.fsf@averell.firstfloor.org>
References: <A2yd.64p.31@gated-at.bofh.it>
	<A2yd.64p.29@gated-at.bofh.it>
	<A317.6GH.7@gated-at.bofh.it>
	<m37k3viiqp.fsf@averell.firstfloor.org>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Fri, 26 Sep 2003 19:04:30 +0200, Andi Kleen <ak@muc.de> said:

  Andi> David Mosberger <davidm@napali.hpl.hp.com> writes:
  >> Why would that be?  Slower, yes, but very slow?

  Andi> It depends on your architecture I guess. On K8/x86-64 it isn't
  Andi> that big a deal (one cycle penalty for unaligned accesses),
  Andi> but if you take an exception for each unaligned read it will
  Andi> be incredible slow.

What are you talking about?  Arches that don't like/support unaligned
accesses will certainly have a copy_user() which handles misalignment
just fine.  For example, on ia64, the copy will run slightly slower
because of an additional shift in the loop, but that penalty only
shows on fully cached data.  If the data is not cached, the copy speed
for aligned vs. misaligned data is virtually the same.

  Andi> Use one receive descriptor for the MAC header and another for
  Andi> the rest (IP/TCP/payload) In the rest everything is aligned
  Andi> and there are no problems with misaligned data types (ignoring
  Andi> exceptional cases like broken timestamp options which can be
  Andi> handled slowly).

That's what I proposed.

  Andi> Fixing the stack to handle separate MAC headers should not be
  Andi> that much work, the code is fairly limited. Drawback is that
  Andi> it requires bigger changes to the network drivers and maybe
  Andi> some special case code for non standard MAC headers.

I suspect you'd be better off just copying the 14 bytes of the
Ethernet header so that the entire packet is contiguous.

	--david
