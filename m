Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271339AbRHQLQe>; Fri, 17 Aug 2001 07:16:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271427AbRHQLQY>; Fri, 17 Aug 2001 07:16:24 -0400
Received: from camus.xss.co.at ([194.152.162.19]:12548 "EHLO camus.xss.co.at")
	by vger.kernel.org with ESMTP id <S271339AbRHQLQH>;
	Fri, 17 Aug 2001 07:16:07 -0400
Message-ID: <3B7CFCF8.87A3968E@xss.co.at>
Date: Fri, 17 Aug 2001 13:16:08 +0200
From: Andreas Haumer <andreas@xss.co.at>
Organization: xS+S - *x Software + Systeme
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Wagner <daniel.wagner@xss.co.at>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: initrd: couldn't umount
In-Reply-To: <E15Xgr3-000775-00@the-village.bc.nu> <3B7CF68D.9694DD53@xss.co.at>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Daniel Wagner wrote:
> 
> Alan Cox wrote:
> >
> > > the problem is that a "rpciod" kernel-thread references the initrd,
> > > and so umounting and freeing it, isn't possible.
> > >
> > > has anybody an idea how to fix this problem, cause it would be nice,
> > > to free the initrd ram on a diskless node.
> >
> > It shouldnt be keeping a reference. daemonize() should have dropped its
> > resources
> 
> hmm, i've now created a /initrd directory to let the the change_root of
> the
> initrd work correctly.
> 
> and then i looked with fuser, what processes reference the initrd:
> 
> ---
> root@ws4:~ $ fuser -mv /initrd/
> 
>                      USER        PID ACCESS COMMAND
> /initrd/             root         67 .rc..
> rpciod
> ---
> 
> only the rpciod references the initrd, none of the other
> kernel-threads.
> 
Could it be because, when executed, rpciod() calls 
exit_files(current) and exit_mm(current), but doesn't
call exit_fs(current) (as, for instance, md_thread() does)? 
(we are talking 2.2.19 here)

We well try it in a few minutes... :-)

- andreas

-- 
Andreas Haumer                     | mailto:andreas@xss.co.at
*x Software + Systeme              | http://www.xss.co.at/
Karmarschgasse 51/2/20             | Tel: +43-1-6060114-0
A-1100 Vienna, Austria             | Fax: +43-1-6060114-71
