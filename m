Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263625AbTLONzQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 08:55:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263636AbTLONzP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 08:55:15 -0500
Received: from xavier.comcen.com.au ([203.23.236.73]:14862 "EHLO
	xavier.etalk.net.au") by vger.kernel.org with ESMTP id S263625AbTLONzI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 08:55:08 -0500
From: Ross Dickson <ross@datscreative.com.au>
Reply-To: ross@datscreative.com.au
Organization: Dat's Creative Pty Ltd
To: recbo@nishanet.com
Subject: Re: Fixes for nforce2 hard lockup, apic, io-apic, udma133 covered
Date: Mon, 15 Dec 2003 23:54:32 +1000
User-Agent: KMail/1.5.1
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312152354.32777.ross@datscreative.com.au>
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<snip>
> I stayed with 600UL 100ndelay just to see if anything 
> breaks with amd XP3000+ and patches with a bios 
> that doesn't crash with nforce2 but needs help from 
> patches on other points(to get edge timer on and 
> to use nmi_watchdog=1 rather than =2). Also hope 
> we get a clue about what Award bios update does 
> that Phoenix does not do so far. 
 
>/usr/src/kernel-source-2.6.0/include/asm-i386/apic.h 
> #define APIC_DEBUG 1 

>...but I don't see any 

>calibrating APIC timer ... 
> ..... CPU clock speed is 2079.0146 MHz. 
> ..... host bus clock speed is 332.0663 MHz. 
> NET: Registered protocol family 16 
> ..APIC TIMER ack delay, reload:20791, safe:20779 
> ..APIC TIMER ack delay, predelay count: 20769 

>etc 

Hi bob, if the award bios has completely stabilised your system then that is
great news and it should make the apic delay patch unnecessary for your system.

The second patch, the io-apic patch is a workaround to enable the 8254 
connection to the io-apic INTIN0 because that is where it appears to be
wired to on nforce2 mobos.

According to Maciej Rozycki it looks like bios lies and says it is wired
to INTIN2 so nothing happens when that is tested first.

Out of curiosity of the 10 lines with predelay count like follows

..APIC TIMER ack delay, predelay count: 20769 

Do any of them exceed your safe count of 20779? and any really close
in value to the reload count of 20791?

On our pheonix bios's we regularly see 2 or 3 of them exceed the safe count
(indication of potential lockup without the patch) often with one of them 
within 4 counts of the reload value (really quick).

Can you also advise if your bios setting of the  "C1 disconnect" is set to on, off,
or auto? - trying to gain a clue as to how award can have disconnect running
and avoid lockups.

Also are you running with DDR333 or DDR400 ram and how many sticks?

I have heard lockups are not supposed to happen at all if the fsb (host bus
clock speed) matches the ddr speed. One of my systems went about 4 hours
(xp2500 333fsb, DDR333) without the apic delay patch on a pheonix bios
before lockup.

So far it appears to be safe with a barton core cpu to read the local apic
timer count register as the v2 apic delay patch does. 

So far I cannot use my v2 apic delay patch for long periods with my throughbred
core XP2200 without hard lockups (pheonix bios, fsb266, DDR400 ram).

Regards
Ross.

