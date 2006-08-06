Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751641AbWHFRHr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751641AbWHFRHr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Aug 2006 13:07:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751581AbWHFRHr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Aug 2006 13:07:47 -0400
Received: from mba.ocn.ne.jp ([210.190.142.172]:5332 "EHLO smtp.mba.ocn.ne.jp")
	by vger.kernel.org with ESMTP id S1751493AbWHFRHq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Aug 2006 13:07:46 -0400
Date: Mon, 07 Aug 2006 02:09:19 +0900 (JST)
Message-Id: <20060807.020919.15248103.anemo@mba.ocn.ne.jp>
To: david-b@pacbell.net
Cc: ab@mycable.de, mgreer@mvista.com, a.zummo@towertech.it,
       linux-kernel@vger.kernel.org
Subject: Re: RTC: add RTC class interface to m41t00 driver
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <200608051213.50308.david-b@pacbell.net>
References: <200608041933.39930.david-b@pacbell.net>
	<20060806.012924.96685417.anemo@mba.ocn.ne.jp>
	<200608051213.50308.david-b@pacbell.net>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 5 Aug 2006 12:13:49 -0700, David Brownell <david-b@pacbell.net> wrote:
> > 1. The driver contains ds_1340 (or st m41t00) definition, but it seems
> >    no way to select the ds_type.
> 
> Which is harmless, since the driver has no code that really needs to care.
> As I said, it's a least-common-denominator driver ... used in my case
> with a SOC that integrates a highly functional (primary) RTC, because
> only the external RTC provides its own battery-backed power domain.

Oh, I missed that point.  It should work for m41t00 indeed.

> This is a limitation of the I2C stack ... one that I observe is being
> worked around by m41t00.c platform_device tricks.  A side effect of those
> tricks is to prevent hooking up more than one of this type I2C chip
> to a system ... not pretty (especially given that it's not documented),
> but often OK.

Yes, some more works would be needed on m41t00 to support multiple
(different) M41Txx chips at same time.

> It would have made more sense to me to have the M41T81 and M41T85 be
> in a different driver, because of the incompatible register layout.
> That's the more traditional approach.

Now I'm thinking this way.  Still thinking...

> My approach was to go for "least common denominator", not "super generic".
> Also, I avoided trying to work around I2C stack issues like the omission
> of per-board tables/customization.  When I2C eventually has a nice clean
> solution for those issues, I expect that will mean adopting the better
> solution involves fewer changes.

OK, I see.  I think LCD approach is worth indeed.

> But I was mostly pointing out that if the goal was to support the m41t00
> RTC (the normal reading of $SUBJECT), that work has been done for some
> time and has already been pushed upstream.

My real target is M41T80, which seems a subset of M41T81.
(Sorry for not writing this before.)

I agree m41t00 can be supported by rtc-ds1307 driver already.

So the next theme would be how we support M41T8x chips.  I think
Alexander's rtc-m41txx is good candidate for them.

Then M41T00 users can choose rtc-ds1307 or rtc-m41t00.  Not so bad, I
think.

---
Atsushi Nemoto
