Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262300AbVBBR7T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262300AbVBBR7T (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 12:59:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262568AbVBBR7T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 12:59:19 -0500
Received: from mx1.redhat.com ([66.187.233.31]:35799 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262300AbVBBR7I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 12:59:08 -0500
Date: Wed, 2 Feb 2005 09:58:51 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Peter Osterlund <petero2@telia.com>, linux-kernel@vger.kernel.org,
       dtor_core@ameritech.net, zaitcev@redhat.com
Subject: Re: Touchpad problems with 2.6.11-rc2
Message-ID: <20050202095851.27321bcf@localhost.localdomain>
In-Reply-To: <20050202170727.GA2731@ucw.cz>
References: <20050123190109.3d082021@localhost.localdomain>
	<m3acqr895h.fsf@telia.com>
	<20050201234148.4d5eac55@localhost.localdomain>
	<20050202102033.GA2420@ucw.cz>
	<20050202085628.49f809a0@localhost.localdomain>
	<20050202170727.GA2731@ucw.cz>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed-Claws 0.9.12cvs126.2 (GTK+ 2.4.14; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Feb 2005 18:07:27 +0100, Vojtech Pavlik <vojtech@suse.cz> wrote:

> On Wed, Feb 02, 2005 at 08:56:28AM -0800, Pete Zaitcev wrote:
> > On Wed, 2 Feb 2005 11:20:33 +0100, Vojtech Pavlik <vojtech@suse.cz> wrote:
> > 
> > > Well, you removed the scaling to the touchpad resolution, which will
> > > cause ALPS touchpad to be significantly slower than Synaptics touchpads.
> > > Similarly, the screen size used to be taken into account, but probably
> > > that was a mistake, since the value is usually left at default and
> > > doesn't correspond to the real screen size.
> > 
> > Exactly. And it works much better now.
>  
> With a Synaptics I suppose? You wouldn't like it with an ALPS.

No, it's a Dualpoint, and so ALPS. But never mind that, I think I see
your point.

However, while I see a possibility of serious regressions with the other
variety, but isn't it striking that result is so radical? With all the
arithmetics still in place I can move my finger all across the pad without
causing any motions. We are not talking about ballistics or any fine tuning,
simply the calculations are wrong.

Let me add more, too. As long as the touchpad code in mousedev.c converts
absolute mode data into relative events, there's no reason to scale
_to the size of the screen_. Don't you see? User needs a scaling to
the sensitivity, not the screen size. I have never seen a touchpad which
allowed you to cross the screen in one motion if you moved it slowly,
this is why acceleration feature exists. It's completely bogus.

Scaling to the size of the screen would have made sense if we used touchpad
to generate absolute events, as some sort of a miniature Wacom pad. In such
a case, you wouldn't be able to reach corners of the screen without scaling.
But a touchpad is operated in entirely different way.

If Synaptics delivers much bigger deltas for small motions, it's up to the
Synapics mode of alps.c to make them reasonable, if that. There's no need
to penalize ALPS. But I seriously doubt that Synaptics can be so broken.
I wish Peter tested the removal of scaling with his Synaptics. If he
(and Dmitry) insist on running a special code in X, that's fine. But honestly,
I expect that things will go well for them.

-- Pete
