Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317525AbSHUAQM>; Tue, 20 Aug 2002 20:16:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317540AbSHUAQM>; Tue, 20 Aug 2002 20:16:12 -0400
Received: from fmr05.intel.com ([134.134.136.6]:55792 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP
	id <S317525AbSHUAQM>; Tue, 20 Aug 2002 20:16:12 -0400
Message-ID: <288F9BF66CD9D5118DF400508B68C4460283E4AF@orsmsx113.jf.intel.com>
From: "Feldman, Scott" <scott.feldman@intel.com>
To: "'Troy Wilson'" <tcw@tempest.prismnet.com>,
       Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: linux-kernel@vger.kernel.org, Martin.Bligh@us.ibm.com, tcw@prismnet.com
Subject: RE: mdelay causes BUG, please use udelay
Date: Tue, 20 Aug 2002 17:20:02 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>   We probably shouldn't be doing this, but we can at least 
> avoid the BUG caused by doing an mdelay in interrupt context 
> if we change to udelay.

That's BUG is my fault.  I put that in there so no one would tempted to call
msec_delay in the interrupt context.  As you've discovered, I missed one
case where msec_delay is called in interrupt context: tx_timeout.  Dangit!

> -    msec_delay(10);
> +    usec_delay(10000);

Jeff, 10000 seems on the border of what's OK.  If it's acceptable, then
let's go for that.  Otherwise, we're going to have to chain several
mod_timer callbacks together to do a controller reset.

-scott
