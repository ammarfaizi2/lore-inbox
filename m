Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269328AbUJFSP3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269328AbUJFSP3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 14:15:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269345AbUJFSP3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 14:15:29 -0400
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:27285
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S269328AbUJFSP2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 14:15:28 -0400
Date: Wed, 6 Oct 2004 11:14:31 -0700
From: "David S. Miller" <davem@davemloft.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: jgarzik@pobox.com, acme@conectiva.com.br, corey@world.std.com,
       netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: Raylink/WebGear testing - ray_cs.c iomem bug?
Message-Id: <20041006111431.442ff47e.davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.58.0410061102590.8290@ppc970.osdl.org>
References: <Pine.LNX.4.58.0410061032410.8290@ppc970.osdl.org>
	<20041006105453.5f7d1888.davem@davemloft.net>
	<Pine.LNX.4.58.0410061102590.8290@ppc970.osdl.org>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Oct 2004 11:06:45 -0700 (PDT)
Linus Torvalds <torvalds@osdl.org> wrote:

> > NUMBER_OF_CCS is 64, and the difference between CCS_BASE and RCS_BASE
> > is 0x400 so this really doesn't account for anything.
> 
> It does, though: as I noted in my second mail (after trying to figure it
> out some more) the size of both ccs and rcs is 16 bytes, so when you
> offset by 64, so the difference between RCS_BASE and CCS_BASE ends up 
> being exactly "NUMBER_OF_CCS*sizeof(struct ccs/rcs)", which explains how 
> the base is the same, and the _index_ ends up being the one that selects 
> between the two.

Right, that makes perfect sense.  I missed how it was doing structure
pointer arithmetic when offsetting by the index.
