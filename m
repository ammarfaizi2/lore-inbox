Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262812AbTHZX1i (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 19:27:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262962AbTHZX1i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 19:27:38 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:36756 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262812AbTHZX1g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 19:27:36 -0400
Subject: Re: [PATCH][2.6][2/5]Support for HPET based timer
From: john stultz <johnstul@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: venkatesh.pallipadi@intel.com, vojtech@suse.cz, Andi Kleen <ak@suse.de>,
       Dave H <haveblue@us.ibm.com>, mikpe@csd.uu.se, jun.nakajima@intel.com,
       suresh.b.siddha@intel.com, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20030826115553.7f8b3285.akpm@osdl.org>
References: <C8C38546F90ABF408A5961FC01FDBF1902C7D1F8@fmsmsx405.fm.intel.com>
	 <20030826115129.509c4161.akpm@osdl.org>
	 <20030826115553.7f8b3285.akpm@osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1061940045.21556.123.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 26 Aug 2003 16:20:46 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-08-26 at 11:55, Andrew Morton wrote:
> So I suggest you look at the latter option:
> 
> - change time_init() so that it doesn't actually touch the HPET hardware
>   in the HPET timer case.

Well, the difficult part is deciding in time_init() if we are going to
use HPET without touching the hardware (to say, check if its actually
there).

> - add late_time_init() after mem_init().
> 
> - then do calibrate_delay().
> 
> Or whatever.  The bottom line is that init/main.c is fragile, but not
> inviolable ;)


We could pick a simple time source (ie: PIT) that would get us through
early boot, then choose the real time source in late_time_init(). That
would also make implementing the ACPI PM time-source much simpler as we
could wait until after ACPI is up, letting us avoid having to parse the
tables by hand.

However I'm not sure it would be trivial and bug free. ;)

-john

