Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278649AbRJXQgS>; Wed, 24 Oct 2001 12:36:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278648AbRJXQgI>; Wed, 24 Oct 2001 12:36:08 -0400
Received: from alcove.wittsend.com ([130.205.0.10]:6109 "EHLO
	alcove.wittsend.com") by vger.kernel.org with ESMTP
	id <S278643AbRJXQf7>; Wed, 24 Oct 2001 12:35:59 -0400
Date: Wed, 24 Oct 2001 12:36:19 -0400
From: "Michael H. Warfield" <mhw@wittsend.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-kernel@vger.kernel.org, Patrick Mochel <mochel@osdl.org>,
        Jonathan Lundell <jlundell@pobox.com>
Subject: Re: [RFC] New Driver Model for 2.5
Message-ID: <20011024123619.A21416@alcove.wittsend.com>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linux-kernel@vger.kernel.org, Patrick Mochel <mochel@osdl.org>,
	Jonathan Lundell <jlundell@pobox.com>
In-Reply-To: <E15wO1x-0001Vt-00@the-village.bc.nu> <Pine.LNX.4.33.0110240915590.8049-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0110240915590.8049-100000@penguin.transmeta.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2001 at 09:19:45AM -0700, Linus Torvalds wrote:

> On Wed, 24 Oct 2001, Alan Cox wrote:

> > Assuming you want to synchronize the raid before suspend - a reasonably
> > policy but not essential then you'd have to shut down the raid before
> > sd, then sd would let the devices shut down which lets the controller
> > shutdown

> I will _refuse_ to have a kernel suspend that synchronizes the raid etc.
> That would make suspend/resume potentially take a _loong_ time.

	If you have Magic SysRq enabled, would that do the job prior
to suspend?  Typically with Pavel's swsusp package, I hit the Alt-SysRq-s
before hitting Alt-SysRq-d to suspend him.  Does Alt-SysRq-s synchronize
a raid?  Of course, at that point, the choice to take the "_loong_ time"
is in user space - meat space, user space - since I chose to hit that
key combination.

> If you want to synchronize your raid thing, make the user-level thing that
> triggers the suspend do it. Same goes for things like "sync network
> filesystems" etc. This is not a kernel level issue, and the kernel
> shouldn't even try to do it.

	What does the Alt-SysRq-s combination do about networks then?

> If somebody has pending stuff over NFS and suspends, and when it comes
> back it's not on the network any more, that is 100% equivalent to removing
> a PCMCIA network card while running. It's supposed to work - but if you
> lose data that's YOUR problem, not the kernels.

> 		Linus

	Mike
-- 
 Michael H. Warfield    |  (770) 985-6132   |  mhw@WittsEnd.com
  /\/\|=mhw=|\/\/       |  (678) 463-0932   |  http://www.wittsend.com/mhw/
  NIC whois:  MHW9      |  An optimist believes we live in the best of all
 PGP Key: 0xDF1DD471    |  possible worlds.  A pessimist is sure of it!

