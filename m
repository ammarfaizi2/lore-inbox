Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261251AbVCZUik@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261251AbVCZUik (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Mar 2005 15:38:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261254AbVCZUik
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Mar 2005 15:38:40 -0500
Received: from evtexc08.relay.danahertm.com ([129.196.229.155]:55882 "EHLO
	evtexc08.relay.danahertm.com") by vger.kernel.org with ESMTP
	id S261251AbVCZUii (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Mar 2005 15:38:38 -0500
Date: Sat, 26 Mar 2005 12:39:01 -0800 (PST)
From: David Dyck <david.dyck@fluke.com>
To: Adrian Bunk <bunk@stusta.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: unresolved symbols still in 2.4.30-rc2 (usbserial needs symbol
 tty_ldisc_ref and tty_ldisc_deref which are EXPORT_SYMBOL_GPL)
In-Reply-To: <20050326191306.GE3237@stusta.de>
Message-ID: <Pine.LNX.4.62.0503261158220.206@dd.tc.fluke.com>
References: <Pine.LNX.4.62.0503261052050.1495@dd.tc.fluke.com>
 <20050326191306.GE3237@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-OriginalArrivalTime: 26 Mar 2005 20:43:37.0737 (UTC) FILETIME=[7C789790:01C53244]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 Mar 2005 at 20:13 +0100, Adrian Bunk wrote:

> On Sat, Mar 26, 2005 at 10:52:30AM -0800, David Dyck wrote:
>>
>> I've been noticing that I'm still getting some "unresolved symbols"
>> with the 2.4.30 pre and rc series.
>> ...
>> ver_linux reports:
>> ...
>> modutils               2.4.2
>> ...
>
> A modutils upgrade should fix your problems.

Thanks for suggestion - I hadn't noticed that it had slipped out of date.
I took your advice and upgraded to 2.4.27 and rebuild (from clean)
the kernel and modules again.

$ bash scripts/ver_linux
  ...
Linux dd 2.4.30-rc2 #2 Sat Mar 26 11:37:17 PST 2005 i686
  ...
modutils               2.4.27
  ...

I'm still getting unresolved symbol tty_ldisc_ref and tty_ldisc_deref

dd:linux# insmod usbserial
Using /lib/modules/2.4.30-rc2/kernel/drivers/usb/serial/usbserial.o
  ...: unresolved symbol tty_ldisc_ref
  ...: unresolved symbol tty_ldisc_deref

After changing CONFIG_USB, CONFIG_USB_UHCI, and CONFIG_USB_SERIAL
from modules (=m) to built-in (=y) and another clean rebuild
I am able to boot cleanly and load modules that depend on usbserial

I would really like to get usbserial to be a module again
without getting the "unresolved symbols" for 
tty_ldisc_ref and tty_ldisc_deref


