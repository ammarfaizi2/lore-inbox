Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264992AbTFQWyj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 18:54:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264993AbTFQWyj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 18:54:39 -0400
Received: from palrel10.hp.com ([156.153.255.245]:32941 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S264992AbTFQWyi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 18:54:38 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16111.40816.147471.84610@napali.hpl.hp.com>
Date: Tue, 17 Jun 2003 16:08:32 -0700
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: davidm@hpl.hp.com, Riley Williams <Riley@Williams.Name>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] input: Fix CLOCK_TICK_RATE usage ...  [8/13]
In-Reply-To: <20030618004233.B21001@ucw.cz>
References: <16110.4883.885590.597687@napali.hpl.hp.com>
	<BKEGKPICNAKILKJKMHCAEEOAEFAA.Riley@Williams.Name>
	<16111.37901.389610.100530@napali.hpl.hp.com>
	<20030618002146.A20956@ucw.cz>
	<16111.38768.926655.731251@napali.hpl.hp.com>
	<20030618004233.B21001@ucw.cz>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Wed, 18 Jun 2003 00:42:33 +0200, Vojtech Pavlik <vojtech@suse.cz> said:

  >> so if a legacy speaker is present, it assumes a particular
  >> frequency.  In other words: it's a driver issue.  On ia64, this
  >> frequency certainly has nothing to do with time-keeping and
  >> therefore doesn't belong in timex.h.

  Vojtech> I'm quite fine with that. However, different (sub)archs,
  Vojtech> for example the AMD Elan CPUs have a slightly different
  Vojtech> base frequency. So it looks like an arch-dependent #define
  Vojtech> is needed. I don't care about the location (timex.h indeed
  Vojtech> seems inappropriate, maybe the right location is pcspkr.c
  Vojtech> ...), or the name, but something needs to be done so that
  Vojtech> the beeps have the same sound the same on all archs.

Sounds much better to me.  Wouldn't something along the lines of this
make the most sense:

  #ifdef __ARCH_PIT_FREQ
  # define PIT_FREQ	__ARCH_PIT_FREQ
  #else
  # define PIT_FREQ	1193182
  #endif

After all, it seems like the vast majority of legacy-compatible
hardware _do_ use the standard frequency.

	--david
