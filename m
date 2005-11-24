Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030626AbVKXIXH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030626AbVKXIXH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 03:23:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030623AbVKXIXH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 03:23:07 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:32469 "EHLO smtp1-g19.free.fr")
	by vger.kernel.org with ESMTP id S1030625AbVKXIXG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 03:23:06 -0500
From: Duncan Sands <duncan.sands@free.fr>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Subject: Re: speedtch driver, 2.6.14.2
Date: Thu, 24 Nov 2005 09:22:59 +0100
User-Agent: KMail/1.8.3
Cc: linux-kernel@vger.kernel.org
References: <200511232125.25254.s0348365@sms.ed.ac.uk>
In-Reply-To: <200511232125.25254.s0348365@sms.ed.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511240923.01185.duncan.sands@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alistair,

> I recently switched from the userspace speedtouch driver to the in-kernel one. 
> However, on my rev 4.0 Speedtouch 330, I periodically get the message:
> 
> ATM dev 0: error -110 fetching device status

-110 means that it timed out.

> I suspect the source of this "error" is the warning message from speedtch:435:
> 
> 	ret = speedtch_read_status(instance);
> 	if (ret < 0) {
> 		atm_warn(usbatm, "error %d fetching device status\n", ret);
> 		instance->poll_delay = min(2 * instance->poll_delay, MAX_POLL_DELAY);
> 		return;
> 	}
> 
> Tell me if I'm wrong, but I suspect speedtch_check_status() is called 
> periodically to check line status. It may be the case that my modem does not 
> like having its status read when it is sending/receiving data (which it is 
> constantly doing).

Well, I have the same modem, and mine doesn't seem to mind!  So something is
strange.

> Unfortunately the message eventually fills the dmesg ring buffer. My current 
> workaround is to remove the atm_warn() call; everything works fine, but I'm 
> concerned that the modem will not automatically reconnect if the connection 
> drops as a result of the failure from speedtch_read_status().

You can test it by unplugging the phone line, then replugging it.

> Any suggestions for debugging this further? From a quick google I've noticed a 
> recent Fedora bugzilla entry mentioning this same problem.

I'll think about it.

All the best,

Duncan.
