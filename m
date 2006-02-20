Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932437AbWBTLCZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932437AbWBTLCZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 06:02:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932436AbWBTLCZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 06:02:25 -0500
Received: from [217.147.92.49] ([217.147.92.49]:36304 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S932285AbWBTLCY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 06:02:24 -0500
Date: Mon, 20 Feb 2006 11:01:45 +0000
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Jaya Kumar <jayakumar.acpi@gmail.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.15.3 1/1] ACPI: Atlas ACPI driver
Message-ID: <20060220110145.GB4489@srcf.ucam.org>
References: <200602200213.k1K2DrDW013988@ns1.clipsalportal.com> <20060220102639.GA4342@srcf.ucam.org> <756b48450602200249k1b79b108u42bfef68e1e9dba8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <756b48450602200249k1b79b108u42bfef68e1e9dba8@mail.gmail.com>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
X-SA-Exim-Scanned: No (on vavatch.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2006 at 06:49:54PM +0800, Jaya Kumar wrote:

> I'm not sure how standard that is. For example, I looked at the asus
> and toshiba drivers. These ACPI board drivers use
> /proc/acpi/somedevice/lcd. For example,

And, from a userspace perspective, it sucks. I'm in the process of 
writing patches to transition them all over, and I'd prefer not to have 
to write one for your driver as well :)

> I'll go take a look at that. I didn't look for an acpi driver outside
> of the drivers/acpi directory. But if that's the consensus, shouldn't
> someone also mod the toshiba and asus drivers?

I'm doing so.

> Standard wallmount stuff. There's 8 buttons on the one I'm using for
> testing. Vol up/down. Brightness up/down. Then several buttons for
> miscellaneous usage by people who customize the chassis. Most apps for
> this type of board are custom written and tend to just select on
> /proc/acpi/event.

Volume and brightness are things that can easily be exposed through the 
input layer, and if you're running X then it's much easier to handle 
events that come through the input layer than ones which come from 
acpi/events. There's four keycodes for programmable buttons specced (see 
/usr/include/linux/input.h - _PROG1-4), so that would fit quite nicely 
as well.

Doing it via the input layer adds flexibility - it makes it easier for 
non-root uesrspace to handle things, but you can still have a root-level 
daemon that monitors /dev/input/event* and runs commands in response to 
keycodes.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
