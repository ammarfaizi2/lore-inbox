Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271308AbTHHMUX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 08:20:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271307AbTHHMUX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 08:20:23 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:41863 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S271308AbTHHMUV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 08:20:21 -0400
Subject: Re: Kernel 2.6.0-test2 vs 2.2.12 -- Some observations
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: jcwren@jcwren.com
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200308071323.44884.jcwren@jcwren.com>
References: <1060256649.3169.20.camel@dhcp22.swansea.linux.org.uk>
	 <Pine.LNX.4.44.0308071023040.6818-200000@logos.cnet>
	 <20030807142624.GA29208@lst.de>  <200308071323.44884.jcwren@jcwren.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1060344989.4933.27.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 08 Aug 2003 13:16:30 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2003-08-07 at 18:23, J.C. Wren wrote:
> 	For reasons unknown, whereas 2.2.12 picked up the values for how much memory 
> we have stuffed into a fake BIOS block, 2.6.0-test2 does not (nor did 
> 2.5.69).  I have to set a mem=7744k into the boot params.  Anything more, and 
> I get kernel paging faults at startup.  I'm unclear why this is, but since it 
> can be worked around at the moment, I can let it lay.

2.5.x/2.6 (and 2.4) use E820 memory sizing before E801 and earlier
systems. Make sure your E820 tables are right I guess.

> 	I have not run hdparm on the drives, but e2fsck coming up on a dirty 
> partition is amazingly slow on 2.6.0-test2.  On a 32MB CF card with 25% usage 
> (about 300 files), it takes less than 10 seconds under 2.2.12.  On 
> 2.6.0-test2, I'm seeing on the order of 40+ seconds.  Long enough, in fact, 
> that the watchdog that makes sure the system has booted into the application 
> is timing out and punting the system.

You bluecat probably sets umask by default if its designed to keep
latency low. So hdparm -u1 /dev/hda first.

