Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262285AbVBVM07@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262285AbVBVM07 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 07:26:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262296AbVBVM07
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 07:26:59 -0500
Received: from pot.isti.cnr.it ([146.48.83.182]:13483 "EHLO pot.isti.cnr.it")
	by vger.kernel.org with ESMTP id S262285AbVBVMZi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 07:25:38 -0500
From: Francesco Potorti` <Potorti@isti.cnr.it>
To: linux-kernel@vger.kernel.org
Subject: martian source message is wrong?
Organization: ISTI-CNR, via Moruzzi 1, I-56124 Pisa, +39-0503153058
X-fingerprint: 4B02 6187 5C03 D6B1 2E31  7666 09DF 2DC9 BE21 6115
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Message-Id: <E1D3Z6e-0008B3-00@pot.isti.cnr.it>
Date: Tue, 22 Feb 2005 13:25:36 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In 2.6.10, in net/ipv4/route.c, this message is printed:

		printk(KERN_WARNING "martian source %u.%u.%u.%u from "
			"%u.%u.%u.%u, on dev %s\n",
			NIPQUAD(daddr), NIPQUAD(saddr), dev->name);

In my opinion, it should be:

!		printk(KERN_WARNING "martian source %u.%u.%u.%u to "
			"%u.%u.%u.%u, on dev %s\n",
!			NIPQUAD(saddr), NIPQUAD(daddr), dev->name);

or, alternatively,

!		printk(KERN_WARNING "martian source to %u.%u.%u.%u from "
			"%u.%u.%u.%u, on dev %s\n",
			NIPQUAD(daddr), NIPQUAD(saddr), dev->name);

As it is written, it is not clear whether the martian source address is
the first or the second one printed.

-- 
Francesco Potortì (ricercatore)        Voice: +39 050 315 3058 (op.2111)
ISTI - Area della ricerca CNR          Fax:   +39 050 313 8091
via G. Moruzzi 1, I-56124 Pisa         Email: Potorti@isti.cnr.it
Web: http://fly.isti.cnr.it/           Key:   fly.isti.cnr.it/public.key
