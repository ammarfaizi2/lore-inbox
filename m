Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311145AbSCHVm1>; Fri, 8 Mar 2002 16:42:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311149AbSCHVmS>; Fri, 8 Mar 2002 16:42:18 -0500
Received: from adsl-209-233-33-110.dsl.snfc21.pacbell.net ([209.233.33.110]:22511
	"EHLO lorien.emufarm.org") by vger.kernel.org with ESMTP
	id <S311145AbSCHVmC>; Fri, 8 Mar 2002 16:42:02 -0500
Date: Fri, 8 Mar 2002 13:41:49 -0800
From: Danek Duvall <duvall@emufarm.org>
To: Andreas Ferber <aferber@techfak.uni-bielefeld.de>,
        linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: root-owned /proc/pid files for threaded apps?
Message-ID: <20020308214148.GA750@lorien.emufarm.org>
Mail-Followup-To: Danek Duvall <duvall@emufarm.org>,
	Andreas Ferber <aferber@techfak.uni-bielefeld.de>,
	linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <20020307060110.GA303@lorien.emufarm.org> <E16iyBW-0002HP-00@the-village.bc.nu> <20020308100632.GA192@lorien.emufarm.org> <20020308195939.A6295@devcon.net> <20020308203157.GA457@lorien.emufarm.org> <20020308222942.A7163@devcon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020308222942.A7163@devcon.net>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 08, 2002 at 10:29:42PM +0100, Andreas Ferber wrote:

> On Fri, Mar 08, 2002 at 12:31:57PM -0800, Danek Duvall wrote:
> 
> > So it also turns out that either by changing that argument to 0 or
> > just reverting that hunk of the patch, xmms starts skipping whenever
> > mozilla loads a page, even a really simple one.
> 
> ie. always when mozilla tries to do a socket(PF_INET6, ...), which
> ends up requesting the ipv6 module. 

I don't think so -- modprobe logs its attempts in /var/log/ksymoops/ and
there aren't nearly as many attempts to load net-pf-10 logged there as
pages I reloaded.

Besides if you were right, it would do the same thing in the unchanged
ac kernel -- try to load ipv6 each time and fail -- and I'd presumably
see the skipping there, too.

> > Disk activity and other network activity don't seem to cause the
> > skipping, and the skipping disappears when I go back to an unaltered
> > ac kernel, so there seems to be something wrong with set_user(0, 0)
> > as well, just a different problem.
> 
> Uhm, this one seems rather strange.

No argument from me.

> Maybe it's related to the wmb() done by set_user() if dumpclear is
> set? (although it's actually a nop on most x86 (which arch are you
> using?))

AMD K6-III, just to be specific.

> Just for testing, can you try moving the wmb() in set_user()
> (kernel/sys.c, line 512 in 2.4.19-pre2-ac3) out of the if statement?

I'd expect to see the skipping regardless, then, right?  I'll give it a
shot tonight and report back.

Thanks,
Danek
