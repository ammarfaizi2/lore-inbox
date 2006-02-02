Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932181AbWBBRRF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932181AbWBBRRF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 12:17:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932180AbWBBRRF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 12:17:05 -0500
Received: from user-0c93tin.cable.mindspring.com ([24.145.246.87]:21131 "EHLO
	tsurukikun.utopios.org") by vger.kernel.org with ESMTP
	id S932182AbWBBRRE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 12:17:04 -0500
From: Luke-Jr <luke@dashjr.org>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: CD writing in future Linux (stirring up a hornets' nest) (was: Rationale for RLIMIT_MEMLOCK?)
Date: Thu, 2 Feb 2006 17:17:02 +0000
User-Agent: KMail/1.9
Cc: Matthias Andree <matthias.andree@gmx.de>,
       Lee Revell <rlrevell@joe-job.com>,
       Joerg Schilling <schilling@fokus.fraunhofer.de>,
       linux-kernel@vger.kernel.org
References: <20060123105634.GA17439@merlin.emma.line.org> <20060123212119.GI1820@merlin.emma.line.org> <Pine.LNX.4.61.0601241823390.28682@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0601241823390.28682@yvahk01.tjqt.qr>
Public-GPG-Key: 0xD53E9583
Public-GPG-Key-URI: http://dashjr.org/~luke-jr/myself/Luke-Jr.pgp
IM-Address: luke-jr@jabber.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Message-Id: <200602021717.08100.luke@dashjr.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 24 January 2006 17:42, Jan Engelhardt wrote:
> >2. find out the current state of affairs,
>
> I am currently able to properly write all sorts of CD-R/RW and DVD±R/RW,
> DVD-DL with no problems using
>     cdrecord -dev=/dev/hdb
> it _currently_ works, no matter how ugly or not this is from either Jörg's
> or any other developer's POV - therefore it's fine from the end-user's POV.

How did you manage to burn a dual layer disc? I have been completely 
unsuccessful at doing this at all. :(

> There have been reports that cdrecord does not work when setuid, but only
> when you are "truly root". Not sure where this comes from,
> (current->euid==0&&current->uid!=0 maybe?) scsi layer somewhere?

I didn't look into it, but my cdrecord seems to work fine as my normal user 
(writing via cdrw group w/ perms), but not with suid-root.

> I'm fine (=I agree) with the general possibility of having it setuid,
> though.

Provided it doesn't allow burning files the real-user shouldn't be able to 
access... But since cdrecord is commonly suid-root, I presume this has long 
been taken into consideration.

> SUSE currently does it in A Nice Way: setfacl'ing the devices to include
> read access for currently logged-in users. (Well, if someone logs on tty1
> after you, you're screwed anyway - he could have just ejected the cd when
> he's physically at the box.)

Aren't user-groups per-session anyway? Why not simply have the login program 
apply a 'localusers' group to all local sessions and set device permissions 
for that group? To add to the security, perhaps there is a way to remove the 
'localusers' permissions from all backgrounded processes (screen, etc) when 
the user logs out?

