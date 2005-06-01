Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261477AbVFARbO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261477AbVFARbO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 13:31:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261479AbVFARbN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 13:31:13 -0400
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:28339 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S261477AbVFARa0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 13:30:26 -0400
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Wed, 01 Jun 2005 19:29:02 +0200
To: schilling@fokus.fraunhofer.de, matthias.andree@gmx.de
Cc: toon@hout.vanvergehaald.nl, mrmacman_g4@mac.com, ltd@cisco.com,
       linux-kernel@vger.kernel.org, dtor_core@ameritech.net, 7eggert@gmx.de
Subject: Re: OT] Joerg Schilling flames Linux on his Blog
Message-ID: <429DF05E.nail7BFP1FOVB@burner>
References: <26A66BC731DAB741837AF6B2E29C10171E60DE@xmb-hkg-413.apac.cisco.com>
 <20050530093420.GB15347@hout.vanvergehaald.nl>
 <429B0683.nail5764GYTVC@burner>
 <46BE0C64-1246-4259-914B-379071712F01@mac.com>
 <429C4483.nail5X0215WJQ@burner> <20050531172204.GD17338@voodoo>
 <d120d500050531122879868bae@mail.gmail.com>
 <429DDA07.nail7BFA4XEC5@burner> <429DE087.606@gmx.de>
In-Reply-To: <429DE087.606@gmx.de>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Andree <matthias.andree@gmx.de> wrote:

> Heck. The whole issue is that cdrecord is unjustly complaining when it
> is given a device node that is perfect. For my 2.6.11 system, /dev/hdd
> (ATAPI hardware, ide-cd device) is as stable as it will get, yet
> cdrecord complains and attempts to coerce some numbering scheme that
> Linux isn't offering through /dev/*. Same story with FreeBSD, I need to
> figure out some intransparent ATAPI transport identifier rather than
> just using /dev/acd0.

Looks like you need to take a closer look at FreeBSD. Cdrecord 
implements a completely _native_ interface to the FreeBSD SCSI drivers.
Cdrecord uses _exaclty_ the official way of addressing which is
(you may wonder) identical to what my SCSI libraries did since
August 1986 and what many other OS use too.

Also note that this interface is SCSI standard compliant (check the CAM
standard). Also note that the libscg interface to FreeBSD has been implemented
in close collaboration between me and the author of the FreBSD SCSI
subsystem. There was never even a slight wish for having a different
interface than the one that is used by libscg on FreeBSD.

And yes, in former times the implementor of ATAPI on FreeBSD made similar
mistakes as have been made on Linux. He did even write a kernel based 
CD writing driver but people did like to do things that have not been
implemented by his driver but by cdrecord (like writing CDs in RAW
mode or writing DVDs). It even turned eventually out that he did 
secretly sell a modified version of cdrecord to his customers that
did use a secret SCSI pass though interface in his driver, but the
patch he made to cdrecord was ugly (like smashing the window to get
into the house although the door nearby was wide open...).

Then someone from France take some time and implemented an 
ATPAI-CAM module that now is the standard on FreeBSD.



> So your first step to pull the rug from underneath most of this
> discussion is just to disable this unnecessary warning for the ATA:
> interface, whether it is
>
> 	Warning: Open by 'devname' is unintentional and not supported.
>
> or
>
> 	Warning: Using badly designed ATAPI via /dev/hd* interface.

First a note: using /dev/* _is_ wrong because using /dev/* is a way to
tell cdda2wav to switch to the Audio ioctl based interface wich gives
bad DAE quality compeared to the method that uses SCSI pass though.

-	dev=/dev/* uses an interface with driver abstraction

-	dev=b,t,l uses the Generic SCSI interfcace

Take this as a fact that has been true for a long long time and definitely
predates recent Linux interface changes.


> This is your personal vendetta against Linux device naming or numbering,
>  hence policy, and not a technical reason to complain. Particularly, if
> cdrecord can use the device node, it MUST not print a warning, if you
> think it's intentional or not.

Wrong, this is a result of the fact that the Linux kernel by intention
and unneccesarily hides useful information that is of course available in
different interfaces like e.g. /proc. So what Linux does is a bump against
me and what you see is just a "passive" reaction.


> Please remove these two warnings and you'll see a considerable part of
> the discussion end.

What you see is a "passive" reaction on thrusts agianst me. At the first time,
I see a minimal kind of willinglness to cooperate, things could go completely
different...

Well, this is the first useful and non-personal thread on LKML I did ever see,
so I am in hope something may change.

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de		(uni)  
       schilling@fokus.fraunhofer.de	(work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
