Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265210AbUF1VFu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265210AbUF1VFu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 17:05:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265218AbUF1VFu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 17:05:50 -0400
Received: from mx1.redhat.com ([66.187.233.31]:222 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265210AbUF1VFR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 17:05:17 -0400
Date: Mon, 28 Jun 2004 14:03:43 -0700
From: "David S. Miller" <davem@redhat.com>
To: Oliver Neukum <oliver@neukum.org>
Cc: scott@timesys.com, zaitcev@redhat.com, greg@kroah.com, arjanv@redhat.com,
       jgarzik@redhat.com, tburke@redhat.com, linux-kernel@vger.kernel.org,
       stern@rowland.harvard.edu, mdharm-usb@one-eyed-alien.net,
       david-b@pacbell.net
Subject: Re: drivers/block/ub.c
Message-Id: <20040628140343.572a0944.davem@redhat.com>
In-Reply-To: <200406282257.11026.oliver@neukum.org>
References: <20040626130645.55be13ce@lembas.zaitcev.lan>
	<20040628141517.GA4311@yoda.timesys>
	<20040628132531.036281b0.davem@redhat.com>
	<200406282257.11026.oliver@neukum.org>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Jun 2004 22:57:11 +0200
Oliver Neukum <oliver@neukum.org> wrote:

> Am Montag, 28. Juni 2004 22:25 schrieb David S. Miller:
> > That's true.  But if one were to propose such a feature to the gcc
> > guys, I know the first question they would ask.  "If no padding of
> > the structure is needed, why are you specifying this new
> > __nopadding__ attribute?"
> 
> It would replace some uses of __packed__, where the first element
> is aligned.

You have not considered what is supposed to happen when this
structure is embedded within another one.  What kind of alignment
rules apply in that case?  For example:

struct foo {
	u32	x;
	u8	y;
	u16	z;
} __attribute__((__packed__));

struct bar {
	u8		a;
	struct foo 	b;
};

That is why __packed__ can't assume the alignment of any structure
instance whatsoever.  Your __nopadding__ attribute proposal would
lay out struct bar differently in order to meet the alignment guarentees
you say it will be able to meet.
