Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261169AbUISRTU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261169AbUISRTU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Sep 2004 13:19:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261232AbUISRTT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Sep 2004 13:19:19 -0400
Received: from web11905.mail.yahoo.com ([216.136.172.189]:31760 "HELO
	web11905.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261169AbUISRTH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Sep 2004 13:19:07 -0400
Message-ID: <20040919171907.6090.qmail@web11905.mail.yahoo.com>
Date: Sun, 19 Sep 2004 10:19:07 -0700 (PDT)
From: Mike Mestnik <cheako911@yahoo.com>
Subject: Re: Design for setting video modes, ownership of sysfs attributes
To: Jon Smirl <jonsmirl@gmail.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Keith Packard <keithp@keithp.com>
Cc: dri-devel <dri-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <9e47339104091909465c9a483f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- Jon Smirl <jonsmirl@gmail.com> wrote:

> On Sun, 19 Sep 2004 14:45:37 +1000, Benjamin Herrenschmidt
> <benh@kernel.crashing.org> wrote:
> > Typically, with X: We don't want X itself to have to be the one
> setting
> > the mode, but rather set the mode and have X be notified properly
> before
> > and after it happens so it can "catch up".
> 
> This is going to require some more thought. Mode setting needs two
> things, a description of the mode timings and a location of the scan
> out buffer.  With multiple heads you can't just assume that the buffer
> starts at zero.  There also the problem of the buffer increasing in
> size and needing to be moved since it won't fit where it is.
> 
There will be cases where there won't be enuff memory for both
framebuffers.  Most video cards will support power-saving modes or an
"off" state.  This can be used so that the user won't see the Framebuffer
get overriten with the new data, whatever gets swaped into that memory
location.

> Keith, how should this work for X? We have to make sure all DRI users
> of the buffer are halted, get a new location for the buffer, set the
> mode, free the old buffer, notify all of the DRI clients that their
> target has been wiped and has a new size.
> 
> I was wanting to switch mode setting into an atomic operation where
> you passed in both the mode timings and buffer location.
> 
I think it would work best if the buffer where setup/maped/allocated(in
revers order), then the call to program the DAC.  It dosen't make any
differance if it is attomic, worst case the user will just see trash.

> -- 
> Jon Smirl
> jonsmirl@gmail.com
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
> Project Admins to receive an Apple iPod Mini FREE for your judgement on
> who ports your project to Linux PPC the best. Sponsored by IBM.
> Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
> --
> _______________________________________________
> Dri-devel mailing list
> Dri-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/dri-devel
> 



		
__________________________________
Do you Yahoo!?
Yahoo! Mail is new and improved - Check it out!
http://promotions.yahoo.com/new_mail
