Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264593AbTEPTwk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 15:52:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264597AbTEPTwk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 15:52:40 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:17891 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S264593AbTEPTwi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 15:52:38 -0400
Date: Fri, 16 May 2003 21:41:28 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Patrick Mochel <mochel@osdl.org>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.69-mm5: reverting i8259-shutdown.patch
Message-ID: <20030516194128.GB372@elf.ucw.cz>
References: <20030514193300.58645206.akpm@digeo.com> <Pine.LNX.4.44.0305141935440.9816-100000@cherise>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0305141935440.9816-100000@cherise>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Hi again, Andrew,
> > > 
> > > Besides the "make_KOBJ_NAME-match_BUS_ID_SIZE.patch" causing "pccard"
> > > oopses, I've also found that, with 2.5.69-mm5 compiled with ACPI
> > > support, my laptop is unable to power off. The kernel invokes
> > > "acpi_power_off" and stays there forever.
> > > 
> > > I've found that reverting the "i8259-shutdown.patch" fixes the problem
> > > and my laptop is able to shutdown properly (init 0) when using ACPI.
> > > 
> > > A hardware bug? A kernel bug?
> > 
> > And thanks again, again.
> > 
> > That's the below patch.  It looks pretty innocuous.  I'd be assuming that
> > there's something in the shutdown sequence which needs 8259 functionality
> > after the thing has been turned off.
> > 
> > This could well depend upon .config contents and linkage order.
> > 
> > Eric, maybe we need to turn it off by hand at the right time rather than
> > relying on driver model shutdown ordering?
> 
> Interesting. This is yet more proof that system-level devices cannot be
> treated as common, everyday devices. Sure, it's nice to see them show up
> in sysfs with little overhead, and very nice not to have to work about
> them during shutdown or power transitions. But there are just too many
> special cases (like getting the ordering right ;) that you have to worry
> about.
> 
> So, what do we do with them? 

I guess shutdown needs to be treated like suspend, and needs to have
"level". There should be no shutdown, you should do suspend(5, ) and
go through all levels properly.
								Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
