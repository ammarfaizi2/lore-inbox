Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261376AbVC0Abk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261376AbVC0Abk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Mar 2005 19:31:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261377AbVC0Abk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Mar 2005 19:31:40 -0500
Received: from evtexc08.relay.danahertm.com ([129.196.229.155]:36960 "EHLO
	evtexc08.relay.danahertm.com") by vger.kernel.org with ESMTP
	id S261376AbVC0Abh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Mar 2005 19:31:37 -0500
Date: Sat, 26 Mar 2005 16:31:59 -0800 (PST)
From: David Dyck <david.dyck@fluke.com>
To: Adrian Bunk <bunk@stusta.de>
cc: linux-kernel@vger.kernel.org
Subject: upgrading modutils may have fixed: unresolved symbols still in
 2.4.30-rc2 (usbserial needs symbol tty_ldisc_ref and tty_ldisc_deref which
 are EXPORT_SYMBOL_GPL)
In-Reply-To: <Pine.LNX.4.62.0503261158220.206@dd.tc.fluke.com>
Message-ID: <Pine.LNX.4.62.0503261512380.228@dd.tc.fluke.com>
References: <Pine.LNX.4.62.0503261052050.1495@dd.tc.fluke.com>
 <20050326191306.GE3237@stusta.de> <Pine.LNX.4.62.0503261158220.206@dd.tc.fluke.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-OriginalArrivalTime: 27 Mar 2005 00:36:36.0193 (UTC) FILETIME=[0847B510:01C53265]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 Mar 2005 at 12:39 -0800, David Dyck wrote:

> On Sat, 26 Mar 2005 at 20:13 +0100, Adrian Bunk wrote:
>
>> On Sat, Mar 26, 2005 at 10:52:30AM -0800, David Dyck wrote:
>>> 
>>> I've been noticing that I'm still getting some "unresolved symbols"
>>> with the 2.4.30 pre and rc series.
>>> ver_linux reports:
>>> modutils               2.4.2
>> 
>> A modutils upgrade should fix your problems.
>
> I took your advice and upgraded to 2.4.27 and rebuild (from clean)
> the kernel and modules again.
>
> $ bash scripts/ver_linux
> modutils               2.4.27
>
> I'm still getting unresolved symbol tty_ldisc_ref and tty_ldisc_deref
>
> dd:linux# insmod usbserial
> Using /lib/modules/2.4.30-rc2/kernel/drivers/usb/serial/usbserial.o
> ...: unresolved symbol tty_ldisc_ref
> ...: unresolved symbol tty_ldisc_deref

I tried again with 2.4.30-rc3, but this time I changed my .config
file to disable 2 other modules that I didn't need, and wasn't loading.

< CONFIG_USB_UHCI_ALT=m
< CONFIG_USB_STV680=m

and build rc3.  It seems to work, so either my earlier
rc2 test with make clean wasn't clean-enough, or CONFIG_USB_UHCI_ALT
interferes - testing with CONFIG_USB_UHCI_ALT as a module (not loaded)
also works, so since interdiff didn't seem to highlite any difference 
between rc2 and rc3, I'll suspect that my test make clean didn't
clean things up good enough, and the entire problem was as
Adrian Bunk suggest (upgrade modutils, thanks Adrian)

