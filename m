Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264024AbTEOOBl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 10:01:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264028AbTEOOBl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 10:01:41 -0400
Received: from h-68-165-86-241.DLLATX37.covad.net ([68.165.86.241]:11313 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S264024AbTEOOBj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 10:01:39 -0400
Subject: Re: Test Patch: 2.5.69 Interrupt Latency
From: Paul Fulghum <paulkf@microgate.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Greg KH <greg@kroah.com>, Andrew Morton <akpm@digeo.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Arnd Bergmann <arnd@arndb.de>, johannes@erdfelt.com,
       USB development list <linux-usb-devel@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44L0.0305141634070.626-100000@ida.rowland.org>
References: <Pine.LNX.4.44L0.0305141634070.626-100000@ida.rowland.org>
Content-Type: text/plain
Organization: 
Message-Id: <1053007957.2025.23.camel@diemos>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 15 May 2003 09:12:37 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have a question about the wakeup_hc() code in general:

when waking in response to a resume event,
the current code sets the USBCMD_FGR (force global resume)
and USBCMD_EGSM (enter global suspend mode) bits,
waits 20ms and clears both bits to start sending EOP signal.

According to the datasheet, the controller itself
(not software) sets the FGR bit on detection of
a resume event. 20ms after the USBSTS_RD indication,
software should clear both the FGR and EGSM bits.

My reading of this is that the line:

outw(USBCMD_FGR | USBCMD_EGSM, io_addr + USBCMD);

before the 20ms wait should not be necessary.

Am I reading this correctly?

Thanks,
Paul

-- 
Paul Fulghum, paulkf@microgate.com
Microgate Corporation, http://www.microgate.com


