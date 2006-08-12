Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422703AbWHLVF4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422703AbWHLVF4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Aug 2006 17:05:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422699AbWHLVF4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Aug 2006 17:05:56 -0400
Received: from smtp.nildram.co.uk ([195.112.4.54]:41484 "EHLO
	smtp.nildram.co.uk") by vger.kernel.org with ESMTP id S1422694AbWHLVFz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Aug 2006 17:05:55 -0400
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Daniel <damage@rooties.de>
Subject: Re: debug prism wlan
Date: Sat, 12 Aug 2006 22:06:00 +0100
User-Agent: KMail/1.9.4
Cc: linux-kernel@vger.kernel.org
References: <200608122140.44365.damage@rooties.de> <200608122226.26516.damage@rooties.de> <200608122249.33329.damage@rooties.de>
In-Reply-To: <200608122249.33329.damage@rooties.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608122206.00267.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 12 August 2006 23:49, Daniel wrote:
> *grrrr* it is too late on evening (I'm living in germany ;) )...
>
> I also fogot to tell following:
>
> Error for wireless request "Set Frequency" (8B04) :
>     SET failed on device eth2 ; Input/output error.
>
> I got this message if I try to start the net device with the init.d script.
> If I try to set the channel per hand I got no error but the channel gets
> not set (it still is 0). But I am able to set the mode and the essid.

Enabling debug would be good. It seems that the driver has protection around 
most of the really low level debugging with:

#if VERBOSE > SHOW_ERROR_MESSAGES
...

If this test passes, a silly DEBUG() wrapper is used to determine whether the 
message should be printed:


islpci_mgt.h:#define DEBUG(f, args...) K_DEBUG(f, pc_debug, args)
islpci_mgt.h:#define K_DEBUG(f, m, args...) \
	do { \
		if(f & m) printk(KERN_DEBUG args); \
	} while(0)

Currently the driver has:

islpci_mgt.h:#define VERBOSE                                 0x01
islpci_mgt.h:#define SHOW_ERROR_MESSAGES                     0x01

So I think you'll need to:

a) Hack islpci_mgt.h and change VERBOSE to 0x02 (or any number higher).
b) Insert the module with pc_debug=1

Then you should get debugging messages, since (0x01 & 0x01) will trigger the 
debugging.

-- 
Cheers,
Alistair.

Final year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
