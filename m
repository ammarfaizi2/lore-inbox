Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318781AbSH1IYf>; Wed, 28 Aug 2002 04:24:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318785AbSH1IYf>; Wed, 28 Aug 2002 04:24:35 -0400
Received: from boden.synopsys.com ([204.176.20.19]:3002 "HELO
	boden.synopsys.com") by vger.kernel.org with SMTP
	id <S318781AbSH1IYe>; Wed, 28 Aug 2002 04:24:34 -0400
Date: Wed, 28 Aug 2002 10:28:45 +0200
From: Alex Riesen <Alexander.Riesen@synopsys.com>
To: Mark Atwood <mra@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How can a process easily get a list of all it's open fd?
Message-ID: <20020828082845.GB16092@riesen-pc.gr05.synopsys.com>
Reply-To: Alexander.Riesen@synopsys.com
Mail-Followup-To: Mark Atwood <mra@pobox.com>,
	linux-kernel@vger.kernel.org
References: <200208270138.g7R1ckGx001985@eeyore.valparaiso.cl> <m38z2s1fkj.fsf@khem.blackfedora.com> <20020827160842.GA16092@riesen-pc.gr05.synopsys.com> <20020827212638.GB7541@bluemug.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020827212638.GB7541@bluemug.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2002 at 02:26:38PM -0700, Mike Touloumtzis wrote:
> On Tue, Aug 27, 2002 at 06:08:42PM +0200, Alex Riesen wrote:
> > tricky. You can use /proc/<getpid>/fd, and close all
> > handles listed here, but this has some caveats:
> > it's _very_ slow if you have many open files.
> > it's not portable.
> > it's not safe if you have a thread/signal handler running.
> > 
> > i never heard of a right way to do this.
> > 
> > -alex
> > 
> > int close_all_fd()
> > {
> >     char fdpath[PATH_MAX];
> >     DIR * dp;
> >     struct dirent * de;
> >     int fd;
> > 
> >     sprintf(fdpath, "/proc/%d/fd", getpid());
> >     dp = opendir(fdpath);
> 
> This can just be:
> 
> 	dp = opendir("/proc/self/fd/");
> 
> then you don't need fdpath.

Oh, indeed.

> You can use sigprocmask() if you're worried about signals coming
> in during this operation.

I, personally, strongly dislike this option.
You never know which signals are to be blocked.

Besides, it's still not portable and not safe agains threads.


-alex
