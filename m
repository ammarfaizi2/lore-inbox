Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261568AbTFFPM1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 11:12:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261861AbTFFPM0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 11:12:26 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:45969
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S261568AbTFFPMY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 11:12:24 -0400
Subject: Re: __check_region in ide code?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Rusty Russell <rusty@rustcorp.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.SOL.4.30.0306061053040.15859-100000@mion.elka.pw.edu.pl>
References: <Pine.SOL.4.30.0306061053040.15859-100000@mion.elka.pw.edu.pl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1054913005.17190.6.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 06 Jun 2003 16:23:26 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2003-06-06 at 09:56, Bartlomiej Zolnierkiewicz wrote:
> > 	There's nothing inherently *wrong* with check_region, it's
> > just deprecated to trap the old (now racy) idiom of "if
> > (check_region(xx)) reserve_region(xx)".  There's no reason not to
> > introduce a probe_region if IDE really wants it.
> 
> And ide-probe.c does exactly this racy stuff.
> 
> I did patch to convert it to request_region() some time ago,
> I just need to double check it and submit.

request_region at that point doesn't actually help you. For PIO devices
its too late if you are handling PCMCIA, for PCI devices its too late
because you want to own the PCI device properly, for MMIO its completely
broken (all the mem region stuff in 2.5)

The only way I can see to fix it properly is to provide ide helpers
for resource allocation that are used by the drivers when needed.


