Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030344AbWFUWPE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030344AbWFUWPE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 18:15:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030334AbWFUWPE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 18:15:04 -0400
Received: from aa002msr.fastwebnet.it ([85.18.95.65]:20668 "EHLO
	aa002msr.fastwebnet.it") by vger.kernel.org with ESMTP
	id S1030344AbWFUWPC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 18:15:02 -0400
Date: Thu, 22 Jun 2006 00:14:45 +0200
From: Mattia Dongili <malattia@linux.it>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, pavel@suse.cz, linux-pm@osdl.org
Subject: Re: swsusp regression [Was: 2.6.17-mm1]
Message-ID: <20060621221445.GB3798@inferi.kami.home>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>, pavel@suse.cz, linux-pm@osdl.org
References: <20060621034857.35cfe36f.akpm@osdl.org> <4499BE99.6010508@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4499BE99.6010508@gmail.com>
X-Message-Flag: Cranky? Try Free Software instead!
X-Operating-System: Linux 2.6.17-rc4-mm2-1 i686
X-Editor: Vim http://www.vim.org/
X-Disclaimer: Buh!
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2006 at 11:47:46PM +0159, Jiri Slaby wrote:
> Andrew Morton napsal(a):
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17/2.6.17-mm1/
> 
> [32512.214000] Suspending device usbdev3.2_ep81
> [32512.214040] Suspending device 3-2:1.0
> [32512.214081] wacom 3-2:1.0: no suspend for driver wacom?
> [32512.214128] Suspending device usbdev3.2_ep00
> [32512.214169] Suspending device 3-2
> [32512.214209] suspend_device(): usb_generic_suspend+0x0/0x128() returns -16
> [32512.214319] Could not suspend device 3-2: error -16
> [32512.214361] wacom 3-2:1.0: no resume for driver wacom?
> [32512.242552] Some devices failed to suspend
> 
> Bus 003 Device 002: ID 056a:0011 Wacom Co., Ltd Graphire 2
> 
> Wacom messages are not new, but it now causes not suspending.

me too (again!)

[   95.408000] Suspending device 3-1
[   95.408000] suspend_device(): usb_generic_suspend+0x0/0x144 [usbcore]() returns -16
[   95.408000] Could not suspend device 3-1: error -16
[   95.412000] Some devices failed to suspend
[   95.412000] Restarting tasks... done

rmmod-ing sd_mod usb_storage usbhid uhci_hcd can finally suspend to disk
and resume (s2ram).
usbcore tells it is in use (count=1) and can't remove it.
The device is a memory stick reader.

I have the same problems also with suspend to disk. BTW I can't resume
from disk since 2.6.17-rc5-mm1, but I'll try to be more precise
tomorrow, as it seems removing the usb stuff makes it do some more steps
toward resumimg (eg: with usb modules this laptop immediately reboots
after reading all pages, without them I can reach "resuming device.."
stage).

-- 
mattia
:wq!
