Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262791AbVCDCOG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262791AbVCDCOG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 21:14:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262804AbVCDCFu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 21:05:50 -0500
Received: from ylpvm01-ext.prodigy.net ([207.115.57.32]:10147 "EHLO
	ylpvm01.prodigy.net") by vger.kernel.org with ESMTP id S262791AbVCDCBm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 21:01:42 -0500
From: David Brownell <david-b@pacbell.net>
To: linux-pm@lists.osdl.org
Subject: Re: [linux-pm] [PATCH] Custom power states for non-ACPI systems
Date: Thu, 3 Mar 2005 18:01:24 -0800
User-Agent: KMail/1.7.1
Cc: Pavel Machek <pavel@ucw.cz>, Todd Poynor <tpoynor@mvista.com>,
       linux-kernel@vger.kernel.org
References: <20050302020306.GA5724@slurryseal.ddns.mvista.com> <422659B1.9090608@mvista.com> <20050303145522.GA3485@openzaurus.ucw.cz>
In-Reply-To: <20050303145522.GA3485@openzaurus.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503031801.25231.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 03 March 2005 6:55 am, Pavel Machek wrote:
> Hi!
> 
> > In most of the cases I'm thinking of, it wouldn't be a user 
> > requesting a state but rather software (say, a cell phone 
> > progressively entering lower power states due to inactivity).  I 
> > haven't noticed a platform with more than 3 low-power modes so far, 
> 
> Are not your power states more like cpu power states?

For System-on-Chip devices it can be a fine line.  Maybe six
of the most important devices (including CPU) are in a low
power state, but some others are still active.


> These are expected to be system states, and sleeping system
> does not take calls, etc...

Pavel, remember that great big "wakeup" shaped hole in the
current PM framework... ?  Even ACPI sleep states support
wakeup mechanisms, although not well under Linux (yet).

One way a sleeping system could take a call is if some
external chip raised a wakeup-enabled IRQ to wake up the
system.  And if going from deep sleep to normal operational
state has a low cost, why shouldn't the system routinely
enter deep sleep instead of going to CPU idle state?

It's certainly the case that connecting the USB device
to a host can un-gate that peripheral's 48 MHz clock and
wake the system up from deep sleep.

- Dave
