Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284674AbRLIXpl>; Sun, 9 Dec 2001 18:45:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284662AbRLIXpb>; Sun, 9 Dec 2001 18:45:31 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:34014 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S284671AbRLIXpP>; Sun, 9 Dec 2001 18:45:15 -0500
Date: Sun, 9 Dec 2001 14:44:33 -0800
From: Mike Kravetz <kravetz@us.ibm.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Davide Libenzi <davidel@xmailserver.org>,
        Rusty Russell <rusty@rustcorp.com.au>, anton@samba.org, davej@suse.de,
        marcelo@conectiva.com.br, lkml <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: Linux 2.4.17-pre5
Message-ID: <20011209144433.B1087@w-mikek2.sequent.com>
In-Reply-To: <Pine.LNX.4.40.0112081824210.1019-100000@blue1.dev.mcafeelabs.com> <E16D6l9-00073R-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E16D6l9-00073R-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Sun, Dec 09, 2001 at 04:24:59PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 09, 2001 at 04:24:59PM +0000, Alan Cox wrote:
> I'm currently using the following rule in wake up
> 
> 	if(current->mm->runnable > 0)	/* One already running ? */
> 		cpu = current->mm->last_cpu;
> 	else
> 		cpu = idle_cpu();
> 	else
> 		cpu = cpu_num[fast_fl1(runnable_set)]
> 
> that is
> 	If we are running threads with this mm on a cpu throw them at the
> 		same core
> 	If there is an idle CPU use it
> 	Take the mask of currently executing priority levels, find the last
> 	set bit (lowest pri) being executed, and look up a cpu running at
> 	that priority
> 
> Then the idle stealing code will do the rest of the balancing, but at least
> it converges towards each mm living on one cpu core.

This implies that the idle loop will poll looking for work to do.
Is that correct?  Davide's scheduler also does this.  I believe
the current default idle loop (at least for i386) does as little
as possible and stops execting instructions.  Comments in the code
mention power consumption.  Should we be concerned with this?

-- 
Mike
