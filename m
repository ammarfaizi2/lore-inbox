Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964873AbVLITyw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964873AbVLITyw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 14:54:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932423AbVLITyw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 14:54:52 -0500
Received: from atlrel6.hp.com ([156.153.255.205]:49318 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S932424AbVLITyv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 14:54:51 -0500
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: "Jason Dravet" <dravet@hotmail.com>
Subject: Re: wrong number of serial port detected
Date: Fri, 9 Dec 2005 12:54:44 -0700
User-Agent: KMail/1.8.2
Cc: rmk+lkml@arm.linux.org.uk, linux-kernel@vger.kernel.org
References: <BAY103-F33F72FF201DD9A0728D2EBDF450@phx.gbl>
In-Reply-To: <BAY103-F33F72FF201DD9A0728D2EBDF450@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512091254.44770.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 09 December 2005 7:37 am, Jason Dravet wrote:
> The question I have 
> is with all of this plug and play stuff in our PCs shouldn't it be possible 
> to get the correct number of ports, ask the bios or the pci bus or 
> something?

Yes.  ACPI (or even PNPBIOS) should tell us about all the "legacy"
ports, and PCI or other bus enumeration should tell us about all the
rest.

So in theory, if we have some flavor of PNP, we should be able to
ignore all the compiled-in stuff in SERIAL_PORT_DFNS, which is what
leads to the duplicate port detection.  I've considered doing that
(and ia64 already does it), but it would almost certainly break
systems because of BIOS bugs, so I'm not sure it's worth the risk.

Having all the extra /dev/ttyS entries is a little different problem.
That is basically so "setserial /dev/ttySx" can be used to work around
the fact that the serial driver doesn't know about all existing devices.
If it did, setserial should be superfluous.  Maybe there'd be a way to
implement that functionality via sysfs and get rid of the extra
/dev/ttyS entries.  That'd be kind of cool.
