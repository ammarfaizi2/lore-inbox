Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272932AbTHEA2e (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 20:28:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272933AbTHEA2e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 20:28:34 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:14217 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S272932AbTHEA2c
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 20:28:32 -0400
Date: Tue, 5 Aug 2003 02:28:10 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: IDE locking problem
In-Reply-To: <1059904692.3514.102.camel@gaston>
Message-ID: <Pine.SOL.4.30.0308050212540.16314-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 3 Aug 2003, Benjamin Herrenschmidt wrote:

> And there's more to it... ide_unregister() doesn't copy hwif->hold from
> old to new hwif causing my hotswap bay to lose it's iops on next plug,
> it doesn't call unregister_device() for neither hwif->gendev nor
> drive[n]->gendev, causing the device model list to be corrupted after
> an unregister, ...

What is a goal of calling init_hwif_data() in ide_unregister()?
I guess it is used mainly to clear hwif->io_ports and hwif->irq.
Therefore even if you are using hwif->hold flag io_ports will be set to
default values, so how do you later find your hwif?

Hmmm... what about not copying anything and calling init_hwif_data()
only if !hwif->hold?

--
Bartlomiej

