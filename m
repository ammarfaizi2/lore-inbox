Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265264AbUF1WXq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265264AbUF1WXq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 18:23:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265265AbUF1WXq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 18:23:46 -0400
Received: from mx1.redhat.com ([66.187.233.31]:48540 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265264AbUF1WXo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 18:23:44 -0400
Date: Mon, 28 Jun 2004 15:22:08 -0700
From: "David S. Miller" <davem@redhat.com>
To: Scott Wood <scott@timesys.com>
Cc: oliver@neukum.org, scott@timesys.com, zaitcev@redhat.com, greg@kroah.com,
       arjanv@redhat.com, jgarzik@redhat.com, tburke@redhat.com,
       linux-kernel@vger.kernel.org, stern@rowland.harvard.edu,
       mdharm-usb@one-eyed-alien.net, david-b@pacbell.net
Subject: Re: drivers/block/ub.c
Message-Id: <20040628152208.20fe97f1.davem@redhat.com>
In-Reply-To: <20040628211857.GA5508@yoda.timesys>
References: <20040626130645.55be13ce@lembas.zaitcev.lan>
	<20040628141517.GA4311@yoda.timesys>
	<20040628132531.036281b0.davem@redhat.com>
	<200406282257.11026.oliver@neukum.org>
	<20040628140343.572a0944.davem@redhat.com>
	<20040628211857.GA5508@yoda.timesys>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Jun 2004 17:18:57 -0400
Scott Wood <scott@timesys.com> wrote:

> On Mon, Jun 28, 2004 at 02:03:43PM -0700, David S. Miller wrote:
> > You have not considered what is supposed to happen when this
> > structure is embedded within another one.  What kind of alignment
> > rules apply in that case?  For example:
> > 
> > struct foo {
> > 	u32	x;
> > 	u8	y;
> > 	u16	z;
> > } __attribute__((__packed__));
> > 
> > struct bar {
> > 	u8		a;
> > 	struct foo 	b;
> > };
> 
> As long as bar is not packed, why shouldn't the beginning of bar.b be
> aligned?

No!  bar.b starts at offset 1 byte.  That's how this stuff works.

This is exactly why you cannot assume the alignment of any structure
which is given attribute __packed__.  The example above shows that
quite clearly.

Try it out if you don't believe someone who has maintained the
Linux networking for 7 years and sits on the GCC Steering Committee.
:-)
