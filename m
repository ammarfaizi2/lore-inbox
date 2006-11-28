Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757078AbWK1VuA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757078AbWK1VuA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 16:50:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757086AbWK1VuA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 16:50:00 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:205 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1757078AbWK1VuA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 16:50:00 -0500
Date: Tue, 28 Nov 2006 21:56:21 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [rfc PATCH] ieee1394: ohci1394: delete bogus spinlock, flush
 MMIO writes
Message-ID: <20061128215621.2e0ac9a6@localhost.localdomain>
In-Reply-To: <tkrat.9660c0c3e547e1fd@s5r6.in-berlin.de>
References: <tkrat.9660c0c3e547e1fd@s5r6.in-berlin.de>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Nov 2006 22:24:11 +0100 (CET)
Stefan Richter <stefanr@s5r6.in-berlin.de> wrote:

> All MMIO writes which were surrounded by the spinlock as well as the
> very last MMIO write of the IRQ handler are now explicitly flushed by
> MMIO reads of the respective register.

MMIO is ordered anyway on the bus, you just need mmiowb() to force
ordering to the bus controller in case you are on a big numa box.
