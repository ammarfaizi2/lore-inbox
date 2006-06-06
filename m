Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932146AbWFFJst@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932146AbWFFJst (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 05:48:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932145AbWFFJst
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 05:48:49 -0400
Received: from server1.meinberg.de ([85.10.202.66]:11723 "EHLO
	paolo.meinberg.de") by vger.kernel.org with ESMTP id S932148AbWFFJss
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 05:48:48 -0400
Message-ID: <44854F74.50406@meinberg.de>
Date: Tue, 06 Jun 2006 11:48:36 +0200
From: Heiko Gerstung <heiko.gerstung@meinberg.de>
Organization: Meinberg Radio Clocks
User-Agent: Thunderbird 1.5.0.2 (X11/20060601)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Backport of a 2.6.x USB driver to 2.4.32 - help needed
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Short Version (tm): I try to backport a USB driver (rtl8150.c) from
2.6.15.x to 2.4.32 and have no idea how to substitue two functions:
in_atomic() and schedule_timeout_uninterruptible() ... I really would
appreciate any help, because I am no kernel hacker at all ...

Long Version (tm):
I have problems backporting a USB driver from 2.6.15.x to 2.4.32 and I
am at a total loss because I am not really a device driver hacker and it
seems that the original author/maintainer is currently very busy and has
no chance to support me in this case (although his support so far was
excellent!).

I still fight with the driver for Realtek 8150 based USB-to-Ethernet
products (drivers/usb/net/rtl8150.c in 2.6.x kernels,
/drivers/usb/rtl8150.c in the 2.4 kernel tree).

Under 2.4.32 this driver crashes (kernel panic) when I try to enslave a
network interface handled by it, with a 2.6 kernel there is no such
problem. Unfortunately I cannot go ahead with a 2.6 kernel at the
moment, because it lacks a properly running PPS support.

I therefore backported the 2.6.x driver to compile cleanly under 2.4.32
and it still crashes when I try to enslave such an interface in miimon
mode. I think there is a difference in the way the bonding module checks
 the MII link status of the device. The maintainer of the driver
modified a few things for me in order to address this problem ("it
happens because get/set_registers() are called with no process
context"), but he was only able to modify the 2.6.x driver for me.

I started to backport the modified version, but it seems that I ran into
dependency hell because I get the following two missing functions
reported when I try to compile the backported module:

rtl8150.c: In Funktion »rtl8150_get_settings«:
rtl8150.c:790: Warnung: implicit declaration of function `in_atomic'
rtl8150.c: In Funktion »rtl8150_thread«:
rtl8150.c:857: Warnung: implicit declaration of function
`schedule_timeout_uninterruptible'

Now I would need help in finding a way to substitute the two missing
functions in a 2.4 kernel environment and I desperately hope that
someone sees my dilemma and can help me somehow...

Anyway, thank you for spending the time to at least read this post (and
thanks a lot if you could spend a few cycles on thinking about a
possible solution!).

Kind regards,
Heiko



-- 
------------------------------------------------------------------------

*MEINBERG Funkuhren GmbH & Co. KG*
Auf der Landwehr 22
D-31812 Bad Pyrmont, Germany
Tel.: ++49 (0)5281 9309-25
Fax: ++49 (0)5281 9309-30
eMail: heiko.gerstung@meinberg.de <mailto:heiko.gerstung@meinberg.de>
Internet: www.meinberg.de <http://www.meinberg.de/>

------------------------------------------------------------------------

Meinberg radio clocks: 25 years of accurate time worldwide

