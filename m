Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932305AbWCEAOL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932305AbWCEAOL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Mar 2006 19:14:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932308AbWCEAOL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Mar 2006 19:14:11 -0500
Received: from smtp.osdl.org ([65.172.181.4]:20447 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932305AbWCEAOK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Mar 2006 19:14:10 -0500
Date: Sat, 4 Mar 2006 16:12:27 -0800
From: Andrew Morton <akpm@osdl.org>
To: J M Cerqueira Esteves <jmce@artenumerica.com>
Cc: linux-kernel@vger.kernel.org, support@artenumerica.com, ngalamba@fc.ul.pt,
       Jens Axboe <axboe@suse.de>
Subject: Re: oom-killer: gfp_mask=0xd1  with 2.6.12 on EM64T
Message-Id: <20060304161227.71b124e1.akpm@osdl.org>
In-Reply-To: <440865A9.4000102@artenumerica.com>
References: <4405D383.5070201@artenumerica.com>
	<20060302011735.55851ca2.akpm@osdl.org>
	<440865A9.4000102@artenumerica.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

J M Cerqueira Esteves <jmce@artenumerica.com> wrote:
>

argh.  Please always do reply-to-all.  I almost missed this one.

> Andrew Morton wrote:
> > That's quite an old kernel.  If this is the notorious bio-uses-GFP_DMA bug
> > then I'd have expected this kernel to be useless from day one.  Did you
> > install it recently?
> 
> On this double Xeon, yes.  I had no problems before with 2.6.12 and the
> same "heavy" software on dual Opteron and dual dual core Opteron
> machines, and this is my first installation on a EM64T.
> At first it seemed everything was ok with 2.6.12 here too, but in a
> couple of days we started gettings some of those oom killings when
> running some Gaussian jobs. In at least a pair of cases the system froze
> completely.
> 
> > If you're feeling keen you could add this patch which would confirm it:
> 
> Added it and already got output for a similar "killing". Since I'm not
> sure what could be most relevant among those messages, I refrained from
> attaching them all here, and instead put them at
> http://jmce.artenumerica.org/tmp/linux-2.6.12-oom_killings/EM64T-kern.log

Those x86_64 backtraces are quite hard to follow.  They get much better if
you enable CONFIG_FRAME_POINTER, and that makes very little difference to
code quality.

> > And if it's that bug then I'm afraid you'll have to sit tight until 2.6.16.
> > We shouldn't release 2.6.16 until this thing is fixed.
> 
> Do those call traces suggest that uncorrected bug you mention?

It's hard to say what happened there.  I _think_ it went oom in
get_sectorsize()'s GFP_KERNEL|GFP_DMA allocation.  (Jens, do we really need
GFP_DMA in there?)

But that's only a 512-byte allocation.  Something else must have used up
all the DMA zone.

