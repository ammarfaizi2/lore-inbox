Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131456AbRBNAZ2>; Tue, 13 Feb 2001 19:25:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131406AbRBNAZS>; Tue, 13 Feb 2001 19:25:18 -0500
Received: from gnu.in-berlin.de ([192.109.42.4]:10502 "EHLO gnu.in-berlin.de")
	by vger.kernel.org with ESMTP id <S131456AbRBNAZE>;
	Tue, 13 Feb 2001 19:25:04 -0500
X-Envelope-From: michael.karcher@dpk.berlin.fido.de
Date: Tue, 13 Feb 2001 20:17:04 +0100
From: Michael Karcher <michael.karcher@dpk.berlin.fido.de>
Subject: Crash in request_region while handling kernel parameters
Message-ID: <20010213201704.A319@p9.dpk.berlin.fido.de>
To: linux-kernel@vger.kernel.org
Organization: Welt am Draht - Berlin
X-Gateway: FIDO WAD.in-berlin.de [FIDOGATE 4.4.0]
X-FTN-From: Michael Karcher @ 242:7000/710.9
X-FTN-To: UUCP @ 242:7000/2.0
X-FTN-Tearline: FIDOGATE 4.2.3
X-FTN-Via: FIDOGATE/rfc2ftn 242:7000/710.9, Tue Feb 13 2001 at 20:17:08 CET
X-FTN-Via: 242:7000/710 @20010213.214005 FastEcho 1.46.1 1078
X-FTN-Via: 242:7000/704@fidode @20010213.220454 FastEcho 1.46.1 2212
X-FTN-Via: FIDOGATE/ftntoss 242:7000/2.0, Wed Feb 14 2001 at 01:23:41 CET
X-FTN-Domain: Z242@FidoDE
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello kernel-hackers,

I found a problem with kernel 2.4, that makes the kernel crash at
bootup, for example when using the UMC8672 VLB IDE controller driver.
The problem is in kernel/resource.c. In line 229 some memory for
handling new io-regions is kmalloc()ed. This crashes the computer
before mem_init(), as it seems.
But some drivers, for example the above mentioned one in
drivers/ide/umc8672.c, do already claim i/o ports in their kernel
parameter driven initialization procedures, so they crash the system.

The point to discuss is whether one needs to fix the drivers, to not
request i/o space while handling kernel parameters or to fix the kernel
to allow this behaviour. As I do not read this mailing list, a
currently don't have web access ready, I don't know whether this topic
has already been discussed. Currently I helped myself by just
commenting out the calls for check_region and request_region in the
umc8672.c file, but I know it smells.

Please send me a cc if you think you have a decision how to fix the
crash.

Michael Karcher
