Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262180AbULMA1u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262180AbULMA1u (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Dec 2004 19:27:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262181AbULMA1u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Dec 2004 19:27:50 -0500
Received: from mail-relay-3.tiscali.it ([213.205.33.43]:14241 "EHLO
	mail-relay-3.tiscali.it") by vger.kernel.org with ESMTP
	id S262180AbULMA1t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Dec 2004 19:27:49 -0500
Date: Mon, 13 Dec 2004 01:27:51 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Con Kolivas <kernel@kolivas.org>
Cc: Pavel Machek <pavel@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: dynamic-hz
Message-ID: <20041213002751.GP16322@dualathlon.random>
References: <20041211142317.GF16322@dualathlon.random> <20041212163547.GB6286@elf.ucw.cz> <20041212222312.GN16322@dualathlon.random> <41BCD5F3.80401@kolivas.org> <20041212234331.GO16322@dualathlon.random> <cone.1102897095.171542.10669.502@pc.kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cone.1102897095.171542.10669.502@pc.kolivas.org>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2004 at 11:18:15AM +1100, Con Kolivas wrote:
> Thanks. I have to admit that the real reason I wrote this email was for 
> this discussion to go on record so that desktop users would not get 
> inappropriately excited by this change.

Sure, desktop doesn't need this, the reason somebody is asking for it,
is that the desktop stuff hurted some other non-desktop usages. Infact
my 2.4 tree was setting by default HZ=1000 if 'desktop' paramter was
passed to the kernel (so that I could lower the timeslice accordingly
too, without losing the effect of the nicelevels between nice 0 and
+19).

The other new case where I'm asked for this feature is again not the
desktop but the high end laptop with cpu throttling down to 80mhz, and
what Pavel mentioned about the lower consumption. Perhaps we could do
variable HZ there, though I doubt it has a pit that can be reprogrammed
with sane performance.

Very few people are going to get real benefit from HZ=1000, but
I certainly agree it worth to keep HZ=1000 on desktops since on a idle
machine the downside of the more frequent irq sure isn't measurable,
while having shorter timeslices may be visible with many tasks, and
shorter timeslices requires faster HZ to preserve the nicelevels.
