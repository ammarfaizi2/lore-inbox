Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265971AbUITEPq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265971AbUITEPq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 00:15:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265973AbUITEPp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 00:15:45 -0400
Received: from rproxy.gmail.com ([64.233.170.198]:15265 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S265971AbUITEPn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 00:15:43 -0400
Message-ID: <41b516cb0409192115151fe38c@mail.gmail.com>
Date: Sun, 19 Sep 2004 21:15:43 -0700
From: Chris Leech <chris.leech@gmail.com>
Reply-To: Chris Leech <chris.leech@gmail.com>
To: Jeff Garzik <jgarzik@pobox.com>, Li Shaohua <shaohua.li@intel.com>,
       Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       "David S. Miller" <davem@redhat.com>
Subject: Re: hotplug e1000 failed after 32 times
In-Reply-To: <414E46B7.70901@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <1095396793.10407.9.camel@sli10-desk.sh.intel.com>
	 <20040916221406.1f3764e0.akpm@osdl.org>
	 <1095411933.10407.29.camel@sli10-desk.sh.intel.com>
	 <20040917161920.16d18333.akpm@osdl.org> <414B7470.4000703@pobox.com>
	 <1095641512.24333.8.camel@sli10-desk.sh.intel.com>
	 <414E46B7.70901@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Sep 2004 22:55:51 -0400, Jeff Garzik <jgarzik@pobox.com> wrote:
> Li Shaohua wrote:
> > I'm not familiar with the NIC driver, but this problem really is
> > annoying. The gurus, please consider a solution. It's not an uncommon
> > case. I believe it's common in a big system with hotplug support. I can
> > understand why the driver doesn't support more than 32 a card, but one
> > card with 32 times hotplug failed is a little ugly.
> 
> There should be no problem at all with the driver supporting 32 NICs...
>   in fact if it cannot support at least 99 NICs, I would consider that a
> bug.

I'd like to hear more about what the failure condition actually is,
see any system messages logged.

The 32 NIC limitation is for configuration via the module parameters,
but e1000 itself doesn't impose any other limitations on the number of
NICs.  I know of testing situations where 360 e1000 ports were in use
on a large system.  I've run hotplug tests, powering slots on and off
while passing traffic in a fail-over teaming configuration, for weeks
without problem.  I'll run a hotplug test myself as soon as I get a
chance, but I don't see any reason why it should be failing.

As for the module parameter limitations, yes only 32 ports can be
configured that way and the counter doesn't roll back with
hot-removes.  I think we can live with those limitations.  Indexed
parameters make no sense in a hotplug environment, use ethtool.

The module parameters in e1000 work for a large number or users who
can live with those limitations.  That's why they're still in the
driver.  As long as they work, I think they should stay.  But I'm not
in favor of adding more code, or making the existing code more
complex, to try and remove those limitations.  That's why everything
can be configured through ethtool.

- Chris
