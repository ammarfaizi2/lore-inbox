Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261686AbULBR5H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261686AbULBR5H (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 12:57:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261683AbULBR5G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 12:57:06 -0500
Received: from mail45.messagelabs.com ([140.174.2.179]:59527 "HELO
	mail45.messagelabs.com") by vger.kernel.org with SMTP
	id S261686AbULBR4G convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 12:56:06 -0500
X-VirusChecked: Checked
X-Env-Sender: justin.piszcz@mitretek.org
X-Msg-Ref: server-5.tower-45.messagelabs.com!1102010159!8041089!1
X-StarScan-Version: 5.4.2; banners=-,-,-
X-Originating-IP: [66.10.26.57]
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: swapper: page allocation failure (2.6.10-rc2)
Date: Thu, 2 Dec 2004 12:55:58 -0500
Message-ID: <2E314DE03538984BA5634F12115B3A4E01BC4122@email1.mitretek.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: swapper: page allocation failure (2.6.10-rc2)
Thread-Index: AcTYl6+kLf27tHyoTvWZ5KV+pgXzXgAAFiOg
From: "Piszcz, Justin Michael" <justin.piszcz@mitretek.org>
To: "Stephan van Hienen" <kernel@a2000.nu>, <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I also got it with 2.6.10-rc2; it is a known problem with the e1000
driver and you can try turning off TCP TSO with ethtool or increase the
vm_max_bytes(search mailing list for exact file).

Alternatively, revert to 2.6.8.1.


-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Stephan van
Hienen
Sent: Thursday, December 02, 2004 12:48 PM
To: linux-kernel@vger.kernel.org
Subject: swapper: page allocation failure (2.6.10-rc2)

Today got this error :
(system didn't crash it's still running) :

swapper: page allocation failure. order:0, mode:0x20
  [<c0136b22>] __alloc_pages+0x1b9/0x356
  [<c0136ce4>] __get_free_pages+0x25/0x3f
  [<c013a032>] kmem_getpages+0x21/0xcd
  [<c013ab51>] alloc_slabmgmt+0x55/0x60
  [<c013acf3>] cache_grow+0xca/0x16f
  [<c013ae7a>] cache_alloc_refill+0xe2/0x21b
  [<c013b23c>] __kmalloc+0x73/0x7a
  [<c03594ed>] alloc_skb+0x47/0xe0
  [<c02dc1f0>] e1000_alloc_rx_buffers+0x44/0xe2
  [<c02dbef2>] e1000_clean_rx_irq+0x19c/0x456
  [<c02dbabc>] e1000_clean+0x51/0xcc
  [<c035f92c>] net_rx_action+0x7a/0x103
  [<c011b8d2>] __do_softirq+0xba/0xc9
  [<c010066e>] default_idle+0x0/0x2d
  [<c011b90e>] do_softirq+0x2d/0x2f
  [<c0104b22>] do_IRQ+0x1e/0x24
  [<c0102fea>] common_interrupt+0x1a/0x20
  [<c010066e>] default_idle+0x0/0x2d
  [<c0100698>] default_idle+0x2a/0x2d
  [<c010070c>] cpu_idle+0x37/0x40
  [<c04c28d3>] start_kernel+0x14c/0x165
  [<c04c2337>] unknown_bootoption+0x0/0x1e0


Linux storage.a2000.nu 2.6.10-rc2 #2 SMP Tue Nov 30 21:59:49 CET 2004
i686 
i686 i386 GNU/Linux

]# free
              total       used       free     shared    buffers
cached
Mem:       1034156     979592      54564          0        712
925404
-/+ buffers/cache:      53476     980680
Swap:      2096472        836    2095636
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
