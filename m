Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269324AbUJFR4G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269324AbUJFR4G (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 13:56:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269341AbUJFR4G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 13:56:06 -0400
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:59284
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S269324AbUJFR4C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 13:56:02 -0400
Date: Wed, 6 Oct 2004 10:54:53 -0700
From: "David S. Miller" <davem@davemloft.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: jgarzik@pobox.com, acme@conectiva.com.br, corey@world.std.com,
       netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: Raylink/WebGear testing - ray_cs.c iomem bug?
Message-Id: <20041006105453.5f7d1888.davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.58.0410061032410.8290@ppc970.osdl.org>
References: <Pine.LNX.4.58.0410061032410.8290@ppc970.osdl.org>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Oct 2004 10:43:50 -0700 (PDT)
Linus Torvalds <torvalds@osdl.org> wrote:

> That cleanup in turn seems to show that the driver was fundamentally buggy
> in a way that really surprises me: it adds "CCS_BASE" to the PCI window
> base in order to get to both the "struct ccs" pointer _and_ to the "struct
> rcs" pointer.

In the spot where this occurs, it adds both CCS_BASE and
'rcsindex' to the sram base, and only when rcsindex >= NUMBER_OF_CCS.

NUMBER_OF_CCS is 64, and the difference between CCS_BASE and RCS_BASE
is 0x400 so this really doesn't account for anything.

I can't see how you've changed the behavior, so it should work as well
as it did before your changes.

Sorry, I don't have a ray_cs handy :)
