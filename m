Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261624AbTFJW5W (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 18:57:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261568AbTFJW5W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 18:57:22 -0400
Received: from fmr01.intel.com ([192.55.52.18]:38094 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id S261741AbTFJW5U convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 18:57:20 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: 2.4.20 Modprobe setting of eth0,eth1 does not seem to work
Date: Tue, 10 Jun 2003 16:11:00 -0700
Message-ID: <E3A930D59AFC3345AEBA35189102A8A619320E@orsmsx404.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.4.20 Modprobe setting of eth0,eth1 does not seem to work
Thread-Index: AcMsenjK9YAGVTRuSpKfoY52CZhgIQDKDMpw
From: "Leech, Christopher" <christopher.leech@intel.com>
To: <jmerkey@s1.uscreditbank.com>, <linux-kernel@vger.kernel.org>
Cc: <jmerkey@utah-nac.org>
X-OriginalArrivalTime: 10 Jun 2003 23:11:01.0195 (UTC) FILETIME=[8F02F1B0:01C32FA5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff,

It looks like you're following instructions from an old document about
working with ISA network drivers.  Modern PCI drivers can safely probe
for devices, do not need manual IRQ settings, and do not require loading
multiple copies of the driver.  The various "option ethX -o e1000-X"
lines in your modules.conf are not needed, as loading e1000 once will
find all supported devices and register all of your eth interfaces.
Also e1000 does not recognize either the io or irq parameters, so those
settings do nothing.

If you need force specific assignments of interface names to network
devices, the best way to do it is to map names to MAC addresses.  The
tool used to rename network interfaces is nameif, and a document
describing it's use can be found at
http://www.xenotime.net/linux/doc/network-interface-names.txt

- Chris

> -----Original Message-----
> From: jmerkey@s1.uscreditbank.com 
> [mailto:jmerkey@s1.uscreditbank.com] 
> Sent: Friday, June 06, 2003 2:40 PM
> To: linux-kernel@vger.kernel.org
> Cc: jmerkey@utah-nac.org
> Subject: 2.4.20 Modprobe setting of eth0,eth1 does not seem to work
> 
> In 2.4.20 if I attempt to use the Intel multiport e1000 drivers with 
> modules.conf trying to hard set the eth0,eth1, etc. 
> assignments modprobe does
> not appear to be assigning the adapter aliases correctly.  I 
> am assuming
> this may be due to an interface issue between the Keyboard 
> and monitor. :-)
> 
> Modules.conf file attached.  Anyone got any ideas here?
> 
> Jeff
