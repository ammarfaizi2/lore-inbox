Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264063AbTEOUyx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 16:54:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264098AbTEOUyx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 16:54:53 -0400
Received: from ida.rowland.org ([192.131.102.52]:6148 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S264063AbTEOUyw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 16:54:52 -0400
Date: Thu, 15 May 2003 17:07:42 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Paul Fulghum <paulkf@microgate.com>
cc: Greg KH <greg@kroah.com>, Andrew Morton <akpm@digeo.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Arnd Bergmann <arnd@arndb.de>, <johannes@erdfelt.com>,
       USB development list <linux-usb-devel@lists.sourceforge.net>
Subject: Re: Test Patch: 2.5.69 Interrupt Latency
In-Reply-To: <1053007957.2025.23.camel@diemos>
Message-ID: <Pine.LNX.4.44L0.0305151706350.1125-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 15 May 2003, Paul Fulghum wrote:

> I have a question about the wakeup_hc() code in general:
> 
> when waking in response to a resume event,
> the current code sets the USBCMD_FGR (force global resume)
> and USBCMD_EGSM (enter global suspend mode) bits,
> waits 20ms and clears both bits to start sending EOP signal.
> 
> According to the datasheet, the controller itself
> (not software) sets the FGR bit on detection of
> a resume event. 20ms after the USBSTS_RD indication,
> software should clear both the FGR and EGSM bits.
> 
> My reading of this is that the line:
> 
> outw(USBCMD_FGR | USBCMD_EGSM, io_addr + USBCMD);
> 
> before the 20ms wait should not be necessary.
> 
> Am I reading this correctly?

I interpret it the same way as you.  I tried removing that line from the 
driver, and it continued to work just fine.  So it looks like you are 
right.

Alan Stern

