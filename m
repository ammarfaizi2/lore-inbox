Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262499AbTHERnE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 13:43:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267186AbTHERnE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 13:43:04 -0400
Received: from fw.osdl.org ([65.172.181.6]:30098 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262499AbTHERnC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 13:43:02 -0400
Date: Tue, 5 Aug 2003 10:47:47 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise
To: Tomas Szepe <szepe@pinerecords.com>
cc: Ducrot Bruno <poup@poupinou.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [TRIVIAL] sanitize power management config menus, take two
In-Reply-To: <20030805165117.GH18982@louise.pinerecords.com>
Message-ID: <Pine.LNX.4.44.0308051006060.23977-100000@cherise>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Trouble is, the same goes for ACPI -- it doesn't require that CONFIG_PM
> code be present.

I initially missed that part of your patch, and that is incorrect - Only
part of ACPI (CONFIG_ACPI_SLEEP) should depend on CONFIG_PM.

> I think the correct x86 solution would be to introduce a real dummy
> option for the menus, and imply CONFIG_PM if APM or swsusp (the two
> options that seem to actually need CONFIG_PM code) is enabled.

I can buy that. There are actually three levels of power management that 
we handle:

- System Power Management (swsusp, CONFIG_ACPI_SLEEP)
- Device Power Management (kernel/pm.c, future driver model support)
- CPU Power Management (cpufreq)

SPM implies that DPM will be enabled, but both DPM and CPM can exist 
without SPM, and independently of each other. All of them would 
essentially fall under CONFIG_PM.. 

Would you willing to whip up a patch for the Kconfig entries? 


	-pat

