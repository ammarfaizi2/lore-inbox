Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262798AbVAFJeP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262798AbVAFJeP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 04:34:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262800AbVAFJeO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 04:34:14 -0500
Received: from ylpvm43-ext.prodigy.net ([207.115.57.74]:11400 "EHLO
	ylpvm43.prodigy.net") by vger.kernel.org with ESMTP id S262798AbVAFJbe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 04:31:34 -0500
From: David Brownell <david-b@pacbell.net>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [2.6] Clean up SL811 headers
Date: Thu, 6 Jan 2005 01:31:28 -0800
User-Agent: KMail/1.7.1
Cc: kyle moffett <mrmacman_g4@mac.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501060131.28421.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kyle Moffett said:
> The USB SL811 host has a structure stuck in linux/usb_sl811.h  As this
> structure is kernel private and only used by a single piece of code, 

That's very wrong ... the structure in question is the interface between
the board-specific setup and the driver (as it says in the comment).  A
better way to put the situation is that www.kernel.org doesn't currently
bundle support for a board that wires that chip into its platform_bus.


> this patch moves it to the header file from which it is used, deleting the 
> old one.

Here's a thought experiment for you ... do that for EVERY driver
on the platform_bus, and see how quickly you get a big mess.
Board support packages on 2.4 tended to take that approach;
good riddance, IMO.

When you take that approach, then adding support for a new
board means ** CHANGING EVERY DRIVER USED WITH THAT BOARD **
to know how the chip is set up on that particular board.
IRQs, addressing, CPU and GPIO pin multiplexing, support
logic ... yeech!

Better to have a single arch/XYZ/mach-ZYX/board-ABC.c file that
just sets up the relevant platform devices, and the platform_data
those drivers use.  The board support packages should be small,
mostly using standard drivers ... not be invasive monsters.

- Dave
