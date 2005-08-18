Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932066AbVHROxS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932066AbVHROxS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 10:53:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750849AbVHROxS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 10:53:18 -0400
Received: from tiere.net.avaya.com ([198.152.12.100]:57280 "EHLO
	tiere.net.avaya.com") by vger.kernel.org with ESMTP
	id S1750823AbVHROxS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 10:53:18 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6603.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: Debugging kernel semaphore contention and priority  inversion
Date: Thu, 18 Aug 2005 08:50:29 -0600
Message-ID: <21FFE0795C0F654FAD783094A9AE1DFC0830FE03@cof110avexu4.global.avaya.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Debugging kernel semaphore contention and priority  inversion
Thread-Index: AcWjswplWWaFDIZWRZyWOvdvtd4SnAAUKuEA
From: "Davda, Bhavesh P \(Bhavesh\)" <bhavesh@avaya.com>
To: "Mike Galbraith" <efault@gmx.de>
Cc: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Mike Galbraith [mailto:efault@gmx.de] 
> Sent: Wednesday, August 17, 2005 11:10 PM
> At 09:43 PM 8/17/2005 -0600, you wrote:
> > >
> > > Have you tried sysrq t?  See the Documentation/sysrq.txt file.
> >
> >This is a headless system.
> 
> You could try netconsole.

Haven't heard of it before. Will look into it. But I doubt it will help
pinpoint the semaphore holder, if all I can do is sysrq stuff.

> 
> > >
> > > How stuck is the system?
> > >
> > > Keith
> >
> >Very. Only pingable, but can't login via 
> telnet/ssh/anything. Reason is 
> >the same reason the low priority mystery task is unable to run and 
> >release the held semaphore.
> 
> (hmm.  I'm obviously missing some original context here)
> 
> Sounds like there must be another player who is RT prio + spinning.
> 
>          -Mike 

Very good! Yes, I left out that piece of detail in my original posting.
There is a real low priority (4) SCHED_FIFO (hence still higher than any
SCHED_OTHER) task spinning. But it is not the semaphore holder. I am
trying to identify which kernel thread (because that's most likely)
running at SCHED_OTHER real low priority (too nice) is holding the
semaphore, locking out a priority 50 SCHED_FIFO task in its sys_write()
as a result.

Thanks

- Bhavesh

Bhavesh P. Davda | Distinguished Member of Technical Staff | Avaya |
1300 West 120th Avenue | B3-B03 | Westminster, CO 80234 | U.S.A. |
Voice/Fax: 303.538.4438 | bhavesh@avaya.com
