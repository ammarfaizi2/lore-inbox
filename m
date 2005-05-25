Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261587AbVEYWsK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261587AbVEYWsK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 18:48:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261588AbVEYWsK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 18:48:10 -0400
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:11420 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S261587AbVEYWsB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 18:48:01 -0400
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Thu, 26 May 2005 00:46:55 +0200
To: schilling@fokus.fraunhofer.de, linux-kernel@vger.kernel.org,
       7eggert@gmx.de
Subject: Re: OT] Joerg Schilling flames Linux on his Blog
Message-ID: <4295005F.nail2KW319F89@burner>
References: <4847F-8q-23@gated-at.bofh.it>
 <E1Db3zm-0004vF-9j@be1.7eggert.dyndns.org>
In-Reply-To: <E1Db3zm-0004vF-9j@be1.7eggert.dyndns.org>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Bodo Eggert <harvested.in.lkml@posting.7eggert.dyndns.org>" <7eggert@gmx.de> wrote:

> I just burned a CD on my IDE-burner using mmc_cdr with cdrtools-2.01
> (the one without the hack) on a vanilla 2.6.11.10. I can even scan
> both my SCSI and IDE devices using -dev=ATAPI, but not without -dev.

The unability to give this kind of convenience to cdrecord users is a result
of the refusal of the Linux kernel crew to include the kernel internal 
device instance numbers in the ioctl structures I need to read. Note that the
fields are there but the information is intentionally obscured for come of the 
calls just to make the life of cdrecord useers harder :-(


> (I'm running as user, and cdrecord has no need for suid bits.)

I am frequently reading false claims like this. Usually from people who 
do not have the needed SCSI background knowledge to understand that 
SCSI is a protocol where commands frequently fail by intention in order to
propagate a state or a implementation level to the application.

If you don't call cdrecord as root, you will not be able to lock in memory
and to raise priority in order to prevent buffer underuns. In addition (with 
Linux-2.6.8.1 or newer) you will not be able to send some of the important
SCSI commands mainly related to newer CD or DVD drives. As a result, cdrecord
cannot write DVDs or ultra speed CD-RWs or cannot do other things....


> > If Linux plans to implement incompatible changes, I would expect that
> > "important users" are informed in advance so that it is possible to discuss
> > the problems an to have a planned smooth migration.
>
> While, in the meantime, users can destroy the hardware.

Not true: if only R/W fd would be allowed, no non root program could do that.

>
> <OT>
>
> BTW while talking about destroying hardware: Turning off burnproof so the
> drives that have this feature _for a reason_ will destroy my CD-Rs like
> a outdated CD-recorder would is doubleplusungood, even if it creates
> consistent behaviour across drives. It's like waring no seat belt in
> your car just because curricles didn't have them. ¢¢
>
> </OT>

See above, this false claim is a result of the fact that you miss the background
knowledge on CD/DVD writing. Turning burnproof on degrades the quality of the 
media and writing without burnproof but with the apropriate privilleges just
works fine.


> There are other uses for write access to devices. Disabeling SCSI commands
> for r/o fds would only be a quickfix. (IMHO it could have been introduced
> as a config option and gone away in 2.6.13.)

The good/bad SCSI commands table that is currently used is a really bad and
ugly (incorrect) hack and much worse than my proposal.


> > P.S.: About 10 days ago, I made an attempt to include a workaround for the
> > interface changes in Linux, check cdrtools-2.01.01a03
>
> The fix is wrong: You're asuming root is capable of everything. This
> doesn't need to be true (missing CAP_SYS_RAWIO) and you'll run into a
> loop in that case.

If you are really true, then there is a design problem in Linux.

BTW: If Linux starts introducing fine grained rights manamement like on Solaris, why 
does it miss the apropriate management tools at user level?
On Solaris, I could run cdrecord rootless if I use pfksh as my shell and if
the roles database would include cdrecord with its needed privilleges and me
as a member of the cdwriters role.

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de		(uni)  
       schilling@fokus.fraunhofer.de	(work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
