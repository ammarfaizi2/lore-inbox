Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264989AbTFYTpN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 15:45:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264997AbTFYTpN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 15:45:13 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:39622 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S264989AbTFYTpJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 15:45:09 -0400
Date: Wed, 25 Jun 2003 21:58:47 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: davidm@hpl.hp.com
Cc: Riley Williams <Riley@Williams.Name>, Vojtech Pavlik <vojtech@suse.cz>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] input: Fix CLOCK_TICK_RATE usage ...  [8/13]
Message-ID: <20030625215847.A12212@ucw.cz>
References: <20030618013114.A23697@ucw.cz> <BKEGKPICNAKILKJKMHCAIECMEHAA.Riley@Williams.Name> <16121.55803.509760.869572@napali.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <16121.55803.509760.869572@napali.hpl.hp.com>; from davidm@napali.hpl.hp.com on Wed, Jun 25, 2003 at 10:20:59AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 25, 2003 at 10:20:59AM -0700, David Mosberger wrote:

> Moreover, the current drivers would compile just fine on ia64, even
> though they could not possibly work correctly with the current use of
> CLOCK_TICK_RATE.  With a separate header file (and a config option),
> these dependencies would be made explicit and that would improve
> overall cleanliness.
> 
> In other words, I still think the right way to go about this is to
> have <asm/pit.h>.  On x86, this could be:
> 
> --
> #include <asm/timex.h>
> 
> #define PIT_FREQ	CLOCK_TICK_RATE
> #define PIT_LATCH	((PIT_FREQ + HZ/2) / HZ)
> --

Actually, I think it should be the other way around:

asm-i386/pit.h:

#define PIT_FREQ	1193182
#define PIT_LATCH	((PIT_FREQ + HZ/2) / HZ)

asm-i386/timex.h:

#include <asm/pit.h>
#define CLOCK_TICK_RATE	PIT_FREQ

> If you insist, you could even put this in asm-generic, though
> personally I don't think that's terribly elegant.
> 
> On ia64, <asm/pit.h> could be:
> 
> #ifdef CONFIG_PIT
> # define PIT_FREQ	1193182
> # define PIT_LATCH	((PIT_FREQ + HZ/2) / HZ)
> #endif
> 
> 	--david

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
