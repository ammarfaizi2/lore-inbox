Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266293AbUGQDd3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266293AbUGQDd3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jul 2004 23:33:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266688AbUGQDd3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jul 2004 23:33:29 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:46078 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S266293AbUGQDd2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jul 2004 23:33:28 -0400
Subject: Re: [PATCH] pmac_zilog: insert correct failure path for device
	numbers being taken
From: Albert Cahalan <albert@users.sf.net>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Cc: benh@kernel.crashing.org, eger@havoc.gtf.org, rmk+serial@arm.linux.org.uk
Content-Type: text/plain
Organization: 
Message-Id: <1090026344.1232.412.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 16 Jul 2004 21:05:45 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'll talk to him at KS/OLS and see if we can come up with
> some solution, this is actually a regression since 2.4
> could "offset" macserial, so we could accomodate, for
> example, a driver for a pcmcia modem _and_ the zilog ports.

That's the wrong way around. The zilog ports are always
there, and thus could have stable numbers. The PCMCIA
ports can not have stable numbers; they might be gone even.

In general, the platform-specific (motherboard, generally)
ports should get to grab device numbers first. Anthing
connected by a normally hot-plug bus goes last. Plain PCI
is in the middle, because PCI cards are occasionally moved.

For a PC, serial ports hanging off the motherboard's LPC bus
(what amounts to built-in ISA) should go before serial ports
that might be on normal PCI cards, which in turn go before
those on PCMCIA.


