Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274951AbTHFJVI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 05:21:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274989AbTHFJVI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 05:21:08 -0400
Received: from poup.poupinou.org ([195.101.94.96]:5130 "EHLO poup.poupinou.org")
	by vger.kernel.org with ESMTP id S274951AbTHFJVF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 05:21:05 -0400
Date: Wed, 6 Aug 2003 11:20:45 +0200
To: Patrick Mochel <mochel@osdl.org>
Cc: Tomas Szepe <szepe@pinerecords.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [TRIVIAL] sanitize power management config menus, take two
Message-ID: <20030806092045.GA8810@poupinou.org>
References: <20030805165117.GH18982@louise.pinerecords.com> <Pine.LNX.4.44.0308051006060.23977-100000@cherise>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0308051006060.23977-100000@cherise>
User-Agent: Mutt/1.5.4i
From: Ducrot Bruno <poup@poupinou.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 05, 2003 at 10:47:47AM -0700, Patrick Mochel wrote:
> 
> > Trouble is, the same goes for ACPI -- it doesn't require that CONFIG_PM
> > code be present.
> 
> I initially missed that part of your patch, and that is incorrect - Only
> part of ACPI (CONFIG_ACPI_SLEEP) should depend on CONFIG_PM.
> 
> > I think the correct x86 solution would be to introduce a real dummy
> > option for the menus, and imply CONFIG_PM if APM or swsusp (the two
> > options that seem to actually need CONFIG_PM code) is enabled.
> 
> I can buy that. There are actually three levels of power management that 
> we handle:
> 
> - System Power Management (swsusp, CONFIG_ACPI_SLEEP)
> - Device Power Management (kernel/pm.c, future driver model support)
> - CPU Power Management (cpufreq)
> 
> SPM implies that DPM will be enabled, but both DPM and CPM can exist 
> without SPM, and independently of each other. All of them would 
> essentially fall under CONFIG_PM.. 
> 
> Would you willing to whip up a patch for the Kconfig entries? 

I mostly agree.  The only trouble is then:

$ egrep -rl '#ifdef[:space:]+CONFIG_PM$' linux-2.6.0-test2/ | wc -l
    96

I think it make sense to change this by CONFIG_DPM.

Opinions?

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.
