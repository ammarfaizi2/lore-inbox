Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272086AbRH2Vil>; Wed, 29 Aug 2001 17:38:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272087AbRH2ViW>; Wed, 29 Aug 2001 17:38:22 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:58375 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S272086AbRH2ViG>; Wed, 29 Aug 2001 17:38:06 -0400
Message-ID: <3B8D60CF.A1400171@zip.com.au>
Date: Wed, 29 Aug 2001 14:38:23 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: David Rees <dbr@greenhydrant.com>
CC: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        ext3-users@redhat.com
Subject: Re: kupdated, bdflush and kjournald stuck in D state on RAID1 device 
 (deadlock?)
In-Reply-To: <20010829131720.A20537@greenhydrant.com> <3B8D54F3.46DC2ABB@zip.com.au>,
		<3B8D54F3.46DC2ABB@zip.com.au>; from akpm@zip.com.au on Wed, Aug 29, 2001 at 01:47:47PM -0700 <20010829141451.A20968@greenhydrant.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Rees wrote:
> 
> On Wed, Aug 29, 2001 at 01:47:47PM -0700, Andrew Morton wrote:
> >
> > Certainly seems that way.
> >
> > Can you please send the output of
> >
> >       ps xwo pid,command,wchan
> >
> > Also, try a SYSRQ-T and, if the result makes it into the
> > logs, please pass it through `ksymoops -m System.map'.
> 
> OK, here's the ps output:
> 
> # ps xwo pid,command,wchan
>   PID COMMAND          WCHAN
>     1 init [3]         do_select
>     2 [keventd]        context_thread
>     3 [ksoftirqd_CPU0] ksoftirqd
>     4 [kswapd]         kswapd
>     5 [kreclaimd]      kreclaimd
>     6 [bdflush]        raid1_alloc_r1bh
>     7 [kupdated]       log_wait_commit
>     9 [mdrecoveryd]    md_thread
>    10 [raid1d]         md_thread
>    11 [kjournald]      kjournald
>   130 [kjournald]      kjournald
>   131 [kjournald]      wait_on_buffer
>   374 syslogd -m 0     do_select

OK, thanks.  bdflush is stuck in raid1_alloc_r1bh() and
everything else is blocked by it.  I thought we fixed 
that a couple of months ago :(

Could you send the output of `cat /proc/meminfo'?

> 18239 -bash            wait4
> 18274 umount /opt      rwsem_down_write_failed

What are we trying to do here?  Is /opt the deadlocked
filesytem?
