Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265511AbUBIXoa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 18:44:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265479AbUBIXls
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 18:41:48 -0500
Received: from hermes.py.intel.com ([146.152.216.3]:56752 "EHLO
	hermes.py.intel.com") by vger.kernel.org with ESMTP id S265438AbUBIXiI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 18:38:08 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: 2.6.2 crash after network link failure
Date: Mon, 9 Feb 2004 15:37:48 -0800
Message-ID: <C6F5CF431189FA4CBAEC9E7DD5441E0102CBDE6C@orsmsx402.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.2 crash after network link failure
Thread-Index: AcPvXB5YoU0FjfWiRdS9E8hm8U19JwABoHEA
From: "Feldman, Scott" <scott.feldman@intel.com>
To: "David S. Miller" <davem@redhat.com>,
       "Petr Vandrovec" <vandrove@vc.cvut.cz>
Cc: <netdev@oss.sgi.com>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 09 Feb 2004 23:37:49.0510 (UTC) FILETIME=[BA6F5660:01C3EF65]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I think what might be happening is that somehow the TX queue 
> is corrupted if
> e100_config() runs (due to link UP state change) while there 
> are active normal SKB packets on the TX queue.  Or perhaps 
> some TX queue handling locking issue.
> 
> Scott, any ideas?

e100 hardware will continue to process the hardware's Tx queue even
after link is lost, and then cleanup (return skbs) on interrupt.  I
would expect e100 to be holding no Tx skbs when link returned.

Petr, -mm kernel has an updated (and much simpler) e100 driver.  Is this
something you can try?  The switch failure can be simulated by manually
plugging the cable in/out.

-scott
