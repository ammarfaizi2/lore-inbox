Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751169AbVIYGXh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751169AbVIYGXh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Sep 2005 02:23:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751171AbVIYGXh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Sep 2005 02:23:37 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:29702 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1751169AbVIYGXg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Sep 2005 02:23:36 -0400
Date: Sun, 25 Sep 2005 08:20:31 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Davide Libenzi <davidel@xmailserver.org>, willy@w.ods.org,
       nish.aravamudan@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [patch] sys_epoll_wait() timeout saga ...
Message-ID: <20050925062031.GA31637@alpha.home.local>
References: <Pine.LNX.4.63.0509231108140.10222@localhost.localdomain> <20050924040534.GB18716@alpha.home.local> <29495f1d05092321447417503@mail.gmail.com> <20050924061500.GA24628@alpha.home.local> <Pine.LNX.4.63.0509240800020.31060@localhost.localdomain> <20050924172011.GA25997@alpha.home.local> <Pine.LNX.4.63.0509241113370.31327@localhost.localdomain> <20050924230545.3245da3f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050924230545.3245da3f.akpm@osdl.org>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On Sat, Sep 24, 2005 at 11:05:45PM -0700, Andrew Morton wrote:
> Davide Libenzi <davidel@xmailserver.org> wrote:
> >
> > The attached patch uses the kernel min() macro, that is optimized has 
> >  single compare by gcc-O2. Andrew, this goes over (hopefully ;) the bits 
> >  you already have in -mm.
> 
> OK, well I've rather lost the plot with all the patches flying around.
> 
> I now have one single patch against epoll.c, below.  Please confirm that
> this is what was intended.   If not, I'll drop it and let's start again.

Well, this one is fine. However, since there are possible overflows in
msec_to_jiffies() that I fixed in another patch, it would be cleaner to
only rely on this function's ability to detect overflows. Moreover, using
this function removes the divide for most common values of HZ, which is
interesting on some archs.

As Davide mentionned it, the EP_MAX_MSTIMEO constant would be useful for
other parts of the kernel (starting with sys_poll()). That's also what my
fix to jiffies.h does.

If you don't feel comfortable with so much changes at once, it's better
to first apply Davide's fix, then later the jiffies one, and then after,
I could resend the ep_poll() and sys_poll() patches to use the functions
in jiffies.h instead of doing their own magics.

Regards,
Willy

