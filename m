Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264952AbUELC5f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264952AbUELC5f (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 22:57:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264959AbUELC5f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 22:57:35 -0400
Received: from host213-123-250-229.in-addr.btopenworld.com ([213.123.250.229]:26413
	"EHLO 2003SERVER.sbs2003.local") by vger.kernel.org with ESMTP
	id S264952AbUELC5d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 22:57:33 -0400
thread-index: AcQ3zVJGIqBQVqfZRo2YKh1PZb6wCw==
X-Sieve: Server Sieve 2.2
From: <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: <Administrator@vger.kernel.org>
Message-ID: <000101c437cd$52469fc0$d100000a@sbs2003.local>
Cc: <akpm@osdl.org>, <benh@kernel.crashing.org>,
       <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: [PATCH 1/2] PPC32: New OCP core support 
In-Reply-To: Your message of "Tue, 11 May 2004 17:01:50 PDT."             <20040511170150.A4743@home.com> 
References: <20040511170150.A4743@home.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Date: Wed, 12 May 2004 04:00:46 +0100
Content-Type: text/plain;
	charset="us-ascii"
X-Mailing-List: <linuxppc-dev@lists.linuxppc.org>
X-Loop: linuxppc-dev@lists.linuxppc.org
Envelope-to: paul@sumlocktest.fsnet.co.uk
Content-Class: urn:content-classes:message
X-me-spamlevel: not-spam
Importance: normal
X-me-spamrating: 17.233441
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.132
X-OriginalArrivalTime: 12 May 2004 03:00:46.0171 (UTC) FILETIME=[524B5AB0:01C437CD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 11 May 2004 17:01:50 PDT, Matt Porter said:
> New OCP infrastructure ported from 2.4 along with several
> enhancements. Please apply.

Big honking patch. Wholesale removal of old code. Wholesale addition of
new code.

And this is the closest to a hint of what an OCP in the old code:

- * @device: OCP device such as PCI, GPT, UART, OPB, IIC, GPIO, EMAC, ZMII
- * @dev_num: ocp device number whos paddr you want

And in the new:

+extern struct ocp_def core_ocp[];	/* Static list of devices, provided by
+					   CPU core */

And some vendor IDs that say that IBM and FreeScale make them, and Motorola
apparently rebadges/clones Freescale's (or vice versa)..

I'm *guessing* that this is some all-in-one integrated
north/south/PCI/east bridge with an APIC or similar and some I/O
controllers.... Or maybe it's a board-level designator like 'ebony'
seems to be.. or something..

It's a UART... or a Bus-level board.. or both.. ;)

arch/ppc/Kconfig says this:
config OCP
        bool
        depends on IBM_OCP
        default y
that leads to arch/ppc/platforms/4xx/Kconfig:
config IBM_OCP
        bool
        depends on ASH || CPCI405 || EBONY || EP405 || OCOTEA || REDWOOD_5 || REDWOOD_6 || SYCAMOR
E || WALNUT
        default y

Grepping for OCP in arch/ppc/platforms/4xx/* isn't informative either..

Color me mystified.. ;)

(Actually, other than the apparent lack of any comment that says what
an OCP in fact is, I didn't see any really big style problems while
scrolling through it..)

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/


