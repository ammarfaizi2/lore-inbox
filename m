Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267453AbTBKQ7h>; Tue, 11 Feb 2003 11:59:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267727AbTBKQ7h>; Tue, 11 Feb 2003 11:59:37 -0500
Received: from air-2.osdl.org ([65.172.181.6]:16598 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S267453AbTBKQ7g>;
	Tue, 11 Feb 2003 11:59:36 -0500
Subject: Re: Kexec, DMA, and SMP
From: Stephen Hemminger <shemminger@osdl.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Kenneth Sumrall <ken@mvista.com>, suparna@in.ibm.com,
       Corey Minyard <cminyard@mvista.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lkcd-devel@lists.sourceforge.net
In-Reply-To: <m1y94nxv4e.fsf@frodo.biederman.org>
References: <3E448745.9040707@mvista.com>
	 <m1isvuzjj2.fsf@frodo.biederman.org> <3E45661A.90401@mvista.com>
	 <m1d6m1z4bk.fsf@frodo.biederman.org> <20030210174243.B11250@in.ibm.com>
	 <m18ywoyq78.fsf@frodo.biederman.org> <3E48536B.272E5630@mvista.com>
	 <m1y94nxv4e.fsf@frodo.biederman.org>
Content-Type: text/plain
Organization: Open Source Devlopment Lab
Message-Id: <1044983350.17351.50.camel@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 11 Feb 2003 09:09:10 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-02-10 at 21:08, Eric W. Biederman wrote:
> Kenneth Sumrall <ken@mvista.com> writes:
> 
> > > Suparna Bhattacharya <suparna@in.ibm.com> writes:
> 
> > > Agreed.  I guess the primary question is can we trust the current
> > > device shutdown + reboot notifier path or do we need to make some
> > > large changes to avoid it.
> > > 
> > So are the functions registered on the reboot notifier path guaranteed
> > to be non-blocking?  In the kexec on panic case, calls that can block
> > would obviously be a bad thing.  If they can block, perhaps we could add
> > a new flag SYS_PANIC or something like that to tell the driver to only
> > do a non-blocking shutdown of the chip.
> 
Some of the network shutdown reboot notifiers can block.
I found this out the hard way when trying to convert notifiers to use RCU
and discovered many warnings.  So many that the effort was abandoned. 

