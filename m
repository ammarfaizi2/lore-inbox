Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268872AbUHLXMv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268872AbUHLXMv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 19:12:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268865AbUHLXJw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 19:09:52 -0400
Received: from europa.pnl.gov ([130.20.248.195]:38528 "EHLO europa.pnl.gov")
	by vger.kernel.org with ESMTP id S268884AbUHLXIu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 19:08:50 -0400
Date: Thu, 12 Aug 2004 16:06:41 -0700
From: Kevin Fox <Kevin.Fox@pnl.gov>
Subject: Re: cd burning: kernel / userspace?
In-reply-to: <20040810220528.GA17537@animx.eu.org>
To: Wakko Warner <wakko@animx.eu.org>
Cc: Alan Jenkins <sourcejedi@phonecoop.coop>, linux-kernel@vger.kernel.org
Message-id: <1092352000.2408.35.camel@localhost.localdomain>
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2)
Content-type: text/plain
Content-transfer-encoding: 7bit
References: <41189AA2.3010908@phonecoop.coop>
 <20040810220528.GA17537@animx.eu.org>
X-OriginalArrivalTime: 12 Aug 2004 23:08:43.0312 (UTC)
 FILETIME=[500A6B00:01C480C1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Why not use an interface similar to tapes? Have different devices for
different modes of operation?

On Tue, 2004-08-10 at 15:05, Wakko Warner wrote:
> > I've followed the latest cdrecord "discussion" on the list, and I can't 
> > see why you have to use a userspace program which talks SCSI in order to 
> > burn a cd.
> 
> I agree.
> 
> > Why can't a similar method be used for DAO writing?  Packet writing and 
> > Mount Rainer support belongs in the kernel - why not normal cd burning?  
> > On modern "burnproof" hardware, it should be possible to use dd to write 
> > your disk image to the cdrecorder device.  I'm guessing that this just 
> > isn't as interesting, especially with userspace programs available to do 
> > the job.
> 
> Disclamer: I'm not a kernel hacker.  Just looking at things on how they
> appear to me...
> 
> I have thought about this myself.  Using CDR/RW with the UDF format would be
> simply packet writing.  This is already supported with CDRWs.
> 
> However, I usually burn ISO instead of UDF.  How should these instances be
> supported:
> 
> 1) DAO (ISO image burned)
> 2) TAO single session with or without fixation.  I have burned audio disks
> like this before where I would leave off the fixate option and keep burning,
> each track is closed.
> 3) TAO multi session leaving disk open
> 4) TAO multi session closing disk (probably similar if not the same as 2)
> 5) blanking a CDRW (fast and/or slow)
> 
> Maybe something along the lines of IOCTLs that do these?  Wouldn't it seem
> silly to:
> cdrwcontrol DAO speed=40 burnproof ....
> dd if=my.iso of=/dev/scd0 (sorry, I'm a scsi guy =)
> 
> or cdrwcontrol TAO speed=40 ...
> dd ..
> cdrwcontrol fixate
> 
> Ok, enough rambling, I think the idea is out =)
