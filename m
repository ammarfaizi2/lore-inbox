Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267367AbTA1PgV>; Tue, 28 Jan 2003 10:36:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267377AbTA1PgV>; Tue, 28 Jan 2003 10:36:21 -0500
Received: from crack.them.org ([65.125.64.184]:34219 "EHLO crack.them.org")
	by vger.kernel.org with ESMTP id <S267367AbTA1PgU>;
	Tue, 28 Jan 2003 10:36:20 -0500
Date: Tue, 28 Jan 2003 10:45:41 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: MAEDA Naoaki <maeda.naoaki@jp.fujitsu.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PID of multi-threaded core's file name is wrong in 2.5.59
Message-ID: <20030128154541.GA7269@nevyn.them.org>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	MAEDA Naoaki <maeda.naoaki@jp.fujitsu.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030125.135611.74744521.maeda@jp.fujitsu.com> <1043756485.1328.26.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1043756485.1328.26.camel@dhcp22.swansea.linux.org.uk>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 28, 2003 at 12:21:25PM +0000, Alan Cox wrote:
> On Sat, 2003-01-25 at 04:56, MAEDA Naoaki wrote:
> > Hi,
> > 
> > I found sometimes pid of muitl-threaded core's file name shows
> > wrong number in 2.5.59 with NPTL-0.17. Problem is, pid of core file
> > name comes from currnet->pid, but I think it should be current->tgid.
> 
> The value needs to be unique so that you can dump multiple threads
> at the same time and not have one overwrite another. You might want
> to add the tgid as another format type to the core name formatting so
> users can select the behaviour you desire however ?

I think this isn't an issue; multi-threaded core dumps are done by
the core_waiter synchronization, so all other threads will have exited
before the first thread to crash actually writes out its core.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
