Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263467AbUDGPla (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 11:41:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263612AbUDGPl3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 11:41:29 -0400
Received: from ihemail2.lucent.com ([192.11.222.163]:24993 "EHLO
	ihemail2.firewall.lucent.com") by vger.kernel.org with ESMTP
	id S263467AbUDGPl1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 11:41:27 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16500.8464.842592.784829@gargle.gargle.HOWL>
Date: Wed, 7 Apr 2004 11:41:04 -0400
From: "John Stoffel" <stoffel@lucent.com>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: "John Stoffel" <stoffel@lucent.com>, linux-kernel@vger.kernel.org,
       andre@linux-ide.org
Subject: Re: 2.6.5-rc3: cat /proc/ide/hpt366 kills disk on second channel
In-Reply-To: <200404062302.17698.bzolnier@elka.pw.edu.pl>
References: <16496.41345.341470.807320@gargle.gargle.HOWL>
	<200404061900.36497.bzolnier@elka.pw.edu.pl>
	<16499.3204.604627.205193@gargle.gargle.HOWL>
	<200404062302.17698.bzolnier@elka.pw.edu.pl>
X-Mailer: VM 7.14 under Emacs 20.6.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Bartlomiej" == Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl> writes:

>> I'll also pull this patch forward to 2.6.5 and make sure to submit it
>> to Linus/Andrew, unless you'll do that part?

Bartlomiej> I'll take care of it. :)

Thanks.  I'm going to add your patch into my local 2.6.5 and test it
out, but so far it's been nice and stable.

>> I do wish the cable detection stuff worked though... too bad about the

Bartlomiej> Cable detection works just fine, see init_hwif_hpt366().

Will do.  Mostly, I'm just trying to see if my HPT302 is running a 66,
100, or 133.  Depending on which kernel I boot, I got different
numbers from /proc/ide/hpt366, so I'll see what I can find. 

>> outb() stuff.  Maybe I can poke at it and figure out what kind of
>> locking is required here to make this work right.  Would it need to be
>> queued up as a regular HWIF command?  Can you tell I don't know what
>> I'm talking about?  *grin*

Bartlomiej> regular HWIF command?  It can be fixed using REQ_SPECIAL
Bartlomiej> special request but I don't think it's worth the work -
Bartlomiej> remove #ifdef/#endif DEBUG around printk() in
Bartlomiej> init_hwif_hpt366() if you need info about cable.

God knows what I'm talking about here, but you've given me some good
pointers here, so I'll play around and see what I find.  Thanks again
for your quick work.

Oh yeah, I did a quick audit of the other drivers in drivers/ide/pci
and none of the rest did any outb() or pci_write*() calls in the
various *_get_info() routines, so they rest should be ok now.

Thanks,
John


