Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751119AbWHBDyY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751119AbWHBDyY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 23:54:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751118AbWHBDyY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 23:54:24 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:2514 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751111AbWHBDyX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 23:54:23 -0400
Subject: Re: Re: [PATCH] RTC: Add mmap method to rtc character driver
From: john stultz <johnstul@us.ibm.com>
To: Dave Airlie <airlied@gmail.com>
Cc: Neil Horman <nhorman@tuxdriver.com>,
       Segher Boessenkool <segher@kernel.crashing.org>,
       "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
       a.zummo@towertech.it, jg@freedesktop.org
In-Reply-To: <21d7e9970607251304n5681bf44gc751c21fd79be99d@mail.gmail.com>
References: <20060725174100.GA4608@hmsreliant.homelinux.net>
	 <03BCDC7F-13D9-42FC-86FC-30C76FD3B3B8@kernel.crashing.org>
	 <20060725182833.GE4608@hmsreliant.homelinux.net>
	 <44C66C91.8090700@zytor.com>
	 <20060725192138.GI4608@hmsreliant.homelinux.net>
	 <F09D8005-BD93-4348-9FD1-0FA5D8D096F1@kernel.crashing.org>
	 <20060725194733.GJ4608@hmsreliant.homelinux.net>
	 <21d7e9970607251304n5681bf44gc751c21fd79be99d@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 01 Aug 2006 20:54:19 -0700
Message-Id: <1154490859.17171.12.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-07-26 at 06:04 +1000, Dave Airlie wrote:
> I'm wondering why x86 doesn't have gettimeofday vDSO (does x86 have
> proper vDSO support at all apart from sysenter?),

I know, I'm late to the party here. :)

Anyway, i386 doesn't have vDSO gettimeofday because its always been too
messy to do. Now that the clocksource bits are in, we can start to
really work on it.

I just uploaded my C4 release of the timekeeping code here:
http://sr71.net/~jstultz/tod/broken-out/

If you grab the following patches:
  linux-2.6.18-rc3_timeofday-vsyscall-support_C4.patch 
  linux-2.6.18-rc3_timeofday-i386-vsyscall_C4.patch

They should apply to the current -git tree and then you can use the
following test to see an LD_PRELOAD demo (as real support needs glibc
changes).

http://sr71.net/~jstultz/tod/vsyscall-gtod_test_C4.tar.bz2


Only lightly tested, so beware, and I've only added support so far for
the TSC (so don't be surprised if you don't see a performance
improvement if you using a different clocksource).

thanks
-john

