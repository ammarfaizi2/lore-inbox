Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932132AbWFAJUr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932132AbWFAJUr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 05:20:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932169AbWFAJUr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 05:20:47 -0400
Received: from weber.sscnet.ucla.edu ([128.97.42.3]:15502 "EHLO
	weber.sscnet.ucla.edu") by vger.kernel.org with ESMTP
	id S932132AbWFAJUq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 05:20:46 -0400
Message-ID: <447EB0DC.4040203@cogweb.net>
Date: Thu, 01 Jun 2006 02:18:20 -0700
From: David Liontooth <liontooth@cogweb.net>
User-Agent: Thunderbird 1.5.0.2 (X11/20060517)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: USB devices fail unnecessarily on unpowered hubs
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Starting with 2.6.16, some USB devices fail unnecessarily on unpowered
hubs. Alan Stern explains,

"The idea is that the kernel now keeps track of USB power budgets.  When a 
bus-powered device requires more current than its upstream hub is capable 
of providing, the kernel will not configure it.

Computers' USB ports are capable of providing a full 500 mA, so devices
plugged directly into the computer will work okay.  However unpowered hubs
can provide only 100 mA to each port.  Some devices require (or claim they
require) more current than that.  As a result, they don't get configured
when plugged into an unpowered hub."

http://www.mail-archive.com/linux-usb-devel@lists.sourceforge.net/msg43480.html

This is generating a lot of grief and appears to be unnecessarily
strict. Common USB sticks with a MaxPower value just above 100mA, for
instance, typically work fine on unpowered hubs supplying 100mA.

Is a more user-friendly solution possible? Could the shortfall
information be passed to udev, which would allow rules to be written per
device?

David






