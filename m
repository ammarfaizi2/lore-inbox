Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261291AbTISFB0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 01:01:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261297AbTISFB0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 01:01:26 -0400
Received: from mail014.syd.optusnet.com.au ([211.29.132.160]:12013 "EHLO
	mail014.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261291AbTISFBX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 01:01:23 -0400
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16234.36238.848366.753588@wombat.chubb.wattle.id.au>
Date: Fri, 19 Sep 2003 15:01:02 +1000
To: Andi Kleen <ak@suse.de>
Cc: Grant Grundler <iod00d@hp.com>, Peter Chubb <peterc@gelato.unsw.edu.au>,
       linux-ns83820@kvack.org, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: NS83820 2.6.0-test5 driver seems unstable on IA64
In-Reply-To: <20030919044315.GC7666@wotan.suse.de>
References: <16234.33565.64383.838490@wombat.disy.cse.unsw.edu.au>
	<20030919043847.GA2996@cup.hp.com>
	<20030919044315.GC7666@wotan.suse.de>
X-Mailer: VM 7.14 under 21.4 (patch 13) "Rational FORTRAN" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 On Thu, Sep 18, 2003 at 09:38:47PM -0700, Grant Grundler wrote:
> On Fri, Sep 19, 2003 at 02:16:29PM +1000, Peter Chubb wrote: 
>> The
>> obvious approach of realigning the SKB by 2 bytes seems not to 
>> work.

> Could you be more detailed about the "obvious approach"?  ie show
> the diff of what you changed.


It doesn't work as in no error messages, no pings, no interrupts to the
driver.  And the kernel hangs after a short while.

This is what I changed:

===== drivers/net/ns83820.c 1.19 vs edited =====
--- 1.19/drivers/net/ns83820.c  Thu Jun  5 13:50:00 2003
+++ edited/drivers/net/ns83820.c        Fri Sep 19 13:49:23 2003
@@ -567,7 +567,7 @@
                res = (long)skb->tail & 0xf;
                res = 0x10 - res;
                res &= 0xf;
-               skb_reserve(skb, res);
+               skb_reserve(skb, res+2);
 
                skb->dev = &dev->net_dev;
                if (gfp != GFP_ATOMIC)


--
Dr Peter Chubb  http://www.gelato.unsw.edu.au  peterc AT gelato.unsw.edu.au
You are lost in a maze of BitKeeper repositories,   all slightly different.
