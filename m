Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964957AbWJWTqI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964957AbWJWTqI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 15:46:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932160AbWJWTqH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 15:46:07 -0400
Received: from build.arklinux.osuosl.org ([140.211.166.26]:29332 "EHLO
	mail.arklinux.org") by vger.kernel.org with ESMTP id S932129AbWJWTqF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 15:46:05 -0400
From: Bernhard Rosenkraenzer <bero@arklinux.org>
To: David Hollis <dhollis@davehollis.com>
Subject: Re: 2.6.19-rc2-mm2: D-Link DUB-E100 Rev. B broken
Date: Mon, 23 Oct 2006 21:45:23 +0200
User-Agent: KMail/1.9.4
Cc: linux-kernel@vger.kernel.org
References: <200610232041.48998.bero@arklinux.org> <1161630300.4824.7.camel@dhollis-lnx.sunera.com>
In-Reply-To: <1161630300.4824.7.camel@dhollis-lnx.sunera.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610232145.23819.bero@arklinux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, 23. October 2006 21:05, David Hollis wrote:
> > eth0: Failed to enable software MII access
> > eth0: Failed to enable hardware MII access
> > eth0: Failed to write Medium Mode to 0x0334: ffffff92
>
> Hmm, the only change that you may not have is to wrap the MII calls with
> a Mutex, though that isn't likely the culprit here (even though the
> message is talking about MII access).  Could you enable the DEBUG define
> at the top of the driver and see what kind of output you get in dmesg?

It isn't the culprit -- I've looked at it some more and noticed it works 
perfectly on another box with the same kernel (but it works as well on the 
broken box with an older kernel).

Looks like the USB port is acting up (only with the new kernel -- so this is 
probably triggered by a USB driver or possibly APIC change [will try with 
pci=noapic next])

The box where it breaks is an Asus Pundit R-350 barebone with an ATI USB 
controller:
00.13.0 0c03: 1002:4347 (rev 01) (prog-if 10)
	Subsystem: 1043:8108
	Flags: bus master, medium devsel, latency 32, IRQ 17
	Memory at fe800000 (32-bit, non-prefetchable) [size=4K]

The working box has a VIA USB 2.0 controller
00:10.3 0c03: 1106:3104 (rev 82) (prog-if 20)
        Subsystem: 1025:0046
        Flags: bus master, medium devsel, latency 64, IRQ 18
        Memory at d0002800 (32-bit, non-prefetchable) [size=256]
        Capabilities: [80] Power Management version 2
