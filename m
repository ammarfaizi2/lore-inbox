Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264154AbTEOS31 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 14:29:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264156AbTEOS31
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 14:29:27 -0400
Received: from h-68-165-86-241.DLLATX37.covad.net ([68.165.86.241]:53829 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S264154AbTEOS30
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 14:29:26 -0400
Subject: Re: Test Patch: 2.5.69 Interrupt Latency
From: Paul Fulghum <paulkf@microgate.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Greg KH <greg@kroah.com>, Andrew Morton <akpm@digeo.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Arnd Bergmann <arnd@arndb.de>, johannes@erdfelt.com,
       USB development list <linux-usb-devel@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44L0.0305151355290.1139-100000@ida.rowland.org>
References: <Pine.LNX.4.44L0.0305151355290.1139-100000@ida.rowland.org>
Content-Type: text/plain
Organization: 
Message-Id: <1053024026.2095.12.camel@diemos>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 15 May 2003 13:40:26 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-05-15 at 13:11, Alan Stern wrote:
> That sounds like a believable explanation.  My copy of the generic UHCI
> specification does not include the OC port status bits.  I'm guessing from
> your mail they are either bit 10 or bit 11 of the PORTSC registers, can't
> tell which.  Maybe they are an Intel-specific addition?  Or perhaps a more 
> recent version of the spec has more information -- the one I've got is 1.1 
> (March 1996).
> 
> Can you suggest a good way of detecting whether or not a controller is
> part of a PIIX4 chipset, to indicate whether or not the OC bits are valid?  
> Maybe the PCI vendor and product codes will have that information?  I'm
> not sure it's safe to assume that any old host controller will have
> meaningful values there; the spec just says "reserved" and doesn't
> stipulate that they will always read as 0's.

I was originally looking at the 82731FB (PIIX) / 82731SB (PIIX3) datasheet
which does not have over current inputs and has bits 11..10
labelled as reserved (but read value is not specified).

The lspci show the device on the Netserver to be
the 82731AB/EB/MB (PIIX4). This datasheet shows 2 over current
inputs OC[1..0] and defines PORTSC bits:
11 - over current indicator change (1=changed, 0=not changed)
10 - over current indicator state (1=over current, 0=normal)

If bit 10 is set then the documentation says the port is disabled.
Which triggers the erratum and false resume signals.

As you say, the PIIX3 does not specify that the reserved bits
will necessarily read 0, then I guess some other method
is needed to indicate these bits are significant. Or maybe
some other document does specify that the reserved bits
must be zero if not used? The PCI ID should differentiate
between the controllers.

-- 
Paul Fulghum, paulkf@microgate.com
Microgate Corporation, http://www.microgate.com


