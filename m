Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268415AbUHXWHE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268415AbUHXWHE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 18:07:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268435AbUHXWF7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 18:05:59 -0400
Received: from atlrel8.hp.com ([156.153.255.206]:46293 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S268365AbUHXV7B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 17:59:01 -0400
Subject: Re: [BK PATCH] I2C update for 2.6.8-rc1
From: Alex Williamson <alex.williamson@hp.com>
To: Greg KH <greg@kroah.com>
Cc: torvalds@osdl.org, akpm@osdl.org,
       linux-kernel <linux-kernel@vger.kernel.org>,
       sensors@Stimpy.netroedge.com
In-Reply-To: <20040715000527.GA18923@kroah.com>
References: <20040715000527.GA18923@kroah.com>
Content-Type: text/plain
Organization: LOSL
Date: Tue, 24 Aug 2004 15:58:42 -0600
Message-Id: <1093384722.8445.10.camel@tdi>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.93 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-07-14 at 17:05 -0700, Greg KH wrote:

> <orange:fobie.net>:
>   o I2C: patch quirks.c - SMBus hidden on hp laptop

   This particular patch, along w/ the new 20040715 ACPI drop has made
my nc6000 laptop unusable.  The problem is we're exposing a device that
firmware considers hidden.  The new motherboard driver in ACPI goes out
and tries to claim resources to prevent them from being stepped on.  It
rightfully considers the hidden SMBus device a motherboard resource.
The PCI code then stumbles onto this device, sees that the BAR it's
using is unavailable and moves it somewhere else in the address space.
At this point, I lose two for the three thermal zones on the laptop
because the AML that deals with them assumes they haven't moved.

   I'm not sure what the point on un-hiding this devices it.  ACPI sets
up an OpRegion to access this device and should have exclusive access to
that region.  Letting a sensor driver poke at it may be fun, but I'd
rather not fry my laptop.  Can we drop the un-hiding of the SMBus for
this laptop (probably the nc8000 too), or is there some way to make the
ACPI motherboard driver and this quirk live together?  Thanks,

	Alex

-- 
Alex Williamson                             HP Linux & Open Source Lab

