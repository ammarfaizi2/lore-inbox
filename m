Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262044AbVAOAUP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262044AbVAOAUP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 19:20:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262050AbVAOAUP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 19:20:15 -0500
Received: from colin2.muc.de ([193.149.48.15]:25363 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S262044AbVAOAUC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 19:20:02 -0500
Date: 15 Jan 2005 01:20:01 +0100
Date: Sat, 15 Jan 2005 01:20:01 +0100
From: Andi Kleen <ak@muc.de>
To: Tim Bird <tim.bird@am.sony.com>
Cc: karim@opersys.com, Roman Zippel <zippel@linux-m68k.org>,
       Nikita Danilov <nikita@clusterfs.com>, linux-kernel@vger.kernel.org,
       Tom Zanussi <zanussi@us.ibm.com>, ltt-dev <ltt-dev@listserv.shafik.org>
Subject: Re: 2.6.11-rc1-mm1
Message-ID: <20050115002001.GA70888@muc.de>
References: <20050114002352.5a038710.akpm@osdl.org> <m1zmzcpfca.fsf@muc.de> <m17jmg2tm8.fsf@clusterfs.com> <20050114103836.GA71397@muc.de> <41E7A7A6.3060502@opersys.com> <Pine.LNX.4.61.0501141626310.6118@scrub.home> <41E8358A.4030908@opersys.com> <41E84E9E.1000907@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41E84E9E.1000907@am.sony.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 14, 2005 at 02:58:38PM -0800, Tim Bird wrote:
> > Roman Zippel wrote: 
> >>You don't think that's a little overkill?
> >
> >Based on the descriptions below, I think Roman is right.  There's
> too much going on here for the average user.  I haven't looked closely,
> but some of the stuff seems to be for esoteric use cases.  There are
> two ways to approach it:
>  - add a simplified API for the most common usage
>  - strip out the stuff that's not really needed, and figure out
>  workarounds for things (like tracing initialization) that need
>  special assistance.
> 
> Some of these options (e.g. bufsize) are available to the user
> via tracedaemon. I can honestly say I haven't got a clue what
> to use for some of them, and so always leave them at defaults.

This is a strong cue that they are unneeded. 

> > I can see why you'd say this as a first impression, but really it isn't.
> > 
> > Here's a simple primer to this call's parameters:
> > channel_path, mode:
> > 	Where does this appear in relayfs and what rights do
> > 	user-space apps have over it (rwx).
> > bufsize, nbufs:
> > 	Usually things have to be subdivided in sub-buffers to make
> > 	both writing and reading simple. LTT uses this to allow,
> > 	among other things, random trace access.
> Could these be simplified to a few enumerated modes?

Just make it a global single define in the source.

> 
> > channel_flags, channel_callbacks:
> > start_reserve, end_reserve, rchan_start_reserve:
> > resize_min, resize_max:
> > init_buf, init_buf_size:
> 
> It seems like you could remove these from relay_open() and move them to
> get()/set() operations if you wanted to simplify the open API.

I think all for which not an clear need is demonstrated should
be removed. If there is a real need it can be still readded later.
But in the current form it is far too complicated and too fat.

> Or, you could create other (separate) APIs to pre-fill the buffer or
> reserve space.  Do you want me to take a look at this and propose
> some specific changes?  (I won't get to this until Monday, though).

No, no, it far less APIs not more. 

-Andi
