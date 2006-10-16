Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161023AbWJPQvA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161023AbWJPQvA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 12:51:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161020AbWJPQvA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 12:51:00 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:59441 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S1161012AbWJPQu7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 12:50:59 -0400
Message-ID: <4533B8FB.5080108@mvista.com>
Date: Mon, 16 Oct 2006 11:53:15 -0500
From: Corey Minyard <cminyard@mvista.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060812)
MIME-Version: 1.0
To: linux-serial@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] Add the ability to layer another driver over the serial driver
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a set of three patches to allow adding another driver on top of
the current serial driver without too much change to the serial code.
This is more for comments right now, it is probably not ready for real
use yet.

The patches are too big to post here, so I'm putting them on
http://home.comcast.net/~minyard

The three patches are:

    * serial-remove-tty-struct-from-driver.patch - A general patch to
      remove the tty includes from the low-level serial drivers. Only
      fixes the 8250 for now.

    * serial-allow-in-kernel-users.patch - The actual patch that adds
      the layered driver to the serial core.

    * serial-8250-cleanup.patch - Add support for the layered driver
      and poll to the 8250 uart.

This is for a serial interface to an IPMI controller.  Note that I
don't really like this very much for a number of reasons, but the IPMI
driver has features that only work in-kernel, like extending the
watchdog timer on a panic to allow kdump to operate without a reboot
and storing panic information in the IPMI event log.  So you really
can't write a userland-only interface for this and keep those
features.

It is also not really possible to add this on top of the tty code
because it has to be able to run at panic time, and the tty code
doesn't have a clean place to interface this from what I could
tell.

-Corey

