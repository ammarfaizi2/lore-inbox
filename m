Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265974AbUH1BMS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265974AbUH1BMS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 21:12:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265971AbUH1BMS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 21:12:18 -0400
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:22403
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S265800AbUH1BMM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 21:12:12 -0400
Date: Fri, 27 Aug 2004 18:11:42 -0700
From: "David S. Miller" <davem@davemloft.net>
To: Andi Kleen <ak@muc.de>
Cc: akpm@osdl.org, clameter@sgi.com, ak@suse.de, wli@holomorphy.com,
       davem@redhat.com, raybry@sgi.com, benh@kernel.crashing.org,
       manfred@colorfullife.com, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, vrajesh@umich.edu, hugh@veritas.com
Subject: Re: page fault scalability patch final : i386 tested, x86_64
 support added
Message-Id: <20040827181142.7c382a65.davem@davemloft.net>
In-Reply-To: <20040828010542.GB50329@muc.de>
References: <20040816143903.GY11200@holomorphy.com>
	<B6E8046E1E28D34EB815A11AC8CA3129027B679F@mtv-atc-605e--n.corp.sgi.com>
	<B6E8046E1E28D34EB815A11AC8CA3129027B67A9@mtv-atc-605e--n.corp.sgi.com>
	<B6E8046E1E28D34EB815A11AC8CA3129027B67B4@mtv-atc-605e--n.corp.sgi.com>
	<Pine.LNX.4.58.0408271616001.14712@schroedinger.engr.sgi.com>
	<20040827233602.GB1024@wotan.suse.de>
	<Pine.LNX.4.58.0408271717400.15597@schroedinger.engr.sgi.com>
	<20040827172337.638275c3.davem@davemloft.net>
	<20040827173641.5cfb79f6.akpm@osdl.org>
	<20040827174038.67b9cbce.davem@davemloft.net>
	<20040828010542.GB50329@muc.de>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 28 Aug 2004 03:05:42 +0200
Andi Kleen <ak@muc.de> wrote:

> I would expect most programs to be not have that many holes,

Holes are not the issue.

clear_page_tables() doesn't even use the VMA list as a guide
(it actually can't), it just walks the page tables one pgd at a
time, one pmd at a time, one pte at a time.  And this has the
worst cache behavior even for simple cases like lat_proc
in lmbench.

Each pgd/pmd scan is a data reading walk of a whole page
(or whatever size the particular page table level blocks
are for the platform, usually they are PAGE_SIZE).
It's very costly.
