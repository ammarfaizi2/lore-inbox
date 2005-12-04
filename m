Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932221AbVLDOdn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932221AbVLDOdn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Dec 2005 09:33:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932235AbVLDOdn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Dec 2005 09:33:43 -0500
Received: from isilmar.linta.de ([213.239.214.66]:40640 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S932221AbVLDOdn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Dec 2005 09:33:43 -0500
Date: Sun, 4 Dec 2005 15:33:37 +0100
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       ck list <ck@vds.kolivas.org>, Tony Lindgren <tony@atomide.com>,
       Adam Belay <abelay@novell.com>, Daniel Petrini <d.pensator@gmail.com>,
       vatsa@in.ibm.com
Subject: Dyntick effectiveness [Was: [PATCH] i386 no idle HZ aka Dynticks 051203]
Message-ID: <20051204143337.GA4572@isilmar.linta.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.net>,
	Con Kolivas <kernel@kolivas.org>,
	linux kernel mailing list <linux-kernel@vger.kernel.org>,
	ck list <ck@vds.kolivas.org>, Tony Lindgren <tony@atomide.com>,
	Adam Belay <abelay@novell.com>,
	Daniel Petrini <d.pensator@gmail.com>, vatsa@in.ibm.com
References: <200512041737.07996.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200512041737.07996.kernel@kolivas.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 04, 2005 at 05:37:05PM +1100, Con Kolivas wrote:
> Here is an updated complete patch implementing no idle hz ticks
> aka dynticks for i386.

A few stats about running dynticks on my notebook (1.4G Pentium M)

CPU frequency	C4	dyntick	avg. battery rate[*]
------------------------------------------------------------
0.6 GHz		on	off	990 mA
0.6 GHz		on	on	973 mA (-2%)

1.4 GHz		on	off	1400 mA		fan starts very soon (~15sec)
1.4 GHz		on	on	1100 mA (-21%)	fan starts after ~5min

0.6 GHz		off	off	1130 mA
0.6 GHz		off	on	1050 mA (-7%)

1.4 GHz		off	off	1480 mA
1.4 GHz		off	on	1180 mA (-20%) 


[*] as reported by cat /proc/acpi/battery/BAT1/state .

Power consumption during normal operation (C0) and in processor idle states,
as per datasheet:

speed		C0 	C1	C2	C3	C4
-----------------------------------------------------
1.4GHz		22W 	7.3W	7.3W	5.1W	0.55W

0.6GHz		 6W	1.8W	1.8W	1.1W	0.55W

=> Most useful when CPU frequency scaling isn't available (Celerons? Do they
	have "Deeper Sleep State" -- no, they don't. That's why I did the
	test run with C4 disabled. The values for 1.4G without C4 should be
	similar to what can be seen on Celerons.)
=> Only minimal additional power savings when CPU frequency scaling works
	well
=> Possible reason: entering power states takes more time when at higher
	speed


	Dominik
