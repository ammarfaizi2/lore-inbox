Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263771AbTEOCtN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 22:49:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263772AbTEOCtN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 22:49:13 -0400
Received: from fep03-mail.bloor.is.net.cable.rogers.com ([66.185.86.73]:57061
	"EHLO fep03-mail.bloor.is.net.cable.rogers.com") by vger.kernel.org
	with ESMTP id S263771AbTEOCtK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 22:49:10 -0400
Message-ID: <3EC3031F.1030306@rogers.com>
Date: Wed, 14 May 2003 23:01:51 -0400
From: Jeff Muizelaar <muizelaar@rogers.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030327 Debian/1.3-4
X-Accept-Language: en
MIME-Version: 1.0
To: Adam Belay <ambx1@neo.rr.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, greg@kroah.com,
       Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] NE2000 driver updates
References: <3EB15127.2060409@rogers.com> <1051817031.21546.23.camel@dhcp22.swansea.linux.org.uk> <3EB1ADEC.6080007@rogers.com> <1051884070.23249.4.camel@dhcp22.swansea.linux.org.uk> <3EC1A368.9010707@rogers.com> <20030514215134.GA32285@neo.rr.com>
In-Reply-To: <20030514215134.GA32285@neo.rr.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at fep03-mail.bloor.is.net.cable.rogers.com from [24.43.126.4] using ID <muizelaar@rogers.com> at Wed, 14 May 2003 23:01:53 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam Belay wrote:

>On Tue, May 13, 2003 at 10:01:12PM -0400, Jeff Muizelaar wrote:
>  
>
>
>Hi Jeff,
>
>I agree that an isa interface with sysfs would be useful.  This patch looks like 
>a great start.  I'm considering the following aditional changes...
>
>1.) Perhaps the contents of /drivers/eisa and /drivers/isa should be held in the 
>same directory.  Comments?
>
Maybe. Though, eisa is still a sane bus, where we get ids and slot 
numbers etc. The isa code is pretty much a free for all.

>2.) Some collaboration between isapnp, eisa, and isa would be nice.  This is 
>because all three of these interfaces could potentially be detecting the same 
>devices, resulting in nasty conflicts.
>
Yes, agreed. Probably the easiest way to this is something like an 
isa_reserve_(region/resources) that checks if either eisa or pnp know 
about anything at the place where we are going to probe. This keeps isa 
autoprobe from blindly stealing everything it can get it's hands on, and 
lets the higher level buses have priority over it.

This also brings up the question of whether something from eisa/pnp 
should also be registered on the isa bus.

>3.) A sysfs interface that would export isa information would be useful.
>
>4.) Perhaps the isa drivers could match against the name of the legacy probing 
>driver or maybe the system should be designed to not use device_ids at all.
>  
>
Yeah, basically all we need is something that says "this is my device, 
give it to me later".

>
>Also a few things to consider...
>
>Is isa limited to one dma, one irq, and one ioport?  I haven't seen more then 
>this anywere but it would be nice to know for registration purposes.
>
>What is the best action to take if a legacy probing technique detects an area 
>that conflicts with a previous legacy probe from another driver.  At the very 
>least, it would be nice if isa was aware of such things.
>
Right now, it is basically first come, first serve. request_region keeps 
people from stepping on each other toes. So, once a driver finds a 
region it likes it keeps it and nobody else can touch it. I think it is 
probably best to keep it this way.

-Jeff

