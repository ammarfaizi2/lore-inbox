Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292320AbSCMRYJ>; Wed, 13 Mar 2002 12:24:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293680AbSCMRX7>; Wed, 13 Mar 2002 12:23:59 -0500
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:35336 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S292991AbSCMRXn>; Wed, 13 Mar 2002 12:23:43 -0500
Date: Wed, 13 Mar 2002 18:23:40 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: "Adam J. Richter" <adam@yggdrasil.com>, linux-kernel@vger.kernel.org
Subject: Re: IDE(?) lockups in 2.5.7pre1, 2.5.6, 2.5.6pre3
Message-ID: <20020313182340.B31062@ucw.cz>
In-Reply-To: <200203131533.HAA09497@adam.yggdrasil.com> <3C8F7292.5080409@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C8F7292.5080409@evision-ventures.com>; from dalecki@evision-ventures.com on Wed, Mar 13, 2002 at 04:38:58PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2002 at 04:38:58PM +0100, Martin Dalecki wrote:

> Adam J. Richter wrote:
> > 	Under 2.5.6-pre3 and 2.5.6, my desktop workstation would
> > occasionally get into a state where all disk I/O would block.
> > Process would run until they had to go to the disk, and then they
> > would stop.  Hitting ctrl-<scroll lock> shows these process in "D"
> > state.  The IDE controller in this machine is:
> > 
> > 00:07.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev 06)
> > 
> > 	I just built 2.5.7-pre1 and have discovered the other machne
> > that has a VIA IDE controller developed the same problem just after
> > printing its first "login: " prompt, although it did not have the problem
> > on a subsequent reboot.  This other machine did not lock up with
> > 2.5.6-pre3 or 2.5.6, although that is probably just due to random
> > chance, as the problem was occurring only once a day.  The
> > IDE controller in this second machine is:
> > 
> > 00:04.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev 10)
> > 
> > 	I will try to track this down from the process stack traces
> > when it happens next, but I thought I ought to report it in the meantime.
> > 
> 
> You may have noted that I'm gradually trying to replace
> all cli() sti() stuff, where it's using for data structure
> access by proper spin locks on ide_lock. Maybe this just
> uncovered something which was hidden by the brute force used
> before? (Could you possible have a look at this direction?)

I have a similar report with 2.5.6 and PIIX from  Helge Hafting
<helgehaf@aitel.hist.no>:

	I saw nothing unusual until I tried a simple benchmark:

	# hdparm -t /dev/hda

	Nothing happened with the disk, the process
	got stuck in D state immediately and just sits there.

	The drives works though, "ls -R" works for partitions
	on either drive.

It looks like you uncovered or created some race ...

-- 
Vojtech Pavlik
SuSE Labs
