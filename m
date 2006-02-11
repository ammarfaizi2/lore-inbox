Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750843AbWBKXfQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750843AbWBKXfQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Feb 2006 18:35:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750847AbWBKXfQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Feb 2006 18:35:16 -0500
Received: from smtp.osdl.org ([65.172.181.4]:43941 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750843AbWBKXfP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Feb 2006 18:35:15 -0500
Date: Sat, 11 Feb 2006 15:34:25 -0800
From: Andrew Morton <akpm@osdl.org>
To: Martin Hermanowski <lkml@martin.mh57.de>
Cc: linux-kernel@vger.kernel.org, hdaps-devel@lists.sourceforge.net,
       dtor_core@ameritech.net
Subject: Re: 2.6.16-rc2-mm1
Message-Id: <20060211153425.19242f9e.akpm@osdl.org>
In-Reply-To: <20060211222718.GB9020@mh57.de>
References: <20060207220627.345107c3.akpm@osdl.org>
	<20060211203158.GA9020@mh57.de>
	<20060211134142.11c1af44.akpm@osdl.org>
	<20060211222718.GB9020@mh57.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Hermanowski <lkml@martin.mh57.de> wrote:
>
> > 
> > You could try reverting that patch (wget
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc2/2.6.16-rc2-mm1/broken-out/hdaps-convert-to-the-new-platform-device-interface.patch
> > ; patch -p1 -R < hdaps-convert-to-the-new-platform-device-interface.patch) or please test next -mm, let us know?
> 
> This fails:
> ,----[ patch -p1 -R < ../hdaps-convert-to-the-new-platform-device-interface.patch ]
> | patching file drivers/hwmon/hdaps.c
> | Hunk #1 succeeded at 37 (offset 1 line).
> | Hunk #2 succeeded at 63 (offset 1 line).
> | Hunk #3 succeeded at 285 with fuzz 2 (offset 1 line).
> | Hunk #4 FAILED at 321.
> | Hunk #5 FAILED at 340.
> | Hunk #6 succeeded at 474 (offset 1 line).
> | Hunk #7 succeeded at 512 (offset 1 line).
> | Hunk #8 succeeded at 533 (offset 1 line).
> | 2 out of 8 hunks FAILED -- saving rejects to file
> | drivers/hwmon/hdaps.c.rej
> `----
> 
> At hunk 4/5, the patch expects `down_trylock' and `up', while
> `mutex_trylock' and `mutex_unlock' are used in the actual file, I think.

Yes, one of Greg's patches plays with hdaps too. 
gregkh-i2c-hwmon-convert-semaphores-to-mutexes.patch.  Perhaps reverting
that first will get you there.

> I will try next -mm anyway, because although the fsck-errors caused by
> ext3_getblocks are not harmful, they make me nervous ;-)

I haven't heard from Mingming, so unless I feel inspired to roll up the
sleeves and fix it (P=0.002), that won't be fixed in next -mm.

