Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267770AbUHJWKL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267770AbUHJWKL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 18:10:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267776AbUHJWKL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 18:10:11 -0400
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:49346
	"EHLO animx.eu.org") by vger.kernel.org with ESMTP id S267770AbUHJWHM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 18:07:12 -0400
Date: Tue, 10 Aug 2004 18:05:28 -0400
From: Wakko Warner <wakko@animx.eu.org>
To: Alan Jenkins <sourcejedi@phonecoop.coop>
Cc: linux-kernel@vger.kernel.org
Subject: Re: cd burning: kernel / userspace?
Message-ID: <20040810220528.GA17537@animx.eu.org>
References: <41189AA2.3010908@phonecoop.coop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41189AA2.3010908@phonecoop.coop>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I've followed the latest cdrecord "discussion" on the list, and I can't 
> see why you have to use a userspace program which talks SCSI in order to 
> burn a cd.

I agree.

> Why can't a similar method be used for DAO writing?  Packet writing and 
> Mount Rainer support belongs in the kernel - why not normal cd burning?  
> On modern "burnproof" hardware, it should be possible to use dd to write 
> your disk image to the cdrecorder device.  I'm guessing that this just 
> isn't as interesting, especially with userspace programs available to do 
> the job.

Disclamer: I'm not a kernel hacker.  Just looking at things on how they
appear to me...

I have thought about this myself.  Using CDR/RW with the UDF format would be
simply packet writing.  This is already supported with CDRWs.

However, I usually burn ISO instead of UDF.  How should these instances be
supported:

1) DAO (ISO image burned)
2) TAO single session with or without fixation.  I have burned audio disks
like this before where I would leave off the fixate option and keep burning,
each track is closed.
3) TAO multi session leaving disk open
4) TAO multi session closing disk (probably similar if not the same as 2)
5) blanking a CDRW (fast and/or slow)

Maybe something along the lines of IOCTLs that do these?  Wouldn't it seem
silly to:
cdrwcontrol DAO speed=40 burnproof ....
dd if=my.iso of=/dev/scd0 (sorry, I'm a scsi guy =)

or cdrwcontrol TAO speed=40 ...
dd ..
cdrwcontrol fixate

Ok, enough rambling, I think the idea is out =)

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
