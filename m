Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262772AbSJCHZ2>; Thu, 3 Oct 2002 03:25:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262773AbSJCHZ2>; Thu, 3 Oct 2002 03:25:28 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:52491 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262772AbSJCHZ1>;
	Thu, 3 Oct 2002 03:25:27 -0400
Date: Thu, 3 Oct 2002 00:28:16 -0700
From: Greg KH <greg@kroah.com>
To: john stultz <johnstul@us.ibm.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>, Dave Jones <davej@suse.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       george anzinger <george@mvista.com>
Subject: Re: [PATCH] linux-2.5.40_timer-changes_A3 (3/3 - integration)
Message-ID: <20021003072816.GA18846@kroah.com>
References: <1033625380.28783.60.camel@cog> <1033625479.28783.63.camel@cog> <1033625554.28783.66.camel@cog> <20021003065900.GB18481@kroah.com> <1033629234.13095.81.camel@cog>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1033629234.13095.81.camel@cog>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 03, 2002 at 12:13:54AM -0700, john stultz wrote:
> On Wed, 2002-10-02 at 23:59, Greg KH wrote:
> > > +/* fwd declarations */
> > 
> > These don't have to be forward declarations, do they?
> > And can they be static?
> 
> Ummm. I could just be wrong, but since I'm setting structure elements to
> equal the functions before they are declared, I need the fwds (unless,
> of course I put the "struct timer_opts timer_pit" section below all the
> functions, which is doable).

That's a bit nicer, that way you don't have to declare it twice, but
it's not a big deal either way (no style rule here :)

> Also, since external functions are going to be calling these functions
> via the structure's function pointers, I believe they can't be static.
> Although, maybe they can, as long as the timer_pit value isn't static.
> I'm not that much of a C guru, so I'm really sure.

No, they can be static, and they should, to keep the namespace a bit
cleaner.  The pointer itself isn't static, and all references to the
function goes through it, so the functions do not need to be global.

> > Shouldn't these 3 lines be above the "/* fwd declarations */" line?
> 
> They could be, but I'm not sure about the necessity. Is this a coding
> style sorta' thing, or a C properness sort of thing? Either way is fine,
> I just don't follow the logic. 

Just a "keep all #includes at the top of the file" type of thing, unless
it's absolutely necessary.

Hope this helps,

greg k-h
