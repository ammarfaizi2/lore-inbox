Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265093AbSL0S0S>; Fri, 27 Dec 2002 13:26:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265094AbSL0S0S>; Fri, 27 Dec 2002 13:26:18 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:41413 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id <S265093AbSL0S0R>;
	Fri, 27 Dec 2002 13:26:17 -0500
Date: Fri, 27 Dec 2002 19:34:34 +0100
From: bert hubert <ahu@ds9a.nl>
To: Pavel Machek <pavel@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: swsusp in 2.5.53 BUG on kernel/suspend.c line 718
Message-ID: <20021227183432.GB10482@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Pavel Machek <pavel@suse.cz>, linux-kernel@vger.kernel.org
References: <20021227142032.GA6945@outpost.ds9a.nl> <20021227150929.GB16911@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021227150929.GB16911@atrey.karlin.mff.cuni.cz>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 27, 2002 at 04:09:30PM +0100, Pavel Machek wrote:
> You need one-liner to fix this, search mailing lists.

Your patch below indeed works, except for my network adaptor which needs
'ifconfig eth0 down', 'ifconfig eth0 up' before it works again.

It says:

NETDEV WATCHDOG: eth0: transmit timed out
eth0: Transmit timeout, status 00000000 00000240 
00:01.1 Ethernet controller: Silicon Integrated Systems [SiS] SiS900 10/100
Ethernet (rev 82)

Can a non-guru add the magic handlers to network drivers to make them wake
up again properly?

Thanks!

--- clean/mm/page_alloc.c       2002-12-18 22:21:13.000000000 +0100
+++ linux-swsusp/mm/page_alloc.c        2002-12-18 22:30:47.000000000 +0100
@@ -389,7 +389,7 @@
        unsigned long flags;
        struct page *page = NULL;
 
-       if (order == 0) {
+       if ((order == 0) && !cold) {
                struct per_cpu_pages *pcp;
 
                pcp = &zone->pageset[get_cpu()].pcp[cold];



-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
http://netherlabs.nl                         Consulting
