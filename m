Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264203AbTEOTbT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 15:31:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264204AbTEOTbT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 15:31:19 -0400
Received: from h-68-165-86-241.DLLATX37.covad.net ([68.165.86.241]:61000 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S264203AbTEOTbR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 15:31:17 -0400
Subject: Re: Test Patch: 2.5.69 Interrupt Latency
From: Paul Fulghum <paulkf@microgate.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       johannes@erdfelt.com,
       USB development list <linux-usb-devel@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44L0.0305151355290.1139-100000@ida.rowland.org>
References: <Pine.LNX.4.44L0.0305151355290.1139-100000@ida.rowland.org>
Content-Type: text/plain
Organization: 
Message-Id: <1053027740.2095.44.camel@diemos>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 15 May 2003 14:42:22 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-05-15 at 13:11, Alan Stern wrote:
> Maybe they are an Intel-specific addition?  Or perhaps a more 
> recent version of the spec has more information -- the one I've got is 1.1 
> (March 1996).

I can't find any later documents.

> Can you suggest a good way of detecting whether or not a controller is
> part of a PIIX4 chipset, to indicate whether or not the OC bits are valid?

I don't see a generic way to determine the validity of these bits.

I think the PCI ID is the only way:
Vendor ID 8086
Device ID 7112

The erratum is only for the PIIX4, and it is
triggered only when the OC inputs are active,
so limiting the check to that device should
be OK.

Probably the least intrusive thing to do
is to disable suspending the uhci controller
if it is a PIIX4 *and* either port has an
over current condition. This will catch the case
of a functional USB controller that has one
or more real over current conditions and the
case of a deliberately disabled (by hardwiring
the OC inputs) controller. The erratum will
pop up in both cases causing suspend<->wake
thrashing.

-- 
Paul Fulghum, paulkf@microgate.com
Microgate Corporation, http://www.microgate.com


