Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263020AbUKYIpy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263020AbUKYIpy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Nov 2004 03:45:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263021AbUKYIpy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Nov 2004 03:45:54 -0500
Received: from mail.gmx.net ([213.165.64.20]:47811 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263020AbUKYIpp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Nov 2004 03:45:45 -0500
Date: Thu, 25 Nov 2004 09:45:44 +0100 (MET)
From: "Michael Kerrisk" <mtk-lkml@gmx.net>
To: Hugh Dickins <hugh@veritas.com>
Cc: riel@redhat.com, chrisw@osdl.org, manfred@colorfullife.com,
       torvalds@osdl.org, akpm@osdl.org, michael.kerrisk@gmx.net,
       linux-kernel@vger.kernel.org
MIME-Version: 1.0
References: <Pine.LNX.4.44.0411242124400.2769-100000@localhost.localdomain>
Subject: Re: Further shmctl() SHM_LOCK strangeness
X-Priority: 3 (Normal)
X-Authenticated: #23581172
Message-ID: <5639.1101372344@www65.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh,

> On Wed, 24 Nov 2004, Michael Kerrisk wrote:
> > 
> > While studying the RLIMIT_MEMLOCK stuff further, I came 
> > up with another observation: a process can perform a
> > shmctl(SHM_LOCK) on *any* System V shared memory segment, 
> > regardles of the segment's ownership or permissions,
> > providing the size of the segment falls within the 
> > process's RLIMIT_MEMLOCK limit.
> 
> That's a very good observation.

Thanks.

> I think it's unintended, but I'm not sure.
> I've forgotten what can_do_mlock on shm was about.

can_do_mlock() returns true if we have CAP_IPC_LOCK 
or RLIMIT_MEMLOCK != 0.

> Offhand I find it hard to grasp whether it's harmless or bad,
> but inclined to think bad - if there happen to be lots of small
> enough shared memory segments on the system, a series of processes
> run by one unprivileged user can lock down lots of memory?
> 
> Isn't it further the case that any process can now SHM_UNLOCK
> any segment?  

I hadn't got as far as thinking about that, but you are 
correct. Anyone can SHM_UNLOCK a System V shared memory 
segment on 2.6.9, regardless of ownership and permissions.

> That would surely be wrong.

Agreed.  

Cheers,

Michael

> I've added Rik and Chris to the CC list, they seem to be the
> main can_do_mlock guys, hope they can answer.
> 
> Hugh
> 
> > Is this intended behaviour?  For most other System V IPC 
> > "ctl" operations the process must either:
> > 
> > 1. be the owner of the object or have an appropriate 
> >    capability, or
> > 
> > 2. have suitable permissions on the object.
> > 
> > Which of these two conditions applies depends on the
> > "ctl" operation.
> 

-- 
Geschenkt: 3 Monate GMX ProMail + 3 Top-Spielfilme auf DVD
++ Jetzt kostenlos testen http://www.gmx.net/de/go/mail ++
