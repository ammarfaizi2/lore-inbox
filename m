Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261392AbULTC0g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261392AbULTC0g (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Dec 2004 21:26:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261395AbULTC0g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Dec 2004 21:26:36 -0500
Received: from rproxy.gmail.com ([64.233.170.206]:31156 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261392AbULTC02 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Dec 2004 21:26:28 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=Nw+byYyokOC+qOOC4NaWhB3HAPUFdyaJ93KzA0nYeoVNJB99zElweLt7sY05IaVphQfOFe5AzJ9QQ1SpV37r7JZsAbE3W+yQppRJ+tggsOX0Othj/6p23tln3mfMRcb436ro6kwTfG6UBdGEMhP0bpte/Yo+EMKvNcKKsuWOA7M=
Message-ID: <29495f1d04121918264caadf2c@mail.gmail.com>
Date: Sun, 19 Dec 2004 18:26:27 -0800
From: Nish Aravamudan <nish.aravamudan@gmail.com>
Reply-To: Nish Aravamudan <nish.aravamudan@gmail.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [PATCH] Remove RCU abuse in cpu_idle()
Cc: Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Paul E. McKenney" <paulmck@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Stephen Rothwell <sfr@canb.auug.org.au>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Dipankar Sarma <dipankar@in.ibm.com>, Li Shaohua <shaohua.li@intel.com>,
       Len Brown <len.brown@intel.com>
In-Reply-To: <1103507784.5093.9.camel@npiggin-nld.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20041205004557.GA2028@us.ibm.com>
	 <Pine.LNX.4.61.0412110804500.5214@montezuma.fsmlabs.com>
	 <Pine.LNX.4.61.0412112123490.7847@montezuma.fsmlabs.com>
	 <Pine.LNX.4.61.0412112205290.7847@montezuma.fsmlabs.com>
	 <Pine.LNX.4.61.0412112244000.7847@montezuma.fsmlabs.com>
	 <29495f1d04121818403f949fdd@mail.gmail.com>
	 <Pine.LNX.4.61.0412191757450.18310@montezuma.fsmlabs.com>
	 <1103505344.5093.4.camel@npiggin-nld.site>
	 <Pine.LNX.4.61.0412191819130.18310@montezuma.fsmlabs.com>
	 <1103507784.5093.9.camel@npiggin-nld.site>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Dec 2004 12:56:24 +1100, Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> On Sun, 2004-12-19 at 18:44 -0700, Zwane Mwaikambo wrote:
> > On Mon, 20 Dec 2004, Nick Piggin wrote:
> >
> > > This thread can possibly be stalled forever if there is a CPU hog
> > > running, right?
> >
> > Yep.
> >
> > > In which case, you will want to use ssleep rather than a busy loop.
> >
> > Well ssleep essentially does the same thing as the schedule_timeout.
> >
> 
> Yes - so long as you set ->state when using schedule_timeout ;)

You do not need to set the state before calling ssleep(). It is set to
TASK_UNINTERRUPTIBLE within the loop of ssleep().

-Nish
