Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267399AbRGLBPH>; Wed, 11 Jul 2001 21:15:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267398AbRGLBO5>; Wed, 11 Jul 2001 21:14:57 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:56758 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S267399AbRGLBOs>; Wed, 11 Jul 2001 21:14:48 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Peter Zaitsev <pz@spylog.ru>
Date: Thu, 12 Jul 2001 11:14:24 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15180.63984.722843.539959@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Re[2]: Is  Swapping on software RAID1 possible  in linux 2.4 ?
In-Reply-To: message from Peter Zaitsev on Thursday July 5
In-Reply-To: <1011478953412.20010705152412@spylog.ru>
	<15172.22988.643481.421716@notabene.cse.unsw.edu.au>
	<11486070195.20010705172249@spylog.ru>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday July 5, pz@spylog.ru wrote:
> Hello Neil,
> 
> Thursday, July 05, 2001, 4:13:00 PM, you wrote:
> 
> NB> On Thursday July 5, pz@spylog.ru wrote:
> >> Hello linux-kernel,
> >> 
> >>   Does anyone have information on this subject ?  I have the constant
> >>   failures with system swapping on RAID1, I just wanted to be shure
> >>   this may be the problem or not.   It works without any problems with
> >>   2.2 kernel.
> 
> NB> It certainly should work in 2.4.  What sort of "constant failures" are
> NB> you experiencing?
> 
> NB> Though it does appear to work in 2.2, there is a possibility of data
> NB> corruption if you swap onto a raid1 array that is resyncing.  This
> NB> possibility does not exist in 2.4.
> 
> 
> 
> The problem is I'm constantly getting these  X-order-allocation errors
> in kernel log and after which system becomes unstable and often hangs
> or leaves process which cannot be killed even by "-9" signal.
> Installed debuggin patches produce the following allocation paths:

These "X-order-allocation" failures are just an indication that you
are running out or memory.  raid1 is explicitly written to cope.
If memory allocation fails it waits for some to be free, and it has
made sure in advance that there is some memory that it will get
first-dibs on when it becomes free, so there is no risk of deadlock.

However this does not explain why you are getting unkillable
processes.

Can you try to put swap on just one of the partitions that your raid1
together instead of on the raid1 array and see if you can get
processes to become unkillable.

Also, can you find out what that process is doing when it is
unkillable.
If you compile with alt-sysrq support, then alt-sysrq-t should print
the process table.  If you can get this out of dmesg and run if though
ksymoops it might be most interesting.

NeilBrown
