Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132208AbRCVWHT>; Thu, 22 Mar 2001 17:07:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132214AbRCVWHK>; Thu, 22 Mar 2001 17:07:10 -0500
Received: from nat-pool.corp.redhat.com ([199.183.24.200]:45076 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S132208AbRCVWG7>; Thu, 22 Mar 2001 17:06:59 -0500
Message-ID: <3ABA7851.AB080D44@redhat.com>
Date: Thu, 22 Mar 2001 17:10:25 -0500
From: Doug Ledford <dledford@redhat.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.17-11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Stephen Clouse <stephenc@theiqgroup.com>,
        Guest section DW <dwguest@win.tue.nl>,
        Rik van Riel <riel@conectiva.com.br>,
        "Patrick O'Rourke" <orourke@missioncriticallinux.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Prevent OOM from killing init
In-Reply-To: <E14gCYn-0003K3-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > Really the whole oom_kill process seems bass-ackwards to me.  I can't in my mind
> > logically justify annihilating large-VM processes that have been running for
> > days or weeks instead of just returning ENOMEM to a process that just started
> > up.
> 
> How do you return an out of memory error to a C program that is out of memory
> due to a stack growth fault. There is actually not a language construct for it

Simple, you reclaim a few of those uptodate buffers.  My testing here has
resulting in more of my system daemons getting killed than anything else, and
it never once has solved the actual problem of simple memory pressure from
apps reading/writing to disk and disk cache not releasing buffers quick
enough.

> > It would be nice to give immunity to certain uids, or better yet, just turn the
> > damn thing off entirely.  I've already hacked that in...errr, out.
> 
> Eventually you have to kill something or the machine deadlocks. The oom killing
> doesnt kick in until that point. So its up to you how you like your errors.

I beg to differ.  If you tell me that a machine that looks like this:

[dledford@monster dledford]$ free
             total       used       free     shared    buffers     cached
Mem:       1017800    1014808       2992          0      73644     796392
-/+ buffers/cache:     144772     873028
Swap:            0          0          0
[dledford@monster dledford]$ 

is in need of killing sshd, I'll claim you are smoking some nice stuff ;-)

-- 

 Doug Ledford <dledford@redhat.com>  http://people.redhat.com/dledford
      Please check my web site for aic7xxx updates/answers before
                      e-mailing me about problems
