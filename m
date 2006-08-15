Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030331AbWHOOq7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030331AbWHOOq7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 10:46:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030329AbWHOOq7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 10:46:59 -0400
Received: from hera.kernel.org ([140.211.167.34]:14037 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1030324AbWHOOq6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 10:46:58 -0400
From: Len Brown <len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
To: Roger Heflin <rheflin@atipa.com>
Subject: Re: What determines which interrupts are shared under Linux?
Date: Tue, 15 Aug 2006 10:47:43 -0400
User-Agent: KMail/1.8.2
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org
References: <44E1D760.6070600@atipa.com>
In-Reply-To: <44E1D760.6070600@atipa.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200608151047.44255.len.brown@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 15 August 2006 10:17, Roger Heflin wrote:
>  22:       1165    1704243     576247       6796   IO-APIC-level  ide2,  ide3

The first thing that determines interrupt sharing is where the physical wires from
the devices are routed.  If these ide controllers are add-on boards, then you
could try moving them between PCI slots -- as the slots generally have different
primary interrupt lines.  When the board runs out of unique lines,
they are generally wired to re-use lines on different slots.
The manual for the board will generally tell you how the lines
are routed.

If the devices are using the same physical interrupt line, then it
is not possible for software or BIOS to move them to different
lines.

If these devices are functions in the same device, it is possible
that there is some internal (BIOS or firmware) setting to tell it to
use two interrupt wires instead of one.

Once the wire for the device is determined, it is up to the BIOS
and the OS to program (or not) an interrupt router to assign
the wire to an interrupt input pin.  Your dmesg will tell us
if this is happening on this board.

-Len
