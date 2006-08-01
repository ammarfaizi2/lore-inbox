Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030390AbWHAB5c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030390AbWHAB5c (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 21:57:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030391AbWHAB5c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 21:57:32 -0400
Received: from mga07.intel.com ([143.182.124.22]:39970 "EHLO
	azsmga101.ch.intel.com") by vger.kernel.org with ESMTP
	id S1030390AbWHAB5b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 21:57:31 -0400
X-IronPort-AV: i="4.07,199,1151910000"; 
   d="scan'208"; a="73203161:sNHT31700032"
Date: Mon, 31 Jul 2006 18:47:01 -0700
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Matthias Urlichs <smurf@smurf.noris.de>
Cc: Arjan van de Ven <arjan@infradead.org>, Andi Kleen <ak@muc.de>,
       Andrew Morton <akpm@osdl.org>, john stultz <johnstul@us.ibm.com>,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, bunk@stusta.de,
       lethal@linux-sh.org, hirofumi@mail.parknet.co.jp,
       asit.k.mallick@intel.com
Subject: Re: REGRESSION: the new i386 timer code fails to sync CPUs
Message-ID: <20060731184701.A4592@unix-os.sc.intel.com>
References: <20060723053755.0aaf9ce0.akpm@osdl.org> <1153756738.9440.14.camel@localhost> <20060724171711.GA3662@kiste.smurf.noris.de> <20060724175150.GD50320@muc.de> <1153774443.12836.6.camel@localhost> <20060730020346.5d301bb5.akpm@osdl.org> <20060730201005.GA85093@muc.de> <20060730211359.GZ3662@kiste.smurf.noris.de> <1154294444.2941.50.camel@laptopd505.fenrus.org> <20060730215509.GA3662@kiste.smurf.noris.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20060730215509.GA3662@kiste.smurf.noris.de>; from smurf@smurf.noris.de on Sun, Jul 30, 2006 at 11:55:09PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 30, 2006 at 11:55:09PM +0200, Matthias Urlichs wrote:
> Hi,
> 
> Arjan van de Ven:
> > if the hardware side is different *speed*.. then a tsc sync ain't going
> > to work... sure we write to it but it's immediately out of sync again
> > 
> No, it's in fact the same speed -- the BIOS just reads it wrongly.

It sounds to me as a BIOS issue. From the boot log, it is quite clear that
TSCs are running at different speeds(different bogomips show this).
This CPU stepping has constant TSC behavior. So this is most probably happening
because of bios setting different core to bus clock ratios for each package.
Different CPU speed BIOS issue that you mention also points to this.

Can you check if your BIOS settings are set to max ratio(15?) available?
or try an updated BIOS?

> 
> I checked: the two date values do advance at the same rate.

Perhaps data overflow(because of unsync TSC's) in timer code calculations
may be causing this?

thanks,
suresh
