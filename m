Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751009AbVLQGAl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751009AbVLQGAl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Dec 2005 01:00:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751017AbVLQGAl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Dec 2005 01:00:41 -0500
Received: from gate.crashing.org ([63.228.1.57]:38092 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1750997AbVLQGAk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Dec 2005 01:00:40 -0500
Subject: Re: [PATCH] UHCI: add missing memory barriers
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Linus Torvalds <torvalds@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.44L0.0512162216580.15902-100000@netrider.rowland.org>
References: <Pine.LNX.4.44L0.0512162216580.15902-100000@netrider.rowland.org>
Content-Type: text/plain
Date: Sat, 17 Dec 2005 16:55:47 +1100
Message-Id: <1134798947.6102.31.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Looking at the PCI code, I see that the accesses are protected by a 
> spinlock.  Does that guarantee in-order execution of writes to 
> configuration space with respect to writes to regular memory?  On all 
> platforms?  If yes, then this barrier is not needed.

Hrm... there is a wmb in the unlock path, I suppose on all platforms,
and iirc, ppc & ppc64 implementation of config space accesses do a full
sync. On x86, they are IO ports, thus I would expect them to be fully
sychronous, but I can't guarantee that semantic is respected accross all
architectures.


