Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262521AbVCCSjk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262521AbVCCSjk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 13:39:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262520AbVCCRpV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 12:45:21 -0500
Received: from dsl027-180-174.sfo1.dsl.speakeasy.net ([216.27.180.174]:3048
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S261389AbVCCRoJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 12:44:09 -0500
Date: Thu, 3 Mar 2005 09:43:37 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: nickpiggin@yahoo.com.au, paulus@samba.org, akpm@osdl.org, clameter@sgi.com,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
       anton@samba.org
Subject: Re: Page fault scalability patch V18: Drop first acquisition of ptl
Message-Id: <20050303094337.186d63b2.davem@davemloft.net>
In-Reply-To: <1109831428.5680.187.camel@gaston>
References: <Pine.LNX.4.58.0503011947001.25441@schroedinger.engr.sgi.com>
	<Pine.LNX.4.58.0503011951100.25441@schroedinger.engr.sgi.com>
	<20050302174507.7991af94.akpm@osdl.org>
	<Pine.LNX.4.58.0503021803510.3080@schroedinger.engr.sgi.com>
	<20050302185508.4cd2f618.akpm@osdl.org>
	<Pine.LNX.4.58.0503021856380.3365@schroedinger.engr.sgi.com>
	<20050302201425.2b994195.akpm@osdl.org>
	<16934.39386.686708.768378@cargo.ozlabs.ibm.com>
	<20050302213831.7e6449eb.davem@davemloft.net>
	<1109829248.5679.178.camel@gaston>
	<42274727.2070200@yahoo.com.au>
	<1109831428.5680.187.camel@gaston>
X-Mailer: Sylpheed version 1.0.1 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 03 Mar 2005 17:30:28 +1100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Fri, 2005-03-04 at 04:19 +1100, Nick Piggin wrote:
> 
> > You don't want to do that for all architectures, as I said earlier.
> > eg. i386 can concurrently set the dirty bit with the MMU (which won't
> > honour the lock).
> > 
> > So you then need an atomic lock, atomic pte operations, and atomic
> > unlock where previously you had only the atomic pte operation. This is
> > disastrous for performance.
> 
> Of course, but I was answering to David about sparc64 which uses
> software TLB load :)

Right.

The current situation on sparc64 is that the tlb miss handler is
~10 cycles.

Like I said, I can use this thing if it just increases access, without
modifying the TLB miss handler at all.

Hmmm... let me think about this some more.
