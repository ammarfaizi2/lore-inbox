Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263021AbUKYIuk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263021AbUKYIuk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Nov 2004 03:50:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263023AbUKYIuj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Nov 2004 03:50:39 -0500
Received: from pop.gmx.net ([213.165.64.20]:2747 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263021AbUKYIud (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Nov 2004 03:50:33 -0500
Date: Thu, 25 Nov 2004 09:50:32 +0100 (MET)
From: "Michael Kerrisk" <mtk-lkml@gmx.net>
To: Rik van Riel <riel@redhat.com>
Cc: hugh@veritas.com, chrisw@osdl.org, manfred@colorfullife.com,
       torvalds@osdl.org, akpm@osdl.org, michael.kerrisk@gmx.net,
       linux-kernel@vger.kernel.org
MIME-Version: 1.0
References: <Pine.LNX.4.61.0411242216210.10497@chimarrao.boston.redhat.com>
Subject: Re: Further shmctl() SHM_LOCK strangeness
X-Priority: 3 (Normal)
X-Authenticated: #23581172
Message-ID: <24718.1101372632@www65.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik,

> On Wed, 24 Nov 2004, Hugh Dickins wrote:
> 
> >> regardles of the segment's ownership or permissions,
> >> providing the size of the segment falls within the
> >> process's RLIMIT_MEMLOCK limit.
> 
> > Offhand I find it hard to grasp whether it's harmless or bad,
> > but inclined to think bad - if there happen to be lots of small
> > enough shared memory segments on the system, a series of processes
> > run by one unprivileged user can lock down lots of memory?
> 
> Mlocking and munlocking of shm segments is accounted
> against the user_struct, not against the process.
> 
> This should stop any malicious exploits.

As noted by Hugh, the problem also applies for
SHM_UNLOCK: anyone can unlock any System V shared 
memory segment.  If our reason for locking memory 
was security (no swapping), then this does allow
for exploits.

(Also, I just want to reemphasise that these semantics
are inconsistent with the types of ownership and 
permission checking performed for just about 
every other kind of System V "ctl" operation.)

Cheers,

Michael

-- 
Geschenkt: 3 Monate GMX ProMail + 3 Top-Spielfilme auf DVD
++ Jetzt kostenlos testen http://www.gmx.net/de/go/mail ++
