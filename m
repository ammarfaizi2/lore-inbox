Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266216AbUA1WPi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 17:15:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266222AbUA1WPi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 17:15:38 -0500
Received: from mx1.redhat.com ([66.187.233.31]:63371 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266213AbUA1WPf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 17:15:35 -0500
Date: Wed, 28 Jan 2004 14:15:24 -0800
From: "David S. Miller" <davem@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: ak@suse.de, willy@debian.org, ishii.hironobu@jp.fujitsu.com,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: [RFC/PATCH, 2/4] readX_check() performance evaluation
Message-Id: <20040128141524.5922fe67.davem@redhat.com>
In-Reply-To: <Pine.LNX.4.58.0401281340301.28145@home.osdl.org>
References: <00a301c3e541$c13a6350$2987110a@lsd.css.fujitsu.com>
	<Pine.LNX.4.58.0401271847440.10794@home.osdl.org>
	<20040128182003.GL11844@parcelfarce.linux.theplanet.co.uk>
	<Pine.LNX.4.58.0401281129570.28145@home.osdl.org>
	<20040128204049.627e6312.ak@suse.de>
	<Pine.LNX.4.58.0401281205250.28145@home.osdl.org>
	<20040128211554.0cc890fb.ak@suse.de>
	<Pine.LNX.4.58.0401281221320.28145@home.osdl.org>
	<20040128220921.7ba0bb78.ak@suse.de>
	<Pine.LNX.4.58.0401281340301.28145@home.osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Jan 2004 13:43:54 -0800 (PST)
Linus Torvalds <torvalds@osdl.org> wrote:

> On Wed, 28 Jan 2004, Andi Kleen wrote:
> >
> > On Wed, 28 Jan 2004 12:28:56 -0800 (PST)
> > Linus Torvalds <torvalds@osdl.org> wrote:
> > 
> > > 
> > > Alternatively, if you get a lot of information at MCE time (CPU that did
> > > the access + some device data), just queue up the information in a per-CPU
> > > queue. You don't have to worry about overflow - you can just drop if if 
> > 
> > That assumes that the access happened with preempt off ?
> 
> Yes. I assume you want _some_ locking anyway, at least within that 
> particular device driver (you don't want to have an irq handler touch the 
> device at the same time you are doing this thing), so any such spinlock 
> would have disabled preemption anyway.

I am rather certain you are going to need to do a per-controller lock
the driver will need to grab during such sequences.  It is the only way
I can see, if the state sits in some controller register or resetting
that status must be done in the controller, to keep two driver inits
or resets or whatever from bumping into each other.
