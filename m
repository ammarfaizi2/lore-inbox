Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262606AbUD2Bmx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262606AbUD2Bmx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 21:42:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262596AbUD2Bmw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 21:42:52 -0400
Received: from fw.osdl.org ([65.172.181.6]:14476 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262606AbUD2BlH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 21:41:07 -0400
Date: Wed, 28 Apr 2004 18:40:08 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: brettspamacct@fastclick.com, linux-kernel@vger.kernel.org
Subject: Re: ~500 megs cached yet 2.6.5 goes into swap hell
Message-Id: <20040428184008.226bd52d.akpm@osdl.org>
In-Reply-To: <4090595D.6050709@pobox.com>
References: <409021D3.4060305@fastclick.com>
	<20040428170106.122fd94e.akpm@osdl.org>
	<409047E6.5000505@pobox.com>
	<40905127.3000001@fastclick.com>
	<20040428180038.73a38683.akpm@osdl.org>
	<4090595D.6050709@pobox.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> wrote:
>
> Andrew Morton wrote:
> > "Brett E." <brettspamacct@fastclick.com> wrote:
> > 
> >> Or how about "Use ALL the cache you want Mr. Kernel.  But when I want 
> >> more physical memory pages, just reap cache pages and only swap out when 
> >> the cache is down to a certain size(configurable, say 100megs or 
> >> something)."
> > 
> > 
> > Have you tried decreasing /proc/sys/vm/swappiness?  That's what it is for.
> > 
> > My point is that decreasing the tendency of the kernel to swap stuff out is
> > wrong.  You really don't want hundreds of megabytes of BloatyApp's
> > untouched memory floating about in the machine.  Get it out on the disk,
> > use the memory for something useful.
> 
> Well, if it's truly untouched, then it never needs to be allocated a 
> page or swapped out at all... just accounted for (overcommit on/off, 
> etc. here)
> 
> But I assume you are not talking about that, but instead talking about 
> _rarely_ used pages, that were filled with some amount of data at some 
> point in time.

Of course.  My fairly modest desktop here stabilises at about 300 megs
swapped out, with negligible swapin.  That's all just crap which apps
aren't using any more.  Getting that memory out on disk, relatively freely
is an important optimisation.

>  These are at the heart of the thread (or my point, at 
> least) -- BloatyApp may be Oracle with a huge cache of its own, for 
> which swapping out may be a huge mistake.  Or Mozilla.  After some 
> amount of disk IO on my 512MB machine, Mozilla would be swapped out... 
> when I had only been typing an email minutes before.

OK, so it takes four seconds to swap mozilla back in, and you noticed it.

Did you notice that those three kernel builds you just did ran in twenty
seconds less time because they had more cache available?  Nope.

> Regardless of /proc/sys/vm/swappiness, I think it's a valid concern of 
> sysadmins who request "hard cache limit", because they are seeing 
> pathological behavior such that apps get swapped out when cache is over 
> 50% of all available memory.

We should be sceptical of this.  If they can provide *numbers* then fine. 
Otherwise, the subjective "oh gee, that took a long time" seat-of-the-pants
stuff does not impress.  If they want to feel better about it then sure,
set swappiness to zero and live with less cache for the things which need
it...

Let me point out that the kernel right now, with default swappiness very
much tends to reclaim cache rather than swapping stuff out.  The
top-of-thread report was incorrect, due to a misreading of kernel
instrumentation.

