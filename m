Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263106AbTKZAXX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 19:23:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263221AbTKZAXX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 19:23:23 -0500
Received: from hera.cwi.nl ([192.16.191.8]:57535 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S263106AbTKZAXW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 19:23:22 -0500
From: Andries.Brouwer@cwi.nl
Date: Wed, 26 Nov 2003 01:22:33 +0100 (MET)
Message-Id: <UTC200311260022.hAQ0MXB01287.aeb@smtp.cwi.nl>
To: Andries.Brouwer@cwi.nl, jdinardo@nycap.rr.com
Subject: Re: 2.6.0-test10 kernel panic with INVALID GEOMETRY
Cc: B.Zolnierkiewicz@elka.pw.edu.pl, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> disk works fine with 2.3.21.
> doesn't work but is ignored with 2.4.22.
> causes a panic with 2.6.0-test9,test10

> hdd: ,ATA DISK drive
> hdd: 0 sectors (0MB), CHS=0/0/0
> hdd: INVALID GEOMETRY: 0 PHYSICAL HEADS
> ide-default: hdd: Failed to register with ide.c
> Kernel panic: ide: default attach failed

> In the working case the model is
> hdd: ICBSL040AVVA07-0, ATA ...

> In the non-working case all identify data is zero.


OK. So this is not a geometry problem but an I/O problem:
the identify data is not read correctly. When 2.4 sees all
zeros it just ignores this disk. When 2.6 sees all zeros
it panics in ide.c:ata_attach.

You can change the "panic" in
    panic("ide: default attach failed");
(in ide.c:ata_attach) to "printk" and see how far your boot gets.

Do you know why the identify data is not read correctly?
(Or under what circumstances it is read correctly?)

Andries


Probably the panic is too strong a reaction, since it can happen.
