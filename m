Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267890AbUH1AZn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267890AbUH1AZn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 20:25:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267872AbUH1AZj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 20:25:39 -0400
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:26242
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S267890AbUH1AYY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 20:24:24 -0400
Date: Fri, 27 Aug 2004 17:23:37 -0700
From: "David S. Miller" <davem@davemloft.net>
To: Christoph Lameter <clameter@sgi.com>
Cc: ak@suse.de, akpm@osdl.org, wli@holomorphy.com, davem@redhat.com,
       raybry@sgi.com, ak@muc.de, benh@kernel.crashing.org,
       manfred@colorfullife.com, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, vrajesh@umich.edu, hugh@veritas.com
Subject: Re: page fault scalability patch final : i386 tested, x86_64
 support added
Message-Id: <20040827172337.638275c3.davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.58.0408271717400.15597@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0408151552280.3370@schroedinger.engr.sgi.com>
	<20040815165827.0c0c8844.davem@redhat.com>
	<Pine.LNX.4.58.0408151703580.3751@schroedinger.engr.sgi.com>
	<20040815185644.24ecb247.davem@redhat.com>
	<Pine.LNX.4.58.0408151924250.4480@schroedinger.engr.sgi.com>
	<20040816143903.GY11200@holomorphy.com>
	<B6E8046E1E28D34EB815A11AC8CA3129027B679F@mtv-atc-605e--n.corp.sgi.com>
	<B6E8046E1E28D34EB815A11AC8CA3129027B67A9@mtv-atc-605e--n.corp.sgi.com>
	<B6E8046E1E28D34EB815A11AC8CA3129027B67B4@mtv-atc-605e--n.corp.sgi.com>
	<Pine.LNX.4.58.0408271616001.14712@schroedinger.engr.sgi.com>
	<20040827233602.GB1024@wotan.suse.de>
	<Pine.LNX.4.58.0408271717400.15597@schroedinger.engr.sgi.com>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Aug 2004 17:19:11 -0700 (PDT)
Christoph Lameter <clameter@sgi.com> wrote:

> That is still 2^(32+12) = 2^44 = 16TB.

It's actually:

	2 ^ (31 + PAGE_SHIFT)

'31' because atomic_t is 'signed' and PAGE_SHIFT should
be obvious.

Christoph definitely has a point, this is even more virtual space
than most of the 64-bit platforms even support.  (Sparc64 is
2^43 and I believe ia64 is similar)  and this limit actually
mostly comes from the 3-level page table limits.

