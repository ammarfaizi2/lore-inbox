Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261521AbVE3GWT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261521AbVE3GWT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 02:22:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261264AbVE3GWS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 02:22:18 -0400
Received: from stark.xeocode.com ([216.58.44.227]:29837 "EHLO
	stark.xeocode.com") by vger.kernel.org with ESMTP id S261521AbVE3GWN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 02:22:13 -0400
To: "Eric D. Mudama" <edmudama@gmail.com>
Cc: Greg Stark <gsstark@mit.edu>, Jens Axboe <axboe@suse.de>,
       Matthias Andree <matthias.andree@gmx.de>, linux-kernel@vger.kernel.org,
       jgarzik@pobox.com
Subject: Re: [PATCH] SATA NCQ support
References: <20050527070353.GL1435@suse.de>
	<20050527131842.GC19161@merlin.emma.line.org>
	<20050527135258.GW1435@suse.de> <429732CE.5010708@gmx.de>
	<20050527145821.GX1435@suse.de> <87oeatxtw4.fsf@stark.xeocode.com>
	<311601c905052921046692cd3e@mail.gmail.com>
In-Reply-To: <311601c905052921046692cd3e@mail.gmail.com>
From: Greg Stark <gsstark@mit.edu>
Organization: The Emacs Conspiracy; member since 1992
Date: 30 May 2005 02:21:56 -0400
Message-ID: <87d5r9xmgr.fsf@stark.xeocode.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


"Eric D. Mudama" <edmudama@gmail.com> writes:

> If used properly, I don't feel write cache "destroys" data integrity,
> you just need to get your power failure tolerance elsewhere.

That doesn't help if your power failure is caused by a failed UPS or a power
supply or other circuit after said "elsewhere" ... People do expect not to
have a simple power event mean having to do a complete restore of their
database from backups.

> ATA has a limitation of 32 tags, so queued write cache off won't beat
> unqueued write cache on in any modern drive.

People earlier were quoting 30-40% gains with NCQ enabled. I assumed those
were with the same drive in otherwise the same configuration, presumably with
write-caching enabled.

Without any form of command queueing write-caching imposes a severe
performance loss, the question is how much of that loss is erased when NCQ is
present.

> The real reason most SCSI drives do so well uncached is they use huge
> magnets with short, stiff actuators, smaller platters, and they spin
> significantly faster.  NCQ certainly helps, but spending more money on
> mechanics makes a significant difference.  Pick up a SCSI drive and an
> ATA drive, you'll feel the SCSI weighs seemingly twice as much.

People do take average seek latency and rotational latency into account when
they post numbers. There's no question faster drives are, well, faster.

People actually tend to report that IDE drives are *faster*. Until they're
told they have to disable write-caching on their IDE drives to get a fair
comparison, then the performance is absolutely abysmal. The interesting thing
is that SCSI drives don't seem to take much of a performance hit from having
write-caching disabled while IDE drives do.

-- 
greg

