Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269191AbTHLJ6S (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 05:58:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269133AbTHLJ53
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 05:57:29 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:46245
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S268737AbTHLJ5T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 05:57:19 -0400
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: Russell King <rmk@arm.linux.org.uk>,
       "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: [Bug 1068] New: Errors when loading airo module
Date: Tue, 12 Aug 2003 04:46:56 -0400
User-Agent: KMail/1.5
Cc: linux-kernel <linux-kernel@vger.kernel.org>, kernelbugzilla@kuntnet.org
References: <51060000.1060524422@[10.10.2.4]> <20030810163350.D32508@flint.arm.linux.org.uk>
In-Reply-To: <20030810163350.D32508@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308120447.00105.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 10 August 2003 11:33, Russell King wrote:
> On Sun, Aug 10, 2003 at 07:07:02AM -0700, Martin J. Bligh wrote:
> > http://bugme.osdl.org/show_bug.cgi?id=1068
> >
> >            Summary: Errors when loading airo module
> >     Kernel Version: 2.6.0-test3
> >             Status: NEW
> >           Severity: normal
> >              Owner: rmk@arm.linux.org.uk
> >          Submitter: kernelbugzilla@kuntnet.org
>
> This needs to go to the airo maintainers, not me - the oops is caused
> by buggy airo.c.
>
> The IRQ problem is the result of bad configuration - you must enable
> CONFIG_ISA if you're going to use non-Cardbus PCMCIA cards.

Do you mean something like:

--- linux-2.6.0-test3/drivers/pcmcia/Kconfig	2003-08-09 00:39:25.000000000 -0400
+++ temp/drivers/pcmcia/Kconfig	2003-08-12 04:44:03.000000000 -0400
@@ -86,7 +86,7 @@
 
 config PCMCIA_SA1100
 	tristate "SA1100 support"
-	depends on ARM && ARCH_SA1100 && PCMCIA
+	depends on ARM && ARCH_SA1100 && PCMCIA && ISA
 	help
 	  Say Y here to include support for SA11x0-based PCMCIA or CF
 	  sockets, found on HP iPAQs, Yopy, and other StrongARM(R)/
@@ -96,7 +96,7 @@
 
 config PCMCIA_SA1111
 	tristate "SA1111 support"
-	depends on ARM && ARCH_SA1100 && SA1111 && PCMCIA
+	depends on ARM && ARCH_SA1100 && SA1111 && PCMCIA && ISA
 	help
 	  Say Y  here to include support for SA1111-based PCMCIA or CF
 	  sockets, found on the Jornada 720, Graphicsmaster and other

Rob


