Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271922AbTHMWT7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 18:19:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271940AbTHMWT7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 18:19:59 -0400
Received: from mail3.ithnet.com ([217.64.64.7]:145 "HELO heather-ng.ithnet.com")
	by vger.kernel.org with SMTP id S271922AbTHMWTz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 18:19:55 -0400
X-Sender-Authentication: SMTPafterPOP by <info@euro-tv.de> from 217.64.64.14
Date: Thu, 14 Aug 2003 00:19:53 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Oleg Drokin <green@namesys.com>
Cc: marcelo@conectiva.com.br, akpm@osdl.org, andrea@suse.de,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org, mason@suse.com
Subject: Re: 2.4.22-pre lockups (now decoded oops for pre10)
Message-Id: <20030814001953.1505bda4.skraw@ithnet.com>
In-Reply-To: <20030813163452.GC27515@namesys.com>
References: <20030813125509.360c58fb.skraw@ithnet.com>
	<Pine.LNX.4.44.0308131143570.4279-100000@localhost.localdomain>
	<20030813145940.GC26998@namesys.com>
	<20030813171224.2a13b97f.skraw@ithnet.com>
	<20030813153009.GA27209@namesys.com>
	<20030813163452.GC27515@namesys.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Aug 2003 20:34:52 +0400
Oleg Drokin <green@namesys.com> wrote:

> You seem to be getting corruptions in at least 2 days for now, though.
> And reiserfs seems to trigger the problem even faster (and may be
> even more faster if you enable CONFIG_REISERFS_CHECK).

well, I have an idea how to find out more about these verify problem. Basically
I would try to patch tar to ouput the differing areas to stdout in hexdump
format or the like. Only I need some time to make this work out. I hope to find
some pattern about this corruption. 

> > 10 pre's ... That cannot be the way to find out what is going on. 
> > On the other hand: 
> > - no UP kernel ever crashed. So we can at least talk about an SMP-race.
> 
> There is still huge field to look at.
> 
> > - 2.4.20 does not crash
> > - 2.4.21 does crash
> 
> diff is 20M in size.
> 
> > If we can add "ext3 does not crash" to the list, then I really hope we can
> > use some brain and give good selection of patches between 2.4.20 and 2.4.21
> > that may cause the troubles.
> 
> There were not much changes in reiserfs. All those patches can easily be
> reverted just for verification purposes. Let me know when you are ready/want
> to test this variant and I will send you a diff.

Hm, my primary belief is that something _around_ reiserfs has changed
semantics.

> > If possible I can then patch out all of them and retry. So there is much
> > less time spent for testing. 
> > I mean, have you looked at the length of this thread already?
> 
> Yes, I did.
> Now if only we can get someone to reproduce your problems...

Hm, I believe nobody in fact tried a setup like mine. As I have clear
indication that I can trigger it simply by using an SMP box, installing SuSE
8.2, compiling stock 2.4.22-rc2 kernel exporting some reiserfs to a nfs-client
of your choice and starting copying data with sizes around 100GB back and
forth.

> > > > I can add another week if you want me to, just tell me. The only thing
> > > > I don't want is that any doubts are left after testing ...
> > > It would be interesting to look at fsck results on the fs after some time
> > > of testing.
> > You mean I should do an fsck on sunday?
> 
> Yes, whenever you decide you have waited long enough (provided that it won't
> crash) and decide to stop testing, please run fsck on that testing fs.

Ok, will do that.

> 
> > > Probably it would be easier for you to make it crash (if there are crash
> > > possibility at all) if you enable JBD debugging.
> > I have never seen this in real life. Is it possible to turn this on when
> > handling >100 GB of data or will some debug output flood the box?
> 
> It only enables some more checks, not debug output.

Does this work for ext3, reiserfs or both?

Regards,
Stephan
