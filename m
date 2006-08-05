Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161151AbWHEQ1v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161151AbWHEQ1v (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Aug 2006 12:27:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932613AbWHEQ1v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Aug 2006 12:27:51 -0400
Received: from mba.ocn.ne.jp ([210.190.142.172]:48342 "EHLO smtp.mba.ocn.ne.jp")
	by vger.kernel.org with ESMTP id S932418AbWHEQ1v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Aug 2006 12:27:51 -0400
Date: Sun, 06 Aug 2006 01:29:24 +0900 (JST)
Message-Id: <20060806.012924.96685417.anemo@mba.ocn.ne.jp>
To: david-b@pacbell.net
Cc: ab@mycable.de, mgreer@mvista.com, a.zummo@towertech.it,
       linux-kernel@vger.kernel.org
Subject: Re: RTC: add RTC class interface to m41t00 driver
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <200608041933.39930.david-b@pacbell.net>
References: <200608041933.39930.david-b@pacbell.net>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Aug 2006 19:33:39 -0700, David Brownell <david-b@pacbell.net> wrote:
> Actually, it'd be worth trying drivers/rtc/rtc-ds1307.c ... the M41T00 is
> one of a family of mostly-compatible RTC chips, and the ds1307 driver
> should be pretty much the least-common-denominator there.  They all use
> the same I2C address, and the same register layout for the calendar/time
> function.
> 
> I'd expect rtc-ds1307 to handle the m41t00 already, or with at most minor
> tweaks to recognize whatever's different.  It should already be ignoring
> the bits in the clock/calendar registers that vary, as well as the SRAM
> and (for some other chips) the alarm.  (Not that I2C has ways to tell us
> what IRQ the alarm would use, but that's a different tale!)

Thanks for your suggestion.  I have looked rtc-ds1307 too before I
tried to modify m41t00 driver.

It seems some works are still needed to support M41Txx chips by the
driver.

1. The driver contains ds_1340 (or st m41t00) definition, but it seems
   no way to select the ds_type.

2. As m41t00_chip_info_tbl[] in m41t00 driver shows, M41T81 and M41T85
   have different register layout.

3. It lacks some features (ST bit, HT bit, SQW freq.) in m41t00
   driver, though I personally does not need these features.

I choose changing m41t00 driver by (1) and (2).

If we really need a super generic driver, I suppose adding ds13xx
support to new m41txx driver is less hard.  I think having separate
drivers are good enough for now.

---
Atsushi Nemoto
