Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261877AbVDESc0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261877AbVDESc0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 14:32:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261876AbVDESbV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 14:31:21 -0400
Received: from dsl027-180-174.sfo1.dsl.speakeasy.net ([216.27.180.174]:30594
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S261861AbVDES2E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 14:28:04 -0400
Date: Tue, 5 Apr 2005 11:26:08 -0700
From: "David S. Miller" <davem@davemloft.net>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org, stable@kernel.org,
       shemminger@osdl.org, netdev@oss.sgi.com
Subject: Re: [07/08] [TCP] Fix BIC congestion avoidance algorithm error
Message-Id: <20050405112608.0b3c07f0.davem@davemloft.net>
In-Reply-To: <20050405182202.GA11979@thunk.org>
References: <20050405164539.GA17299@kroah.com>
	<20050405164758.GH17299@kroah.com>
	<20050405182202.GA11979@thunk.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Apr 2005 14:22:02 -0400
Theodore Ts'o <tytso@mit.edu> wrote:

> If the congestion control alogirthm is "Reno-like", what is
> user-visible impact to users?  There are OS's out there with TCP/IP
> stacks that are still using Reno, aren't there?  

An incorrect implementation of any congestion control algorithm
has ramifications not considered when the congestion control
author verified the design of his algorithm.

This has a large impact on every user on the internet, not just
Linux machines.

Perhaps on a microscopic scale "this" part of the BIC algorithm
was just behaving Reno-like due to the bug, but what implications
does that error have as applied to the other heuristics in BIC?
This is what I'm talking about.  BIC operates in several modes,
one of which is a pseudo binary search mode, and another is a
less aggressive slower increase mode.

Therefore I think fixes to congestion control algorithms which
are enabled by default always should take a high priority in
the stable kernels.
