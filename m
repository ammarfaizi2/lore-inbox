Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266075AbUA1VKo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 16:10:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266091AbUA1VKo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 16:10:44 -0500
Received: from ns.suse.de ([195.135.220.2]:25777 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S266038AbUA1VKl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 16:10:41 -0500
Date: Wed, 28 Jan 2004 22:09:21 +0100
From: Andi Kleen <ak@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: willy@debian.org, ishii.hironobu@jp.fujitsu.com,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: [RFC/PATCH, 2/4] readX_check() performance evaluation
Message-Id: <20040128220921.7ba0bb78.ak@suse.de>
In-Reply-To: <Pine.LNX.4.58.0401281221320.28145@home.osdl.org>
References: <00a301c3e541$c13a6350$2987110a@lsd.css.fujitsu.com>
	<Pine.LNX.4.58.0401271847440.10794@home.osdl.org>
	<20040128182003.GL11844@parcelfarce.linux.theplanet.co.uk>
	<Pine.LNX.4.58.0401281129570.28145@home.osdl.org>
	<20040128204049.627e6312.ak@suse.de>
	<Pine.LNX.4.58.0401281205250.28145@home.osdl.org>
	<20040128211554.0cc890fb.ak@suse.de>
	<Pine.LNX.4.58.0401281221320.28145@home.osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Jan 2004 12:28:56 -0800 (PST)
Linus Torvalds <torvalds@osdl.org> wrote:

> 
> Alternatively, if you get a lot of information at MCE time (CPU that did
> the access + some device data), just queue up the information in a per-CPU
> queue. You don't have to worry about overflow - you can just drop if if 

That assumes that the access happened with preempt off ?

That's fine if it's guaranteed that the MCE still happened inside 
readl/writel. But if it's delayed longer for some reason there is no guarantee 
that you can find back to the CPU that caused the fault.

Putting it into the pci_dev and using RCU would be probably better.

-Andi
