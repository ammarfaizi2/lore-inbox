Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262700AbVAKKvN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262700AbVAKKvN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 05:51:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262702AbVAKKvM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 05:51:12 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:21897 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262700AbVAKKuq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 05:50:46 -0500
Date: Tue, 11 Jan 2005 05:47:22 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Mauricio Lin <mauriciolin@gmail.com>
Cc: Edjard Souza Mota <edjard@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: User space out of memory approach
Message-ID: <20050111074722.GC18796@logos.cnet>
References: <3f250c71050110134337c08ef0@mail.gmail.com> <20050110192012.GA18531@logos.cnet> <4d6522b9050110144017d0c075@mail.gmail.com> <20050110200514.GA18796@logos.cnet> <3f250c71050110152421e83e04@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f250c71050110152421e83e04@mail.gmail.com>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2005 at 07:24:35PM -0400, Mauricio Lin wrote:
> On Mon, 10 Jan 2005 18:05:14 -0200, Marcelo Tosatti
> <marcelo.tosatti@cyclades.com> wrote:
> > On Tue, Jan 11, 2005 at 12:40:24AM +0200, Edjard Souza Mota wrote:
> > > Hi,
> > >
> > > I guess it the idea was not fully and well explained. It is not the OOM Killer
> > > itself that was moved to user space but rather its ranking algorithm.
> > > Ranking is not an specific functionality of kernel space. Kernel only need
> > > to know which process whould be killed.
> > >
> > > In that sense the approach is different and might be worth testing, mainly for
> > > cases where we want to allow better policies of ranking. For example, an
> > > embedded device with few resources and important different running applications:
> > > whic one is the best? To my understanding the current ranking policy
> > > does not necessarily chooses the best one to be killed.
> > 
> > Sorry, I misunderstood. Should have read the code before shouting.
> > 
> > The feature is interesting - several similar patches have been around with similar
> > functionality (people who need usually write their own, I've seen a few), but none
> > has ever been merged, even though it is an important requirement for many users.
> > 
> > This is simple, an ordered list of candidate PIDs. IMO something similar to this
> > should be merged. Andrew ?
> > 
> > Few comments about the code:
> > 
> >  retry:
> > -       p = select_bad_process();
> > +       printk(KERN_DEBUG "A good walker leaves no tracks.\n");
> > +       p = select_process();
> > 
> > You want to fallback to select_bad_process() if no candidate has been selected at
> > select_process().
> The idea is turn off the select_bad_process() and the new
> select_process() will get the list of pids to be killed from
> /proc/oom. But the ranking algorithms is the same, I mean is the Rik
> van Riel algorithm. Do you think it is worthwhile to maintain the
> select_bad_process (kernel space algorithm) if we have the
> select_process() function?

Yes, if select_process() fails (in case no process is on the candidate list), i
fallbacking to select_bad_process() is important I think.

> > 
> > You also want to move "oom" to /proc/sys/vm/.
> 
> This can be possible. Do you think that it is a good place to move the oom?

Yep.
