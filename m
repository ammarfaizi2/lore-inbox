Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266999AbTBCWZB>; Mon, 3 Feb 2003 17:25:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267021AbTBCWZB>; Mon, 3 Feb 2003 17:25:01 -0500
Received: from ip64-48-93-2.z93-48-64.customer.algx.net ([64.48.93.2]:41920
	"EHLO ns1.limegroup.com") by vger.kernel.org with ESMTP
	id <S266999AbTBCWZA>; Mon, 3 Feb 2003 17:25:00 -0500
Date: Mon, 3 Feb 2003 17:34:20 -0500 (EST)
From: Ion Badulescu <ionut@badula.org>
X-X-Sender: ion@guppy.limebrokerage.com
To: Joakim Tjernlund <Joakim.Tjernlund@lumentis.se>
cc: Jeff Garzik <jgarzik@pobox.com>, <linux-kernel@vger.kernel.org>
Subject: Re: NETIF_F_SG question
In-Reply-To: <006a01c2cbd2$bff0b870$020120b0@jockeXP>
Message-ID: <Pine.LNX.4.44.0302031725090.27869-100000@guppy.limebrokerage.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Feb 2003, Joakim Tjernlund wrote:

> > You get zerocopy, yes. :-) No HW cksum, no zerocopy.
> 
> OK, but it should be easy to remove HW cksum as a condition to do zerocopy?

Nope. You're looking at this the wrong way: the goal is not zero copy, but 
zero data access by CPU. Once you realize that, it's clear that SG alone 
is no good.

This is not necessarily the only approach, but it is the current approach 
in the Linux IPv4 stack. It's not worth the effort to re-engineer the code 
in order to support the fast-disappearing hardware which supports SG but 
not cksums.

> zerocopy without requiring HW cksums only OR could for instance the forwarding
> procdure also benefit from SG without  requiring HW cksums?

The forwarding procedure is already dealing with linear buffers because 
99.99% of the network cards on the market receive packets into one linear 
buffer. So again SG is useless for that.

Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.

