Return-Path: <linux-kernel-owner+w=401wt.eu-S1161103AbWLUOjI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161103AbWLUOjI (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 09:39:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965154AbWLUOjI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 09:39:08 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:8410 "EHLO
	pd5mo3so.prod.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965144AbWLUOjH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 09:39:07 -0500
Date: Thu, 21 Dec 2006 08:36:39 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: [PATCH] Unbreak MSI on ATI devices
In-reply-to: <fa.yZrxrHh1AWLcv/+D2xYZ1VhVYb8@ifi.uio.no>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Petr Vandrovec <petr@vandrovec.name>, jeff@garzik.org
Message-id: <458A9BF7.6030303@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <fa.yZrxrHh1AWLcv/+D2xYZ1VhVYb8@ifi.uio.no>
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Petr Vandrovec wrote:
> Hello Jeff,
>   I'm using second patch below for couple of months to get MSI on all
> devices present on my notebook which are MSI capable (except IDE - notebook
> uses IDE in legacy mode and seems unhappy with transition to native MSI-based
> mode; maybe I could try do the job with libata now when I switched; and VGA, I 
> do not use dri...).  All worked nicely until last sync, when I noticed that my 
> USB devices suddenly stopped working (it took me few weeks as I do not use USB
> regulary). 
> 
> After poking around I've found that problem is that at least ATI USB-HCDs
> apply INTX enable even for MSI, despite warning in the PCI specification that
> it should apply only to MSI (actually I have feeling that on these USB devices 
> disabling INTX in MSI mode drives their INTA# line active as when ohci1394 
> module got loaded kernel complained about interrupt being continuously 
> activated for no good reason (TI's 7421 is one of few MSI-incapable devices
> in my box).
> 
> So my question is - what is real reason for disabling INTX when in MSI mode?
> According to PCI spec it should not be needed, and it hurts at least chips
> listed below:
> 
> 00:13.0 0c03: 1002:4374 USB Controller: ATI Technologies Inc IXP SB400 USB Host Controller
> 00:13.1 0c03: 1002:4375 USB Controller: ATI Technologies Inc IXP SB400 USB Host Controller
> 00:13.2 0c03: 1002:4373 USB Controller: ATI Technologies Inc IXP SB400 USB2 Host Controller 
> 
> I believe that these devices from same vendor accept disabling INTX while in MSI
> fine (I did not notice problems with them even with INTX disabling code in msi.c):
> 
> 00:14.5 0401: 1002:4370 (rev 02) Multimedia audio controller: ATI Technologies Inc IXP SB400 AC'97 Audio Controller (rev 02)
> 00:14.6 0703: 1002:4378 (rev 02) Modem: ATI Technologies Inc ATI SB400 - AC'97 Modem Controller (rev 02)
> 
> None of devices in the box assert INTX while in MSI even if INTX is enabled.
> 
> 
> So I'd like to see first patch below accepted.  If there are some devices which
> require INTX disabling, then apparently decision whether to disable it or no
> has to be moved to device drivers, or some blacklist/whitelist must be created...

Linus' original position on this issue was that any devices which broke 
from disabling INTX when going into MSI mode were just broken and we 
should blacklist MSI entirely for these devices. The reason this change 
went in is that some devices don't automatically disable INTX when MSI 
is turned on (somewhat contrary to the PCI spec apparently).

This whole issue might need to be reopened though..

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

