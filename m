Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262259AbTFOOTQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 10:19:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262261AbTFOOTQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 10:19:16 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:28913 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262259AbTFOOTO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 10:19:14 -0400
Importance: Normal
Sensitivity: 
Subject: Re: e1000 performance hack for ppc64 (Power4)
To: Anton Blanchard <anton@samba.org>
Cc: "Feldman, Scott" <scott.feldman@intel.com>,
       "David S. Miller" <davem@redhat.com>, haveblue@us.ibm.com,
       dwg@au1.ibm.com, linux-kernel@vger.kernel.org,
       "Nancy J Milliner" <milliner@us.ibm.com>,
       "Ricardo C Gonzalez" <ricardoz@us.ibm.com>,
       "Brian Twichell" <twichell@us.ibm.com>, netdev@oss.sgi.com
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OF00A6394D.D41D5DDC-ON85256D46.004F9DFD@pok.ibm.com>
From: "Herman Dierks" <hdierks@us.ibm.com>
Date: Sun, 15 Jun 2003 09:32:34 -0500
X-MIMETrack: Serialize by Router on D01ML065/01/M/IBM(Release 5.0.11 +SPRs MIAS5EXFG4, MIAS5AUFPV
 and DHAG4Y6R7W, MATTEST |November 8th, 2002) at 06/15/2003 10:32:44 AM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Anton, I think the option described below is intended to cause the adapter
to "get off on a cache line boundary" so when it restarts the DMA it will
be aligned.   This is for cases when the adapter has to get off, for exampe
due to FIFO full, etc.
Some adapters would get off on any boundary and that then causes perf
issues when the DMA is restarted.
This is a good option, but I don't think it addresses what we need here as
the host needs to ensure a DMA starts on a cache line.
Different adapter anyway, but  I am just pointing out that even if e1000
had this it would not be the solution.


Anton Blanchard <anton@samba.org> on 06/13/2003 07:03:42 PM

To:    "Feldman, Scott" <scott.feldman@intel.com>
cc:    "David S. Miller" <davem@redhat.com>,
       haveblue@us.ltcfwd.linux.ibm.com, Herman Dierks/Austin/IBM@IBMUS,
       dwg@au1.ibm.com, linux-kernel@vger.kernel.org, Nancy J
       Milliner/Austin/IBM@IBMUS, Ricardo C Gonzalez/Austin/IBM@ibmus,
       Brian Twichell/Austin/IBM@IBMUS, netdev@oss.sgi.com
Subject:    Re: e1000 performance hack for ppc64 (Power4)




> I thought the answer was no, so I double checked with a couple of
> hardware guys, and the answer is still no.

Hi Scott,

Thats a pity, the e100 docs on sourceforge show it can do what we want,
it would be nice if e1000 had this feature too :)

4.2.2 Read Align

The Read Align feature is aimed to enhance performance in cache line
oriented systems. Starting a PCI transaction in these systems on a
non-cache line aligned address may result in low  performance. To solve
this performance problem, the controller can be configured to terminate
Transmit DMA cycles on a cache line boundary, and start the next
transaction on a cache line aligned address. This  feature is enabled
when the Read Align Enable bit is set in device Configure command
(Section 6.4.2.3, "Configure (010b)").

If this bit is set, the device operates as follows:

* When the device is close to running out of resources on the Transmit
* DMA (in other words, the Transmit FIFO is almost full), it attempts to
* terminate the read transaction on the nearest cache line boundary when
* possible.

* When the arbitration counters feature is enabled (maximum Transmit DMA
* byte count value is set in configuration space), the device switches
 * to other pending DMAs on cache line boundary only.




