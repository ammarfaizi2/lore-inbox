Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263529AbUDZUzH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263529AbUDZUzH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 16:55:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263551AbUDZUzH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 16:55:07 -0400
Received: from gprs214-184.eurotel.cz ([160.218.214.184]:1665 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S263529AbUDZUzB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 16:55:01 -0400
Date: Mon, 26 Apr 2004 22:54:49 +0200
From: Pavel Machek <pavel@suse.cz>
To: Grzegorz Piotr Jaskiewicz <gj@pointblue.com.pl>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: swsusp: fix error handling in "not enough swap space"
Message-ID: <20040426205449.GD24587@elf.ucw.cz>
References: <opr6xykbzqruvnp2@laptop-linux.wpcb.org.au> <4089E761.5050708@pointblue.com.pl> <opr6x0o10uruvnp2@laptop-linux.wpcb.org.au> <4089F0E5.3050006@pointblue.com.pl> <20040424183505.GB2525@elf.ucw.cz> <408B7C13.1000708@pointblue.com.pl> <20040425204506.GG24375@elf.ucw.cz> <408D6F77.4060303@pointblue.com.pl> <20040426203238.GA24587@elf.ucw.cz> <408D7555.1000607@pointblue.com.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <408D7555.1000607@pointblue.com.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >>>Quite easy to say. I don't really understeand all changes that 've been 
> >>>done over mm between 2.6.6-rc2-bk2 and 2.6.5.
> >>>     
> >>>
> >
> >I know its easy to say ;-).
> > 
> >
> I am looking forward to see someone explaining me what has changed there 
> acctually. This time, I am sure, obviously, kernel is counting free 
> pages wrong. At least it does it incorrectly when it's about to
> 'hibernate'.

I do not know what went wrong there. If I did, I'd just fix it.

*But* if your test program doing malloc() in loop broke, you probably
want to post test program to l-k, get akpm's attetion, and make
someone fix it.

> >If you do something stupid, its okay that kernel is not able to
> >suspend. F3 on /dev/kmem counts as "something stupid". If you find out
> >something normal user (not root) can do... we are more likely to fix
> >that.
> >
> >I'd say that /dev/kmem issue is not worth fixing. NFS issue may be
> >worth fixing, but I do not use NFS that much. Any other problems?
> > 
> >
> Those were just ways of reproducing problem. I know they are not very 
> likely to be the case in real life, but simmilar lock up may occur 
> somewhere else.

Similar lock probably is there in few more places. Approach is "fix
them one by one". Not the nicest one, but...

So yes, I'm aware there are probably more cases like that; I just
don't know effective way to find them all.

> Well, maybe all beside nfs case. It just happends sometimes that network 
> is over congested, just the real life.

freeze_processes tries for 5 seconds. That should be enough to handle
common network congestion.
								Pavel
-- 
934a471f20d6580d5aad759bf0d97ddc
