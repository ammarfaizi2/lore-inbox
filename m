Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264621AbUD2Ops@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264621AbUD2Ops (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 10:45:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264649AbUD2Opr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 10:45:47 -0400
Received: from florence.buici.com ([206.124.142.26]:51847 "HELO
	florence.buici.com") by vger.kernel.org with SMTP id S264621AbUD2Opm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 10:45:42 -0400
Date: Thu, 29 Apr 2004 07:45:39 -0700
From: Marc Singer <elf@buici.com>
To: Andrew Morton <akpm@osdl.org>
Cc: riel@redhat.com, brettspamacct@fastclick.com, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org
Subject: Re: ~500 megs cached yet 2.6.5 goes into swap hell
Message-ID: <20040429144538.GA708@buici.com>
References: <20040428180038.73a38683.akpm@osdl.org> <Pine.LNX.4.44.0404282143360.19633-100000@chimarrao.boston.redhat.com> <20040428185720.07a3da4d.akpm@osdl.org> <20040429022944.GA24000@buici.com> <20040428193541.1e2cf489.akpm@osdl.org> <20040429031059.GA26060@buici.com> <20040428201924.719dfb68.akpm@osdl.org> <20040429041302.GA26845@buici.com> <20040428213359.77f9dfb5.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040428213359.77f9dfb5.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 28, 2004 at 09:33:59PM -0700, Andrew Morton wrote:
> Marc Singer <elf@buici.com> wrote:
> >
> > It could work differently from that.  For example, if we had 500M
> > total, we map 200M, then we do 400M of IO.  Perhaps we'd like to be
> > able to say that a 400M page cache is too big.
> 
> Try it - you'll find that the system will leave all of your 200M of mapped
> memory in place.  You'll be left with 300M of pagecache from that I/O
> activity.  There may be a small amount of unmapping activity if the I/O is
> a write, or if the system has a small highmem zone.  Maybe.

Are you sure?  Isn't that what the other posters are winging about?
They do lots of IO and then they have to wait for the system to page
Mozilla back in.

> Beware that both ARM and NFS seem to be doing odd things, so try it on a
> PC+disk first ;)

Yeah, I know that there is still something odd in ARM-land.  I assume
that the other posters are using IA32. 

> No, the system will only start to unmap pages if reclaim of unmapped
> pagecache is getting into difficulty.  The threshold of "getting into
> difficulty" is controlled by /proc/sys/vm/swappiness.

What constitutes 'difficulty'?  Perhaps this is rhetorical. 

> > I've read the source for where swappiness comes into play.  Yet I
> > cannot make a statement about what it means.  Can you?
> 
> It controls the level of page reclaim distress at which we decide to start
> reclaiming mapped pages.
> 
> We prefer to reclaim pagecache, but we have to start swapping at *some*
> level of reclaim failure.  swappiness sets that level, in rather vague
> units.

I'm not sure I see why we have to swap.  If have of memory is mapped,
and the user is using those pages with some frequency, perhaps we
should never reclaim mapped pages.

