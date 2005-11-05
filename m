Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750915AbVKERjl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750915AbVKERjl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 12:39:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750925AbVKERjl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 12:39:41 -0500
Received: from van-1-67.lab.dnainternet.fi ([62.78.96.67]:42690 "EHLO
	mail.zmailer.org") by vger.kernel.org with ESMTP id S1750906AbVKERjk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 12:39:40 -0500
Date: Sat, 5 Nov 2005 19:39:39 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Jean Delvare <khali@linux-fr.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: I2C regression in post 2.6.14 gits..  -- get_user_pages() is real bug..
Message-ID: <20051105173939.GF3423@mea-ext.zmailer.org>
References: <20051102223818.GE3423@mea-ext.zmailer.org> <Go3tHv2d.1131096574.7056520.khali@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Go3tHv2d.1131096574.7056520.khali@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 04, 2005 at 10:29:34AM +0100, Jean Delvare wrote:
> Hi Matti,
> 
> On 2005-11-04, Matti Aarnio wrote:
> > Specifically,  BTTV driver fails to control internal
> > I2C devices in Hauppauge WinTV card with Bt848 onboard.
> 
> Can you detail how you came up with this diagnosis?
> 
> > Baseline 2.6.14 works fine,  but 2.6.14-git2 fails.
> 
> Can you please try 2.6.14-git1 and 2.6.14-rc5-mm1? This should help us
> norrow the faulty patch. Also, please confirm that 2.6.14-git7 still has
> the problem.
> 
> > Any ideas ?  Possible fixes ?
> 
> Enable as many debugging as possible, in particular I2C Core debugging
> (I2C_DEBUG_CORE=y) in a working kernel and a non-working kernel, and
> send both logs for comparison.
> 
> Thanks a lot for testing, BTW.


Since then I have been tracking of what really fails in the bttv driver,
and running:   strace -o tvtime.log tvtime
Result is most revealing in failures.

The fault is not in I2C, but appears in   video_buf  module failing
calls of   get_user_pages()   with  -EFAULT.

There has been lots of discussion about it back in August, but apparently
only now in post 2.6.14 the changes made it into   mm/memory.c  which
faulted this thing for BTTV. 


Oh yes,  I do use Fedora Core development kernels, and don't usually
(anymore) compile things myself, but now I had a weekend off...


> --
> Jean Delvare

/Matti Aarnio
