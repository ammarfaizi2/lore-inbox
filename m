Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262113AbUEAKan@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262113AbUEAKan (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 May 2004 06:30:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262132AbUEAKan
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 May 2004 06:30:43 -0400
Received: from wombat.indigo.net.au ([202.0.185.19]:11279 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S262113AbUEAKal (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 May 2004 06:30:41 -0400
Date: Sat, 1 May 2004 18:31:02 +0800 (WST)
From: raven@themaw.net
To: Dave Airlie <airlied@linux.ie>
cc: Paul Jackson <pj@sgi.com>, Erdi Chen <erdi.chen@digeo.com>,
       davem@redhat.com, Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: sparc64 2.6.6-rc2-mm2 build busted: usb/core/hub.c hubstatus
In-Reply-To: <Pine.LNX.4.58.0404282128440.2727@donald.themaw.net>
Message-ID: <Pine.LNX.4.58.0405011819310.1819@donald.themaw.net>
References: <20040426204947.797bd7c2.pj@sgi.com>
 <Pine.LNX.4.58.0404271248250.8094@wombat.indigo.net.au>
 <Pine.LNX.4.58.0404272234320.1547@donald.themaw.net> <Pine.LNX.4.58.0404280111430.2125@skynet>
 <Pine.LNX.4.58.0404281025060.651@wombat.indigo.net.au>
 <Pine.LNX.4.58.0404280325340.2125@skynet> <Pine.LNX.4.58.0404282128440.2727@donald.themaw.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-1.7, required 8,
	EMAIL_ATTRIBUTION, IN_REP_TO, NO_REAL_NAME, QUOTED_EMAIL_TEXT,
	REFERENCES, REPLY_WITH_QUOTES, USER_AGENT_PINE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Apr 2004 raven@themaw.net wrote:

> On Wed, 28 Apr 2004, Dave Airlie wrote:
> 
> > > >
> > >
> > > I'll investigate but I think that, either I need the fb device or
> > > X -configure has it wrong. It thinks I have devices fb0 and fb1.
> > 
> > leave in the "fb" device but don't enable direct rendering "ffb" device,
> > not the extra f, if it still crashes with just the framebuffer and not the
> > DRM then there is a framebuffer issue ...
> > 
> > CONFIG_DRM_FFB should be n is probably the most straightforward way to
> > check it isn't in there..
> 
> Did that and got simmilar oops.
> 
> X -configure still insists I have BusID "SBUS:fb0" and "SBUS:fb1" devices.
> If I configure BusID "sbus@1f,0/cgsix@0.0" and "sbus@1f,0/cgsix@2,0" as I 
> would in 2.4 X complains that it can't find the "SBUS:fbn" devices.
> 

Have tried to progress this.

As far as I can tell an oops occurs on this line

	get_user(htransp, transp);

or on this line (if parameter kspc = 1)

	htransp = transp ? *transp : 0xffff;

in fb_set_cmap.

It appears that transp (aka cmap->transp) is a bogus address.

Can someone who is familiar with this code give me a little insight into 
what I should expect to see here. Could there be some sort of reuse of a 
stale struct fbcmap here?

Ian

