Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261181AbUCPSqg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 13:46:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261183AbUCPSqg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 13:46:36 -0500
Received: from mx1.redhat.com ([66.187.233.31]:33958 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261181AbUCPSqb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 13:46:31 -0500
Date: Tue, 16 Mar 2004 10:46:27 -0800
From: "David S. Miller" <davem@redhat.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: olh@suse.de, linux-kernel@vger.kernel.org
Subject: Re: consistent_sync_for_cpu() and friends on ppc32
Message-Id: <20040316104627.47fc1f25.davem@redhat.com>
In-Reply-To: <1079400967.2302.213.camel@gaston>
References: <20040315201616.GA31268@suse.de>
	<20040315123647.4ce943b7.davem@redhat.com>
	<1079396621.1967.196.camel@gaston>
	<20040315164917.6a85966b.davem@redhat.com>
	<1079400967.2302.213.camel@gaston>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Mar 2004 12:36:07 +1100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> Hrm... I'm still not sure how I'm supposed to implement those
> for non-consistent PPCs (embedded). We don't carry state information
> around, so I suppose I'll have to rely on the direction beeing the
> same for the whole duration of the operation... In which case, it's
> just a matter of having for_cpu nop'ing when direction is TO_DEVICE
> and for_device nop'ing when direction is FROM_DEVICE ? Not clear
> imho...

See, the direction really doesn't matter for the sync ops.

If you flush the cpu caches at MAP time, and your PCI controller doesn't
have DMA caching or something like that, then sync for CPU can always be
a nop.  You will have always previously flushed the cpu caches before
giving the buffer back to the device, either via MAP or sync for device
calls.

So basically, make MAP and sync for device writeback flush the cpu caches.
