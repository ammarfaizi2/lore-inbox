Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751324AbWA0Ofe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751324AbWA0Ofe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 09:35:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751326AbWA0Ofe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 09:35:34 -0500
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:42432 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S1751324AbWA0Ofd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 09:35:33 -0500
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Fri, 27 Jan 2006 15:30:17 +0100
Cc: mrmacman_g4@mac.com, matthias.andree@gmx.de, linux-kernel@vger.kernel.org,
       acahalan@gmail.com
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <43DA2E79.nailFM911AZXH@burner>
References: <787b0d920601241858w375a42efnc780f74b5c05e5d0@mail.gmail.com>
 <43D7A7F4.nailDE92K7TJI@burner>
 <8614E822-9ED1-4CB1-B8F0-7571D1A7767E@mac.com>
 <43D7B1E7.nailDFJ9MUZ5G@burner>
 <20060125230850.GA2137@merlin.emma.line.org>
 <43D8C04F.nailE1C2X9KNC@burner> <20060126161028.GA8099@suse.cz>
In-Reply-To: <20060126161028.GA8099@suse.cz>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik <vojtech@suse.cz> wrote:

> > The only integrative (and this useful for libscg) interface on Linux is /dev/sg*
> > 
> > /dev/hd* may look nice if you only look skin-deep
> > 
> > How do you e.g. like send SCSI commands to ATAPI tape drives on Linux?
>  
> I see you asking this again and again, and you seem to want to hear this
> answer: "You don't." I haven't checked the code, but I guess the SG_IO
> interface isn't available there. And I don't think this is a problem,
> because a) if it was needed, it can be added trivially with minimum
> added code, b) ATAPI tapes are dead, much the way ATAPI floppies are.

Nice to see that agree that sending SCSI via /dev/hd* is a hack with limited 
benefit.

Maybe (now that we did agree about the way to go) it makes sense to start 
discussing which bugs in Linux need to be fixed in order to close e.g.
the Bugs in the Debian bug tracking system for cdrtools that are related to the 
Linux kernel.

This are the three most important Linux kernel bugs:

-	ide-scsi does not do DMA if the DMAsize is not a multiple of 512
	A person who knows internal Linux structures shoule be able
	to fix this (and allow any multiple of 4) in less than one hour.
	If we sum up the time spend on this discussoion, I really cannot
	understand why this has not been fixed earlier.

-	/dev/hd* artificially prevents the ioctls SCSI_IOCTL_GET_IDLUN
	SCSI_IOCTL_GET_BUS_NUMBER from returning useful values.
	As long as this bug is present, there is no way to see SG_IO 
	via /dev/hd* as integral part of the Linux SCSI transport concept.

-	If sending SCSI sia ATAPI, Linux under certain unknown conditions
	bastardizes the content of SCSI commands. A possible reason may be
	that it sends random data in the remainder between the actual 
	SCSI cdb size and the ATAPI SCSI cdb size.

	ATAPI drives that verify SCSI cdb's for correctness fail in this
	case.

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
