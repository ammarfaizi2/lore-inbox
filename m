Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261884AbVGOL1R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261884AbVGOL1R (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 07:27:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261167AbVGOLYP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 07:24:15 -0400
Received: from mail.fh-wedel.de ([213.39.232.198]:1156 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S261887AbVGOLXH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 07:23:07 -0400
Date: Fri, 15 Jul 2005 13:22:55 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Jan Blunck <j.blunck@tu-harburg.de>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] generic_file_sendpage
Message-ID: <20050715112255.GC2721@wohnheim.fh-wedel.de>
References: <42D79468.3050808@tu-harburg.de> <20050715040611.05907f4a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050715040611.05907f4a.akpm@osdl.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 July 2005 04:06:11 -0700, Andrew Morton wrote:
> > +
> > +	/* There is no sane reason to use O_DIRECT */
> > +	BUG_ON(file->f_flags & O_DIRECT);
> 
> err, this seems like an easy way for people to make the kernel go BUG.

Is there a sane use for O_DIRECT in combination with sendfile()?

If not, I'd like to change sys_sendfile() and return -EINVAL for
O_DIRECT file descriptors.

> > +	if (unlikely(signal_pending(current)))
> > +		return -EINTR;
> 
> This doesn't help.  The reason we've avoided file-to-file sendfile() is
> that it can cause applications to get uninterruptibly stuck in the kernel
> for ages.  This code doesn't solve that problem.  It needs to handle
> signal_pending() inside the main loop.
> 
> And it probably needs to return a sane value (number of bytes copied)
> rather than -EINTR.

Makes sense.

> I don't know if we want to add this feature, really.  It's such a
> specialised thing.

With union mount and cowlink, there are two users already.  cp(1)
could use it as well, even if the improvement is quite minimal.

Jörn

-- 
All art is but imitation of nature.
-- Lucius Annaeus Seneca
