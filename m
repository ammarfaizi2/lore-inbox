Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262521AbVAUW6j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262521AbVAUW6j (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 17:58:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262560AbVAUW6j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 17:58:39 -0500
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:20432
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S262521AbVAUW6b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 17:58:31 -0500
Date: Fri, 21 Jan 2005 14:56:08 -0800
From: "David S. Miller" <davem@davemloft.net>
To: David Dillow <dave@thedillows.org>
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org, dave@thedillows.org
Subject: Re: [RFC 2.6.10 4/22] xfrm: Try to offload inbound xfrm_states
Message-Id: <20050121145608.65ad2d48.davem@davemloft.net>
In-Reply-To: <20041230035000.13@ori.thedillows.org>
References: <20041230035000.12@ori.thedillows.org>
	<20041230035000.13@ori.thedillows.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Dec 2004 03:48:35 -0500
David Dillow <dave@thedillows.org> wrote:

> # This is a BitKeeper generated diff -Nru style patch.
> #
> # ChangeSet
> #   2004/12/30 00:33:11-05:00 dave@thedillows.org 
> #   Plumb in offloading of inbound xfrm_states.
> #   
> #   Signed-off-by: David Dillow <dave@thedillows.org>

Hmmm, this seems to deadlock.  xfrm_state_add() is invoked
with the RTNL semaphore already acquired.  For example, via
xfrm_user.c:xfrm_add_sa()
