Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264572AbSIQVA0>; Tue, 17 Sep 2002 17:00:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264580AbSIQVA0>; Tue, 17 Sep 2002 17:00:26 -0400
Received: from pizda.ninka.net ([216.101.162.242]:13443 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S264572AbSIQVAC>;
	Tue, 17 Sep 2002 17:00:02 -0400
Date: Tue, 17 Sep 2002 13:56:02 -0700 (PDT)
Message-Id: <20020917.135602.19253755.davem@redhat.com>
To: johnstul@us.ibm.com
Cc: anton.wilson@camotion.com, linux-kernel@vger.kernel.org, george@mvista.com
Subject: Re: do_gettimeofday vs. rdtsc in the scheduler
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <1032296233.22815.192.camel@cog>
References: <1032294559.22815.180.camel@cog>
	<20020917.133933.69057655.davem@redhat.com>
	<1032296233.22815.192.camel@cog>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: john stultz <johnstul@us.ibm.com>
   Date: 17 Sep 2002 13:57:13 -0700

   On Tue, 2002-09-17 at 13:39, David S. Miller wrote:
   > It would have been really nice if x86 had specified a "system tick"
   > register that incremented based upon the system bus cycles and thus
   > were immune the processor rates.
   
   Some systems do, if I'm understanding you properly. Summit based boxes
   have an on-chipset performance counter that runs at 100Mhz. My
   cyclone-timer patch uses this as a gettimeofday/__delay time source in
   the 2.4 kernel. Additionally George Anzinger has patches that allow the
   ACPI PM timer to be used as well. Intel's HPET should also provide
   another time source.

If any of these need to go beyond the cpu to get the tick value,
they are misimplemented.

The cpu gets the system bus tick input at it's bus pins, therefore
it can implement the system tick register locally obviating the need
to go to a south bridge or memory controller or whatever else external
to the cpu to get at the value.
