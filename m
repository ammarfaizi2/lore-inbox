Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261522AbVCXVRd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261522AbVCXVRd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 16:17:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261560AbVCXVRc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 16:17:32 -0500
Received: from mx1.redhat.com ([66.187.233.31]:8576 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261522AbVCXVRF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 16:17:05 -0500
Date: Thu, 24 Mar 2005 16:16:49 -0500
From: Dave Jones <davej@redhat.com>
To: Andrew Clayton <andrew@digital-domain.net>
Cc: Andrew Morton <akpm@osdl.org>, Jesse Barnes <jbarnes@engr.sgi.com>,
       Dave Airlie <airlied@linux.ie>, lkml <linux-kernel@vger.kernel.org>,
       Jean Delvare <khali@linux-fr.org>, torvalds@osdl.org
Subject: Re: Fw: Re: drm bugs hopefully fixed but there might still be one..
Message-ID: <20050324211649.GV15879@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Andrew Clayton <andrew@digital-domain.net>,
	Andrew Morton <akpm@osdl.org>, Jesse Barnes <jbarnes@engr.sgi.com>,
	Dave Airlie <airlied@linux.ie>, lkml <linux-kernel@vger.kernel.org>,
	Jean Delvare <khali@linux-fr.org>, torvalds@osdl.org
References: <20050324123207.31b3f867.akpm@osdl.org> <1111698587.2998.5.camel@alpha.digital-domain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1111698587.2998.5.camel@alpha.digital-domain.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2005 at 09:09:47PM +0000, Andrew Clayton wrote:
 > On Thu, 2005-03-24 at 12:32 -0800, Andrew Morton wrote:
 > > ?
 > > 
 > > Begin forwarded message:
 > > 
 > 
 > [snip]
 > 
 > > > You mean these changes?
 > > > 
 > > > --- a/drivers/char/agp/via-agp.c        2005-03-24 10:33:45 -08:00
 > > > +++ b/drivers/char/agp/via-agp.c        2005-03-24 10:33:45 -08:00
 > > > @@ -83,8 +83,10 @@
 > > >  
 > > >         pci_read_config_dword(agp_bridge->dev, VIA_GARTCTRL, &temp);
 > > >         temp |= (1<<7);
 > > > +       temp &= ~0x7f;
 > > >         pci_write_config_dword(agp_bridge->dev, VIA_GARTCTRL, temp);
 > > >         temp &= ~(1<<7);
 > > > +       temp &= ~0x7f;
 > > >         pci_write_config_dword(agp_bridge->dev, VIA_GARTCTRL, temp);
 > > >  }
 > > 
 > > Exactlty. I had to revert this one since 2.6.11-bk3, or starting X kills
 > > the machine. By "kill", I mean the real thing, black screen, dead
 > > network, reset is the only choice. This is a (surprise!) VIA-based
 > > motherboard (Asus A7V133-C) with Radeon 9200-based graphics adapter.
 > > Dave Airlie was asking for a tester with such a configuration. I can
 > > test whatever you want. Just tell me what we are looking for :)
 > > 
 > > With the patch above reverted, 2.6.12-rc1-mm2 seems to work just fine
 > > for me. glxgears is OK and I just had a game of UT (first of the name).
 > > However, I am not a regular gamer so I'm not sure what to look for.
 > > 
 > > Thanks,
 > 
 > 
 > Bingo!
 > 
 > Backing out that change to a 2.6.12-rc1 solves the exact same problem
 > I've been having since 2.6.11-bk3. VIA chipset + Radeon 9200SE.
 > 
 > http://www.ussg.iu.edu/hypermail/linux/kernel/0503.1/1096.html

Yes, it's clearly completely broken. Linus, please cset -x that one
from your tree.

		Dave

