Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263357AbTKQGZZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 01:25:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263364AbTKQGZZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 01:25:25 -0500
Received: from fmr02.intel.com ([192.55.52.25]:49894 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id S263357AbTKQGZY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 01:25:24 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: Yet another UDP pmtud iss, it's different, really
Date: Sun, 16 Nov 2003 22:25:08 -0800
Message-ID: <7E713DB94F47914DB5AAB80DE8EEA875015398BE@fmsmsx410.fm.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Yet another UDP pmtud iss, it's different, really
Thread-Index: AcOrFhfE3N/A09UoQnmuk+bmA9PDVgBvPrSw
From: "Johnson, Chester F" <chester.f.johnson@intel.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 17 Nov 2003 06:25:09.0163 (UTC) FILETIME=[8C7DAFB0:01C3ACD3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

List,

This is not the same as the pmtud issues discussed ad-nauseum from 1999
through 2001. It really is different. Trust me, please read on.

Well, it is similar, but with a twist. We are in the middle of deploying
DiffServ compliant QoS throughout our networks and stumbled across an
issue that occurs when we configure our routers to mark the DiffServ
Code Points (DSCP) for UDP traffic (AFS, NFS, other full frame size UDP
traffic).

The problem is that when the marked traffic reaches an IPsec/Ethernet
segment, and the DF bit set to true, an ICMP message is returned to the
transmitting host to say basically "fix your MTU". Since we have changed
the ToS field with DSCP information, the ICMP message no longer matches
anything in the route cache hash. If the ToS field is not "0", it must
match src, dst, and ToS in the cache. Well, we changed one of them and
there can be no such match.

The net result is that the transmitting host sends another 1500 byte
packet and the process repeats itself. Ultimately the data transfer
fails. When we stop DSCP marking, MTU negotiation works just fine, but
we have no QoS.

This kind of match might be great if we use a Linux platform as a
router. It may indeed be useful for higher performance DiffServ routing.
This kind of match requirement for an end-host is problematic. In our
estimation it looks like a bug.

Can anyone out there help sort this out?

Chester Johnson
Network Transport Engineering
Intel Corporation

