Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130606AbRCGJoi>; Wed, 7 Mar 2001 04:44:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130820AbRCGJo2>; Wed, 7 Mar 2001 04:44:28 -0500
Received: from isis.its.uow.edu.au ([130.130.68.21]:51848 "EHLO
	isis.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S130606AbRCGJoT>; Wed, 7 Mar 2001 04:44:19 -0500
Message-ID: <3AA602E1.3A22392@uow.edu.au>
Date: Wed, 07 Mar 2001 20:44:01 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.2-pre2 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Mike Galbraith <mikeg@wen-online.de>
CC: Vibol Hou <vhou@khmer.cc>, Linux-Kernel <linux-kernel@vger.kernel.org>,
        balbir@reflexnet.net, hahn@coffee.psychology.mcmaster.ca
Subject: Re: System slowdown on 2.4.2-ac5 (recurring from 2.4.1-ac20 and2.4.0)
In-Reply-To: <NDBBKKONDOBLNCIOPCGHAEAEFDAA.vhou@khmer.cc> <Pine.LNX.4.33.0103070939011.1305-100000@mikeg.weiden.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Galbraith wrote:
> 
> On Tue, 6 Mar 2001, Vibol Hou wrote:
> 
> > Hi,
> >
> > This is a follow up report on a server I run which is now using 2.4.2-ac5.
> > It was suggested that the problem might be a NIC driver issue, but that
> > seems unlikely at this point.
> >
> > You can find my previous posts at the following links to get a better idea
> > of what I am encountering:
> >
> > http://www.uwsg.indiana.edu/hypermail/linux/kernel/0101.3/0470.html
> > http://www.uwsg.indiana.edu/hypermail/linux/kernel/0102.3/0401.html
> >
> > The problem still persists with the new 2.4.2-ac5 kernel, and I have a
> > feeling it has to do with the VM subsystem.  The system runs Apache, MySQL,
> > and Sendmail.  It has ~900MB RAM.  The first lockup in 2.4.2-ac5 occured
> 
> Hi,
> 
> This portion of your log...
> 
> ...
> 
> ...leads me to believe that the NMI-Watchdog fired.

yes, it did.  But this is not the problem.  The log was 
captured on a serial console.  Doing an ALT_SYSRQ-T (or
BREAK/T) will cause a large amount of output to be written
to the serial port while interrupts are disabled.  It
takes so long that the NMI watchdog decides the CPU
is stuck.

Actually, I think the remove-the-console-lock patch which
went into 2.4.2-ac13 will fix this - timer interrupts
should now continue to be serviced while the task table
is being dumped out.

I'm going to pretend I meant this to happen :)

I note that the Mem-info dump only shows the page table cache
size for the local CPU.  It should be showing the info for all
CPUs. Minor thing.

But the failing of Vibol's server remains a mystery.  I suggest
an upgrade to 2.4.2-ac13 would be worthwhile - at least we'll
get a full task table dump.


-
