Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263339AbTECQNM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 May 2003 12:13:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263340AbTECQNM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 May 2003 12:13:12 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:35090 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263339AbTECQNL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 May 2003 12:13:11 -0400
Date: Sat, 3 May 2003 17:25:33 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Greg KH <greg@kroah.com>
cc: Riley Williams <Riley@Williams.Name>,
       Balram Adlakha <b_adlakha@softhome.net>, <linux-kernel@vger.kernel.org>
Subject: Re: wrong screen size with fbcon [2.5.68]
In-Reply-To: <20030503151659.GA16996@kroah.com>
Message-ID: <Pine.LNX.4.44.0305031721410.4509-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> >  >> I posted about this when 2.5.68 was released but very few people
> >  >> responded. While using the framebuffer console driver, I seems
> >  >> that the screen is set to something like 1024x775 instead of
> >  >> 1024x768. I cannot see the bottom of my screen that is...
> >  >>
> >  >> I just checked the latest bk taken from kernel.org and still
> >  >> hasn't been fixed. The fb console was working perfectly till
> >  >> 2.5.67.
> >  >>
> >  >> If it is of any relevance, I'm using an NVIDIA tnt2 card. Has
> >  >> nobody noticed this problem?
> > 
> >  > I have, and posted pretty much the same report a few weeks ago.
> >  > Time to go write up a bug in bugzilla.kernel.org...
> > 
> > The probable response will be WONTFIX on the grounds that the NVIDIA
> > driver is a binary only driver and, as such, can't be fixed...
> 
> No, I'm using the VESA framebuffer driver that is in the kernel.  This
> same thing happens on two different machines with two different video
> cards. 
> 
> No binary only driver for me, don't you think I would know better?  :)

I think it has to do with the EDID code. The code works but for the intel 
platform I'm grabbing data form the BIOS. I have seen 3 responses. The 
first is the EDID header is corrupt. This is what happens to me. The 
second is it gives wrong data. The screen that the EDID reports is 
different from the one we request via the VESA mode setting BIOS call.
THe final is it actually works. The way to fix this is to remove the EDID
code in vesafb.c. I will push a patch for that soon. 


