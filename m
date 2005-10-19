Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751573AbVJSLGy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751573AbVJSLGy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 07:06:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751566AbVJSLGy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 07:06:54 -0400
Received: from webmail.LF.net ([212.9.160.14]:62993 "EHLO webmail.LF.net")
	by vger.kernel.org with ESMTP id S1750719AbVJSLGx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 07:06:53 -0400
Message-ID: <1129720011.435628cb150f5@webmail.LF.net>
Date: Wed, 19 Oct 2005 13:06:51 +0200
From: gfiala@s.netic.de
To: linux-kernel@vger.kernel.org
Subject: Re: large files unnecessary trashing filesystem cache?
References: <4Z5WG-1iM-19@gated-at.bofh.it> <4Z6zs-27l-39@gated-at.bofh.it>  <E1ERzTq-0001IA-Ba@be1.lrz> <1129676753.23632.90.camel@localhost.localdomain> <Pine.LNX.4.58.0510190902210.2281@be1.lrz>
In-Reply-To: <Pine.LNX.4.58.0510190902210.2281@be1.lrz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.1
X-Originating-IP: 170.56.58.152
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zitat von Bodo Eggert <7eggert@gmx.de>:
> You can alyo cat a big file into /dev/null. I made those examples in order 
> to demonstrate the problem with using O_DIRECT.

O_DIRECT has to much impact at the mentioned "vdr" due to unwanted side effects 
either.

> 
> OTOH, I don't realtime stuff on my computer, so I'm not really affected, 
> but I'll try to show it anyway.
> 
> > > Changing a few programs will only partly cover the problems.
> > > 
> > > I guess the solution would be using random cache eviction rather than
> > > a FIFO. I never took a look the cache mechanism, so I may very well be
> > > wrong here.
> > 
> > Read-only pages should be re-cycled really easily & quickly. I can't
> > belive read-only pages are causing you all the trouble.
> 
> Just a q&d test:
> 
> $ time ls -l $DIR > /dev/null
> real    0m0.442s
> user    0m0.008s
> sys     0m0.024s
> 
> $ time ls -l $DIR > /dev/null
> real    0m0.077s
> user    0m0.008s
> sys     0m0.008s
> 
> cat $BIGFILES_1.5GB > /Dev/null
> 
> $ time ls -l $DIR > /dev/null
> real    0m0.270s
> user    0m0.008s
> sys     0m0.008s
> 
> $ time ls -l $DIR > /dev/null
> real    0m0.078s
> user    0m0.004s
> sys     0m0.004s
> 
> 
Thanks for pointing this out - this clearly shows the effect.
Now consider a mildly loaded multitasking environment running X, some services, 
window-manager, email, maybe some databases and a streaming video-application 
at once (so does mine) - the video-file will have unwanted impact on all the 
other applications - leading to unnecessary reloads of lots of files, inodes 
etc.
