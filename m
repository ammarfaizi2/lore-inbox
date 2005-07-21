Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261650AbVGUFhb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261650AbVGUFhb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 01:37:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261646AbVGUFe4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 01:34:56 -0400
Received: from MAIL.13thfloor.at ([212.16.62.50]:44237 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S261638AbVGUFeb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 01:34:31 -0400
Date: Thu, 21 Jul 2005 07:34:30 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: Andrew Morton <akpm@osdl.org>, Jan Blunck <j.blunck@tu-harburg.de>,
       torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] generic_file_sendpage
Message-ID: <20050721053430.GA859@MAIL.13thfloor.at>
Mail-Followup-To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
	Andrew Morton <akpm@osdl.org>, Jan Blunck <j.blunck@tu-harburg.de>,
	torvalds@osdl.org, linux-kernel@vger.kernel.org
References: <42D79468.3050808@tu-harburg.de> <20050715040611.05907f4a.akpm@osdl.org> <20050715112255.GC2721@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050715112255.GC2721@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 15, 2005 at 01:22:55PM +0200, Jörn Engel wrote:
> On Fri, 15 July 2005 04:06:11 -0700, Andrew Morton wrote:
> > > +
> > > +	/* There is no sane reason to use O_DIRECT */
> > > +	BUG_ON(file->f_flags & O_DIRECT);
> > 
> > err, this seems like an easy way for people to make the kernel go BUG.
> 
> Is there a sane use for O_DIRECT in combination with sendfile()?
> 
> If not, I'd like to change sys_sendfile() and return -EINVAL for
> O_DIRECT file descriptors.
> 
> > > +	if (unlikely(signal_pending(current)))
> > > +		return -EINTR;
> > 
> > This doesn't help.  The reason we've avoided file-to-file sendfile() is
> > that it can cause applications to get uninterruptibly stuck in the kernel
> > for ages.  This code doesn't solve that problem.  It needs to handle
> > signal_pending() inside the main loop.
> > 
> > And it probably needs to return a sane value (number of bytes copied)
> > rather than -EINTR.
> 
> Makes sense.
> 
> > I don't know if we want to add this feature, really.  It's such a
> > specialised thing.
> 
> With union mount and cowlink, there are two users already.  cp(1)
> could use it as well, even if the improvement is quite minimal.

you might soon add linux-vserver to the list, as
we will be using this for a special version of the
COW links (to break unified links on write) ...

best,
Herbert

> Jörn
> 
> -- 
> All art is but imitation of nature.
> -- Lucius Annaeus Seneca
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
