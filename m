Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753129AbWKCGDU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753129AbWKCGDU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 01:03:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753132AbWKCGDU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 01:03:20 -0500
Received: from gateway.insightbb.com ([74.128.0.19]:56742 "EHLO
	asav02.insightbb.com") by vger.kernel.org with ESMTP
	id S1753129AbWKCGDT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 01:03:19 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AusRAFhoSkVKhRUUXWdsb2JhbACGCoY1LA
From: Dmitry Torokhov <dtor@insightbb.com>
To: Dave Neuer <mr.fred.smoothie@pobox.com>
Subject: Re: [RFT/PATCH] i8042: remove polling timer (v6)
Date: Fri, 3 Nov 2006 01:03:17 -0500
User-Agent: KMail/1.9.3
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Vojtech Pavlik <vojtech@suse.cz>
References: <200608232311.07599.dtor@insightbb.com> <161717d50610291520i5076901blf8bf253eba6148cc@mail.gmail.com>
In-Reply-To: <161717d50610291520i5076901blf8bf253eba6148cc@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611030103.17913.dtor@insightbb.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 29 October 2006 18:20, Dave Neuer wrote:
> On 8/23/06, Dmitry Torokhov <dtor@insightbb.com> wrote:
> > Hi everyone,
> >
> > Here is another version of the patch removing polling timer from i8042
> > which is needed if we want tickless kernel. Keyboards should now work
> > on boxes that do not have mouse plugged in. PLease give it a test.
> 
>  What's the intent of this; just to allow tickless?

Yes, that was the intent.

>  Or is it also to 
> make the i8042 driver less racy? 

I think we agree that i8042_aux_write() is not racy, do you see any other
races in i8042?

> I ask because I've applied this over 
> (a modified) 2.6.18 on my Compaq Presario X1010us laptop which has
> been driving me crazy w/ Synaptics problems and keyboard problems
> (intermittent, but   frequent enough lately that I finally figured I
> needed to do something about it).
> 

Have you tried limiting Synaptics rate to 40 packets per second (using
psmouse.rate=40 option)? Some KBD can't handle full Synaptics rate of
80 pps; it usually manifests in keyboard troubles.

> 
> I don't really know if or how much the races in this driver are
> contributing to my problems (keyboard getting stuck repeating last
> key, or ignoring interrupts, or synaptics touchpad freezing, last of
> which requires cold boot to fix).

You mean even reloading psmouse module can't revive the touchpad?

> Maybe more likely an ACPI thing? 

Coudl be.

-- 
Dmitry
