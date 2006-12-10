Return-Path: <linux-kernel-owner+w=401wt.eu-S1760487AbWLJIoz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760487AbWLJIoz (ORCPT <rfc822;w@1wt.eu>);
	Sun, 10 Dec 2006 03:44:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760488AbWLJIoz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Dec 2006 03:44:55 -0500
Received: from science.horizon.com ([192.35.100.1]:19391 "HELO
	science.horizon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1760485AbWLJIoy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Dec 2006 03:44:54 -0500
Date: 10 Dec 2006 03:44:53 -0500
Message-ID: <20061210084453.13702.qmail@science.horizon.com>
From: linux@horizon.com
To: linux-kernel@vger.kernel.org
Subject: Re: single bit errors on files stored on USB-HDDs via USB2/usb_storage
Cc: linux@horizon.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

How the wires can cause single-bit errors is a bit beyond me;
USB protects every bit on the wire well enough that communication
errors should be detected.

Every packet starts with an identifier byte; this contains a 4-bit packet
identifier repeated twice.

Some small "token" packets have an 11-bit payload (7 address and 4
endpoint bits) and a 5-bit CRC.

Any corruption of those would result in USB state machine confusion and
at least large data gaps.

Packets with an actual data payload are protected with a CRC-16.
Not quite as strong as Ethernet, but sufficient to detect all errors of
three bits or less, and all burst errors of 16 consecutive bits or less.

A single-bit flip can't get past a CRC-16 unless you flip at least
three bits in the CRC as well.  The actual pattern depends on the bit
position and averages 8 bits; given the documented bit error positions
and a better knowledge of the ATA-over-USB encapsulation protocol,
the actual CRC changes could be computed.


Now, I can imagine a USB slave controller so cheap and/or buggy that it
doesn't check the CRC, but I'd think that most would.  Checking a CRC
is hardly a novel challenge.
