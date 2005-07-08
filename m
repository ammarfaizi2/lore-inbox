Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262636AbVGHGdx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262636AbVGHGdx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 02:33:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262637AbVGHGdw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 02:33:52 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:6109 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262636AbVGHGdo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 02:33:44 -0400
Date: Fri, 8 Jul 2005 08:31:56 +0200
From: Jens Axboe <axboe@suse.de>
To: Jon Escombe <lists@dresco.co.uk>
Cc: Shawn Starr <spstarr@sh0n.net>, hdaps-devel@lists.sourceforge.net,
       Lenz Grimmer <lenz@grimmer.com>, Arjan van de Ven <arjan@infradead.org>,
       Alejandro Bonilla <abonilla@linuxwireless.org>,
       Jesper Juhl <jesper.juhl@gmail.com>, Dave Hansen <dave@sr71.net>,
       LKML List <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>
Subject: Re: IBM HDAPS things are looking up (was: Re: [Hdaps-devel] Re: [ltp] IBM HDAPS Someone interested? (Accelerometer))
Message-ID: <20050708063156.GP24401@suse.de>
References: <42C8D06C.2020608@grimmer.com> <20050704110604.GL1444@suse.de> <20050707080323.GF1823@suse.de> <200507071028.06765.spstarr@sh0n.net> <20050707150548.GD24401@suse.de> <42CDB3F9.5010402@dresco.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42CDB3F9.5010402@dresco.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 08 2005, Jon Escombe wrote:
> Jens Axboe wrote:
> 
> >On Thu, Jul 07 2005, Shawn Starr wrote:
> > 
> >
> >>Model: HTS548080M9AT00 (Hitachi)
> >>Laptop: T42.
> >>
> >>segfault:/home/spstarr# ./a /dev/hda
> >>head parked
> >>
> >>Seems to park, heard it click :)
> >>   
> >>
> >
> >Note on that - if the util says it parked, you can be very sure that it
> >actually did as the drive actually returns that status outside of just
> >completing the command.
> > 
> >
> It's worth noting that you'll need the libata passthrough patch to make 
> this work on a T43..
> 
> However, with this patch I'm getting the "head not parked 4c" message, 
> but I can hear the click from the drive.. It takes around 350-400ms for 
> the command to execute, but when repeated, it drops to around 5ms for a 
> short while (with no audible clicking), before reverting to original 
> behaviour after a few seconds.
> 
> The clicking and the variation in execution time lead me to think it is 
> parking, but not being reported correctly?

Sounds like a pass through bug, it should pass the register output back
out again for a non-data command.

Checking code... Yeah it does not. Since the 'we parked successfully' is
stored in the lbal register, we need the full register set copied back
into the buffer. That goes for all three HDIO_* commands, there's still
some work to be done for the libata passthrough to be compliant with the
ide one.

-- 
Jens Axboe

