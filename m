Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261360AbVC0ScQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261360AbVC0ScQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Mar 2005 13:32:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261379AbVC0ScQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Mar 2005 13:32:16 -0500
Received: from dsl027-180-174.sfo1.dsl.speakeasy.net ([216.27.180.174]:60615
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S261360AbVC0ScK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Mar 2005 13:32:10 -0500
Date: Sun, 27 Mar 2005 10:23:13 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Andi Kleen <ak@muc.de>
Cc: davidm@hpl.hp.com, clameter@sgi.com, vda@port.imtp.ilyichevsk.odessa.ua,
       haveblue@us.ibm.com, akpm@osdl.org, linux-kernel@vger.kernel.org,
       mel@csn.ul.ie, linux-ia64@vger.kernel.org, Jens.Maurer@gmx.net
Subject: Re: [PATCH] add a clear_pages function to clear pages of higher
 order
Message-Id: <20050327102313.04498cdc.davem@davemloft.net>
In-Reply-To: <20050327171220.GA18506@muc.de>
References: <Pine.LNX.4.58.0503101229420.13911@schroedinger.engr.sgi.com>
	<200503111008.12134.vda@port.imtp.ilyichevsk.odessa.ua>
	<Pine.LNX.4.58.0503161720570.1787@schroedinger.engr.sgi.com>
	<200503181154.37414.vda@port.imtp.ilyichevsk.odessa.ua>
	<Pine.LNX.4.58.0503180652350.15022@schroedinger.engr.sgi.com>
	<20050318192808.GB38053@muc.de>
	<16963.2075.713737.485070@napali.hpl.hp.com>
	<20050327171220.GA18506@muc.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 27 Mar 2005 19:12:20 +0200
Andi Kleen <ak@muc.de> wrote:

> With non temporal stores
> you guarantee at least one hard cache miss directly after
> the return to user space.

This is true if the cacheline were not present already at
the time of the non-temporal store.

I know what you're trying to say, I'm just clarifying.

The real question is if a large enough ratio of those
cachelines in the page get similarly accessed.  I happen
to think the answer to that for any real example is yes.
Yet, I have no way to prove this.

It would be cool to do some hacks under Xen or user-mode
Linux to get some real statistics about this.  Actually,
this could be done also with hacks to valgrind or other
similar tools.  QEMU could also be used.
