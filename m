Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964848AbWCUTeq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964848AbWCUTeq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 14:34:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964842AbWCUTeq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 14:34:46 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:6875 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S964851AbWCUTep (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 14:34:45 -0500
Subject: Re: gettimeofday order of magnitude slower with pmtimer, which is
	default
From: john stultz <johnstul@us.ibm.com>
To: bert hubert <bert.hubert@netherlabs.nl>
Cc: linux-kernel@vger.kernel.org, george@mvista.com
In-Reply-To: <20060320122449.GA29718@outpost.ds9a.nl>
References: <20060320122449.GA29718@outpost.ds9a.nl>
Content-Type: text/plain
Date: Tue, 21 Mar 2006 11:34:42 -0800
Message-Id: <1142969683.4281.14.camel@leatherman>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-03-20 at 13:24 +0100, bert hubert wrote:
> Yesterday, together with Zwane, I discovered each gettimeofday call costs me
> 4 usec on some boxes and almost nothing on others. We did a fruitless chase
> for vsyscall/sysenter happening but the problem turned out to be
> CONFIG_X86_PM_TIMER.
> 
> This problem has been discussed before
> http://www.ussg.iu.edu/hypermail/linux/kernel/0411.1/2135.html
> 
> Not only is the pm timer slow by design, it also needs to be read multiple
> times to work around a bug in certain hardware.
> 
> What is new is that this option is now dependent on CONFIG_EMBEDDED. Unless
> you select this option, the PM Timer will always be used.
> 
> Would a patch removing the link to EMBEDDED and adding a warning that while
> this timer is of high quality, it is slow, be welcome?

I think Ogawa's patch is the right solution for dropping the triple
read, which should help a good bit. 

If you *really* are sure the TSC is usable on your system, you can
override it w/ clock=tsc. Warning users that the clock is slow without
giving them a way to know if the TSC is usable will likely just cause
more problem reports. And hey, its better then using the PIT :)

thanks
-john

