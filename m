Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268130AbUIKMXS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268130AbUIKMXS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 08:23:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268131AbUIKMXS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 08:23:18 -0400
Received: from web11904.mail.yahoo.com ([216.136.172.188]:32778 "HELO
	web11904.mail.yahoo.com") by vger.kernel.org with SMTP
	id S268130AbUIKMXN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 08:23:13 -0400
Message-ID: <20040911122312.15823.qmail@web11904.mail.yahoo.com>
Date: Sat, 11 Sep 2004 05:23:12 -0700 (PDT)
From: Mike Mestnik <cheako911@yahoo.com>
Subject: Re: radeon-pre-2
To: Keith Whitwell <keith@tungstengraphics.com>,
       Vladimir Dergachev <volodya@mindspring.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Airlie <airlied@linux.ie>,
       Jon Smirl <jonsmirl@gmail.com>,
       =?ISO-8859-1?Q?=20=22Felix=5FK=FChling=22?= <fxkuehl@gmx.de>,
       DRI Devel <dri-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <4142BACC.4080708@tungstengraphics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- Keith Whitwell <keith@tungstengraphics.com> wrote:

> Vladimir Dergachev wrote:
> > 
> > Alan,
> >   I would like to disagree with you.
> > 
> > On Fri, 10 Sep 2004, Alan Cox wrote:
> > 
> >> On Gwe, 2004-09-10 at 23:19, Dave Airlie wrote:
> >>
> >>> If the kernel developers can address this point I would be most
> >>> interested, in fact I don't want to hear any more about sharing
> lowlevel
> >>> VGA device drivers until someone addresses why it is acceptable to
> have
> >>> two separate driver driving the same hardware for video and not for
> >>> anything else.. (remembering graphics cards are not-multifunction 
> >>> cards -
> >>> like Christoph used as an example before - 2d/3d are not separate
> >>> functions...)...
> >>
> >>
> >> We've addressed this before. Zillions of drivers provide multiple
> >> functions to multiple higher level subsystems. They don't all have to
> >> be compiled together to make it work.
> >>
> >> 2D and 3D _are_ to most intents and purposes different functions.
> They
> >> are as different as IDE CD and IDE disk if not more so.
> > 
> > 
> > Functions - yes, but they become such only at a higher level. 3d for 
> > example does not really exist in kernel in any form.
> > 
> > I would like to see unified fb (or the hardware-specific part of fb)
> and 
> > drm for one simple reason that I think you mentioned:
> > 
> >     One driver per device. I.e. one driver per *physical* device.
> > 
> > Lastly, one point that you appear to have missed: DRM does DMA
> transfers
> > (among everything else). FB sets video modes - i.e. messes with PLL.
> > The problem is that there are configurations where messing with PLL 
> > while a DMA trasfer is active will lock up PCI (or AGP) bus hard.
> > 
> > For example, a video decoder can be clocked off pixel clock for video 
> > pass through mode. If we trasfer video data to main RAM at the same
> time 
> > and
> > FB gets a command instructing it to change resolution there would be a
> 
> > hard lockup.
> 
> I can see this being the case, but why can't fb just using existing drm 
> interfaces to achieve device quiescence before touching the PLL's?
> 
I can see the problem here...

This happens with old(current) gatos and fglrx.  Where DRI sets up some
state in the card and then dosen't clear it after being unloaded.  This
leaves the card in an unknowen state that gatos or fglrx dosen't know any
thing about.

What will happen is that when the FB or DRM turns on a new feature the
other driver MAY need to be aware of the change.  This would imply that we
must now version as if there where an ABI.  The REAL problem is that the
ABI is all in hardware!  The bottom line is that nether of these drivers
SHOULD assume that the other won't change the way it uses the card, thus
forcing a bianary compatability issue.

> Keith
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
> Project Admins to receive an Apple iPod Mini FREE for your judgement on
> who ports your project to Linux PPC the best. Sponsored by IBM. 
> Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
> --
> _______________________________________________
> Dri-devel mailing list
> Dri-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/dri-devel
> 



	
		
__________________________________
Do you Yahoo!?
New and Improved Yahoo! Mail - 100MB free storage!
http://promotions.yahoo.com/new_mail 
