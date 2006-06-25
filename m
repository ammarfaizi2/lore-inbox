Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932363AbWFYVzT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932363AbWFYVzT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 17:55:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932372AbWFYVzT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 17:55:19 -0400
Received: from nz-out-0102.google.com ([64.233.162.197]:65259 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932363AbWFYVzR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 17:55:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=kyGGsjS2sryBMGzkorxjb9yoTTvNVYGzYHRIrMbmsQscg2MtU8n05cYjl6VZcE3hyAppNuJXBaYR7fa1Sv4w1okK6cfceF7AXP81rkvoIRsqqRb0+F/p/nbvJaMThjAL6/7ft0OmnO/2kbGr4k0RGCzGFx+tJefmquvzQVEjblc=
Message-ID: <787b0d920606251455y748c61c3q4711481c35e3190a@mail.gmail.com>
Date: Sun, 25 Jun 2006 17:55:17 -0400
From: "Albert Cahalan" <acahalan@gmail.com>
To: linux-kernel@vger.kernel.org, andi@rhlx01.fht-esslingen.de,
       hirofumi@mail.parknet.co.jp, rankincj@yahoo.com, jd@disjunkt.com,
       bert.hubert@netherlabs.nl, george@mvista.com
Subject: Re: Linux 2.6.17: PM-Timer bug warning?
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Mohr writes:

> OK, so if I get a nice description of which dual P4 Xeon motherboard
> that was (Dell something?), then I'll make a patch adding
> this chipset's revision + motherboard + LKML link of bug test app
> to the file, and asking for more testers there, too.

I may have some bad news for you.

Vendors hack around this sort of thing via SMM/SMI tricks.
They catch the device access, then execute BIOS code to retry
or delay as needed. So the BIOS version will matter.

I actually saw this with a 2-way Xeon box from Dell a couple years ago.
I don't recall exactly what it was, but the board probably had a few
64-bit and/or PCI-X slots. Reading from one of the clocks would screw
up if you were near the transition. The board would frequently go into
SMM to check on things. When a clock tick was found to be really soon,
the BIOS would set some sort of flag. If you tried to read the clock
while this flag was set, the BIOS would spin until the clock settled.
