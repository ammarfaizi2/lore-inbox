Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314921AbSDVXYI>; Mon, 22 Apr 2002 19:24:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314925AbSDVXYH>; Mon, 22 Apr 2002 19:24:07 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:29657 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S314921AbSDVXYG>;
	Mon, 22 Apr 2002 19:24:06 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15556.39759.233162.276172@argo.ozlabs.ibm.com>
Date: Tue, 23 Apr 2002 09:22:55 +1000 (EST)
To: george anzinger <george@mvista.com>
Cc: Robert Love <rml@tech9.net>, linux-kernel@vger.kernel.org
Subject: Re: in_interrupt race
In-Reply-To: <3CC48321.5855B08A@mvista.com>
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

george anzinger writes:

> > On Sat, 2002-04-20 at 06:27, Paul Mackerras wrote:
> > > One idea I had is to use a couple of bits in
> > > current_thread_info()->flags to indicate whether local_irq_count and
> > > local_bh_count are non-zero for the current cpu.  These bits could be
> > > tested safely without having to disable preemption.
> 
> Preemption lock is implied by either of these being != 0, so this seems
> consistant, but why not the whole counter?

Putting local_bh_count in the thread_info struct is easy and I have
done that locally here.

Putting local_irq_count in the thread_info struct means we would have
to do irqs_running() differently.  There is a brlock allocated for
BR_GLOBALIRQ_LOCK, which is used on some architectures.  Using that
would probably help.

Paul.
