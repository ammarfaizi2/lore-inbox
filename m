Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267712AbUHJU3D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267712AbUHJU3D (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 16:29:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267720AbUHJU3D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 16:29:03 -0400
Received: from ylpvm43-ext.prodigy.net ([207.115.57.74]:4767 "EHLO
	ylpvm43.prodigy.net") by vger.kernel.org with ESMTP id S267712AbUHJU21
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 16:28:27 -0400
From: David Brownell <david-b@pacbell.net>
To: Patrick Mochel <mochel@digitalimplant.org>
Subject: Re: [RFC] Fix Device Power Management States
Date: Tue, 10 Aug 2004 12:41:39 -0700
User-Agent: KMail/1.6.2
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@ucw.cz>
References: <Pine.LNX.4.50.0408090311310.30307-100000@monsoon.he.net> <1092098425.14102.69.camel@gaston> <Pine.LNX.4.50.0408092131260.24154-100000@monsoon.he.net>
In-Reply-To: <Pine.LNX.4.50.0408092131260.24154-100000@monsoon.he.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408101241.39720.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 09 August 2004 9:55 pm, Patrick Mochel wrote:
> 
> On Tue, 10 Aug 2004, Benjamin Herrenschmidt wrote:
> 
> 
> > What about partial tree ? We need to suspend childs first and we need to
> > tied PM transition with dev_start/stop (or have some way to indicate the
> > device we want it to auto-resume when it gets a request, or something).
> > We need to work out policy a bit more here I suppose...
> 
> Policy can come later; we have to have a working model first.

Suspending a partial tree is part of the "device power management"
problem ... it's not a policy, and deferring it would punt on one of
the more basic problems.

A policy would be IMO more like "how far should I suspend this",
"can this device wake out of its suspend state", or more interestingly
"how should these devices interact".

So:  "suspend everything using the 48 MHz clock, so we can
enter a deeper system sleep state" would be a kind of policy.
At least so long as those clock relationships don't appear
explicitly in the driver model ... they could be recorded in
device-specific power state descriptors.
 
- Dave
