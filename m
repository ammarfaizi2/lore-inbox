Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261817AbTHYJw1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 05:52:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261822AbTHYJw1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 05:52:27 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:36032 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S261817AbTHYJwZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 05:52:25 -0400
Date: Mon, 25 Aug 2003 11:52:32 +0200
From: Pavel Machek <pavel@suse.cz>
To: Patrick Mochel <mochel@osdl.org>
Cc: torvalds@osdl.org, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PM] Patrick: which part of "maintainer" and "peer review" needs explaining to you?
Message-ID: <20030825095232.GD3020@elf.ucw.cz>
References: <20030822215315.GD2306@elf.ucw.cz> <Pine.LNX.4.33.0308221454420.2310-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0308221454420.2310-100000@localhost.localdomain>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Secondly, you can actually remove the second command line parameter 
> > > ("noresume") by simply specifying a NULL partition to this parameter. It 
> > > requires about a 5-line change, and makes things simpler. 
> > 
> > You'd better not. You are expected to have one "resume=/foo/bar"
> > specified as append in lilo. You want to able to say noresume and do
> > one boot without resuming. Turning resume with
> > "resume=/dev/nonexistent" would be playing roulete with command line
> > argument order.
> 
> AFAIK, you could have
> 
> resume=/dev/hda3 always appended to your command line. Should you suspend 
> and not want to resume, you should be able to manually add
> 
> "resume=" on the command line after the above, and have the setup function 
> called again, which would reset it to NULL, thereby keeping the same 

I'm not sure if it is easy to guarantee that you are adding *after*
parameters automatically appended with LILO.

> > > -EAGAIN allows the drivers/devices that really need special care to 
> > > specify it. Otherwise, we'll end up calling ->suspend() twice for power 
> > > down for each device (those that can do w/ interrupts enabled and those 
> > > that need interrupts disabled), which also requires every single driver to 
> > > check whether or not interrupts are enabled, instead of just those that 
> > > need it. 
> > 
> > No, you should have simply let it alone and pass "level" parameter
> > telling driver if interrupts were disabled or not. No need to
> > constantly change API while trying to stabilise the code.
> 
> ...and modify each driver to check for it? 

Well, those drivers should have the checks already, otherwise they are
buggy, but I guess I see your point now.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
