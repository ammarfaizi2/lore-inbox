Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271386AbTGRJWN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 05:22:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271397AbTGRJWN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 05:22:13 -0400
Received: from izanami.macs.hw.ac.uk ([137.195.13.6]:37570 "EHLO
	izanami.macs.hw.ac.uk") by vger.kernel.org with ESMTP
	id S271386AbTGRJWL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 05:22:11 -0400
From: Ross Macintyre <raz@macs.hw.ac.uk>
To: Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-megaraid-devel@dell.com,
       salvini@macs.hw.ac.uk, donald@macs.hw.ac.uk
In-Reply-To: <200307161601.h6GG1IR25744@devserv.devel.redhat.com>
Message-ID: <SIMEON.10307181006.C@pcraz.macs.hw.ac.uk>
Date: Fri, 18 Jul 2003 10:37:06 +0100 (GMT Daylight Time)
X-Mailer: Simeon for Win32 Version 4.1.4 Build (40)
X-Authentication: none
MIME-Version: 1.0
Subject: Re: new raid server crashed - no idea why!
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for replying Alan. Now I've got your attention, and I've checked 
some of the logs, maybe I can give you a bit more information and ask 
some other questions.

On Wed, 16 Jul 2003 12:01:18 -0400 (EDT) Alan Cox <alan@redhat.com> 
wrote:

> > RedHat 8.0 software and the latest raid drivers from LSILogic.
> > The spec of the machine is dual processor - AMD MP 2400+ with
> > LSILogic MegaRAID 320-2, and adaptec ultra wide scsi.
> 
> The data roughly speaking says "it broke". Its not useful log data
> alas.
> 
> >   BIOS failed to enable PCI standards compliance, fixing this error.
> >   mtrr: your CPUs had inconsistent fixed MTRR settings
> >   mtrr: probably your BIOS does not setup all CPUs)
> 
> Linux fixed both of these up. The former may indicate old BIOS rather
> than anything much to worry about

I'm not too concerned about these but I thought I'd mention them. I 
applied the latest BIOS update but these messages didn't disappear.

> 
> 
> If its a dual athlon run memtest86 on it for a few hours - thats my first
> guess fro the traces and the fact the dual athlons are infamously 
> sensitive about ram

Could you be a bit more specific about this please?

This isn't so easy for me to do as it means taking my main server down 
for a while but I will do this if I need to. I have a machine which is 
a clone of the problem machine that isn't live, and if need be, I could 
swap the memory about and run memtest86 on the problem machine's memory 
in the other machine. (I am assuming here that the machine needs to be 
shut down to run memtest86?)

I have run 'lastcomm' on the machine that had to be reset, and found 
this:

initlog                 root     ??         0.00 secs Wed Jul 16 10:23
initlog                 root     ??         0.00 secs Wed Jul 16 10:23
accton            S     root     ??         0.00 secs Wed Jul 16 10:23
kswapd             F    root     ??       15385.60 secs Mon Jun 23 12:12
automount          F    root     ??         0.00 secs Tue Jul 15 23:14
portmap            F    rpc      ??         0.00 secs Tue Jul 15 23:14
automount          F    root     ??         0.00 secs Tue Jul 15 23:14

(The machine was reset on Wed Jul 16 10:23)
This suggests to me that kswapd stopped and was the last process to run 
on the machine, which is also what the kernel trace in message log 
suggested. What I have done is check the swap area by remaking it with 
'mkswap -c' but it passed this test ok. 
I feel I really need to get to the bottom of this as this machine will 
be the home server for everyone in this department and I can't afford 
to have it crashing on me, but before I test the memory, I want to have 
looked at all the other possibilities first.

Any more suggestions?
Thanks in advanve,

Ross

--
Ross Macintyre
Heriot-Watt University
raz@macs.hw.ac.uk

