Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264097AbUECWKK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264097AbUECWKK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 18:10:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264101AbUECWKJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 18:10:09 -0400
Received: from hqemgate02.nvidia.com ([216.228.112.145]:28433 "EHLO
	hqemgate02.nvidia.com") by vger.kernel.org with ESMTP
	id S264097AbUECWJ4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 18:09:56 -0400
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
Subject: RE: IO-APIC on nforce2 [PATCH] + [PATCH] for nmi_debug=1 + [PATCH] for idle=C1halt, 2.6.5
Date: Mon, 3 May 2004 15:09:46 -0700
Message-ID: <DCB9B7AA2CAB7F418919D7B59EE45BAF49FC2D@mail-sc-6-bk.nvidia.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: IO-APIC on nforce2 [PATCH] + [PATCH] for nmi_debug=1 + [PATCH] for idle=C1halt, 2.6.5
Thread-Index: AcQxT5QB/sB27GGwRZ+TO5ejsxPYeQACfEsA
From: "Allen Martin" <AMartin@nvidia.com>
To: <linux-kernel@vger.kernel.org>
Cc: "Ross Dickson" <ross@datscreative.com.au>,
       "Len Brown" <len.brown@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm happy to be able to make this information public to the Linux
community.  This information has been previously released to BIOS /
board vendors as an appnote, but in the interest of getting a workaround
into the hands of users the quickest we're making it public for possible
inclusion into the Linux kernel.


Problem:
C1 Halt Disconnect problem on nForce2 systems

Description:
A hang is caused when the CPU generates a very fast CONNECT/HALT cycle
sequence.

Workaround:
Set the SYSTEM_IDLE_TIMEOUT to 80 ns. This allows the state-machine and
timer to return to a proper state within 80 ns of the CONNECT and probe
appearing together.

Since the CPU will not issue another HALT within 80 ns of the initial
HALT, the failure condition is avoided.

This will require changing the value for register at bus:0 dev:0 func:0
offset 6c.

Chip   Current Value   New Value
C17       1F0FFF01     1F01FF01
C18D      9F0FFF01     9F01FF01

Northbridge chip version may be determined by reading the PCI revision
ID (offset 8) of the host bridge at bus:0 dev:0 func:0.  C1 or greater
is C18D.

