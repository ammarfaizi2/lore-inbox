Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262830AbTHURIx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 13:08:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262833AbTHURIx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 13:08:53 -0400
Received: from fw.osdl.org ([65.172.181.6]:11177 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262830AbTHURHx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 13:07:53 -0400
Date: Thu, 21 Aug 2003 10:03:41 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Corey Minyard <cminyard@mvista.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: IPMI fix for panic handling
Message-Id: <20030821100341.5d360819.rddunlap@osdl.org>
In-Reply-To: <3F44F90B.7060101@mvista.com>
References: <3F44C380.3060707@mvista.com>
	<20030821093037.64962c27.rddunlap@osdl.org>
	<3F44F90B.7060101@mvista.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Aug 2003 11:53:31 -0500 Corey Minyard <cminyard@mvista.com> wrote:

| >diff -u -r1.3 Kconfig
| >--- drivers/char/ipmi/Kconfig	28 Mar 2003 05:14:18 -0000	1.3
| >+++ drivers/char/ipmi/Kconfig	19 Aug 2003 14:20:43 -0000
| >@@ -24,6 +24,18 @@
| > 	 generate an IPMI event describing the panic to each interface
| > 	 registered with the message handler.
| > 
| >+config IPMI_PANIC_STRING
| >+	bool 'Generate a OEM events holding the panic string'
| >
| >I can't decode/translate that quoted string...
| >'an OEM event' ??
| >s/holding/containing/ ??
| >
| I'll work on that.  Is the description below good enough?

Yes, I think it is.

| >
| >+	depends on IPMI_PANIC_EVENT
| >+	help
| >+	  When a panic occurs, this will cause the IPMI message handler to
| >+	  generate an IPMI OEM type f0 events holding the IPMB address of the
| >                                       event
| >+	  panic generator (byte 4 of the event), a sequence number for the
| >+	  string (byte 5 of the event) and part of the string (the rest of the
| >+	  event).  Bytes 1, 2, and 3 are the normal usage for an OEM event.
| >+	  You can fetch these events and use the sequence numbers to piece the
| >+	  string together.
| >+
| > config IPMI_DEVICE_INTERFACE
| >        tristate 'Device interface for IPMI'
| >        depends on IPMI_HANDLER

--
~Randy   [mantra:  Always include kernel version.]
"Everything is relative."
