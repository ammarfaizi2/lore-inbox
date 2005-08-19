Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964926AbVHSKU4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964926AbVHSKU4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 06:20:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932616AbVHSKU4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 06:20:56 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:34993 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932615AbVHSKU4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 06:20:56 -0400
Date: Fri, 19 Aug 2005 12:23:15 +0200
From: Jens Axboe <axboe@suse.de>
To: Jon Escombe <lists@dresco.co.uk>
Cc: Pavel Machek <pavel@suse.cz>, Adam Goode <adam@evdebs.org>,
       Alejandro Bonilla Beeche <abonilla@linuxwireless.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       hdaps devel <hdaps-devel@lists.sourceforge.net>
Subject: Re: [Hdaps-devel] Re: HDAPS, Need to park the head for real
Message-ID: <20050819102314.GN6273@suse.de>
References: <1124205914.4855.14.camel@localhost.localdomain> <20050816200708.GE3425@suse.de> <20050818204904.GE516@openzaurus.ucw.cz> <1124399756.28353.0.camel@lynx.auton.cs.cmu.edu> <20050818213823.GA4275@elf.ucw.cz> <20050819063602.GD6273@suse.de> <4305AECE.3020508@dresco.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4305AECE.3020508@dresco.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 19 2005, Jon Escombe wrote:
> 
> >>>>Please make it "echo 1 > frozen", then userspace can do "echo 0 > 
> >>>>frozen"
> >>>>after five seconds.
> >>>>       
> >>>>
> >>>What if the code to do "echo 0 > frozen" is swapped out to disk? ;)
> >>>     
> >>>
> >>Emergency head parker needs to be pagelocked for other reasons. You do
> >>not want to page it from disk while your notebook is in free fall.
> >>   
> >>
> >
> >It's still a very bad idea imho, what if the head parker daemon is
> >killed for other reasons? The automatic timeout thawing the drive is
> >much saner.
> > 
> >
> For hard disk protection, I prefer the idea of the userspace code 
> thawing the drive based on current accelerometer data, rather than 
> simply waking up after x seconds (maybe you're running for a bus rather 
> than falling off a table)...
> 
> To get the best of both worlds, could we maybe take a watchdog timer 
> approach, and have the timeout reset by the userspace component 
> periodically re-requesting freeze?

That would work, you can just define the semantics to be that echo
foo > frozen would add foo seconds to the timeout (or thaw it, if foo is
0).

-- 
Jens Axboe

