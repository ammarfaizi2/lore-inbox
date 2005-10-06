Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750746AbVJFHGh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750746AbVJFHGh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 03:06:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750745AbVJFHGh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 03:06:37 -0400
Received: from william.parthe.isp.9tel.net ([62.62.156.22]:53677 "EHLO
	william.parthe.isp.9tel.net") by vger.kernel.org with ESMTP
	id S1750746AbVJFHGg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 03:06:36 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: TR : 440bx and natsemi
Date: Thu, 6 Oct 2005 09:06:34 +0200
Message-ID: <8F5DB51133D6B84383761A7F0E399A7E0110A1A5@epicure.suresnes.local>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 440bx and natsemi
Thread-Index: AcXKQ8AvZ9CYCGIGT3q8hQRwAyjmqgAAKu3w
From: =?iso-8859-1?Q?Fr=E9d=E9ric_POTTER?= <fpotter@cirpack.com>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org





    Hi, 

    We have designed an embedded board, based on Celeron ULV 400 Mhz and 440bx chipset.
    The BIOS has been derivated from Linux Bios of the 440mx (mx and bx have minimal differences).
    The ethernet devices are natsemi DP83816 (latest HW revision)

The issue : 
----------------

    If we set the L1 CPU cache in write back mode then, under heavy ethernet load, we have various memory
corruption on the host memory. It looks like, basically, the natsemi device, when getting bus master, is 
accessing former skbuf physicall adresses in the tx_ring structure, and therefore writing at various location
in the memory, generating various kernel panic a few moment later.

    If we set the L1 CPU cache in write through, the issue vanishes completely (even after a few days of heavy
load)..

    Since we have designed this whole system (hardware, BIOS etc..), it may clearly be that we have introduced
a cache coherency issue in the system, but we have checked it all, and it seems like not
    * snooping HW interface is present, correctly wired
    * Intel CPU and chipset seems to be properly configured, and anyway no configuration seems to be present
that would have allowed us to 'disable' cache coherency.
    * No Intel CPU or chipset errata have been found that refers to cache snooping issues.

Does anyone have a clue on this one ? Does someone have a 440bx with a Natsemi device (that may be a rare
configuration BTW, since 440bx is used in laptop where the natsemi is fairly rare) 
Are we just discovering an N+1 Intel issue or did we miss something ?

thanks in advance

fred
