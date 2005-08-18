Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932122AbVHRDnh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932122AbVHRDnh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 23:43:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932123AbVHRDnh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 23:43:37 -0400
Received: from tierw.net.avaya.com ([198.152.13.100]:1791 "EHLO
	tierw.net.avaya.com") by vger.kernel.org with ESMTP id S932122AbVHRDng convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 23:43:36 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6603.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: Debugging kernel semaphore contention and priority inversion
Date: Wed, 17 Aug 2005 21:43:27 -0600
Message-ID: <21FFE0795C0F654FAD783094A9AE1DFC0830FCD7@cof110avexu4.global.avaya.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Debugging kernel semaphore contention and priority inversion
Thread-Index: AcWjhAuEzwJli9N0R8S9D9XMl6b32gAIgPiQ
From: "Davda, Bhavesh P \(Bhavesh\)" <bhavesh@avaya.com>
To: "Keith Mannthey" <kmannth@gmail.com>
Cc: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Keith Mannthey [mailto:kmannth@gmail.com] 
> Sent: Wednesday, August 17, 2005 5:33 PM
> 
> On 8/17/05, Davda, Bhavesh P (Bhavesh) <bhavesh@avaya.com> wrote:
> > Is there a way to know which task has a particular (struct 
> semaphore 
> > *) down()ed, leading to another task's down() blocking on it?
> 
> I would add a field to struct semaphore that tracks the 
> current process.
> In your various up and downs have that field tracks the 
> "current" process. 

Yeah, I thought about that. Unfortunately, it doesn't meet my need for
not Heisenberg'ing the system. I can't instrument the struct semaphore
{} in a running system.

> 
> Do you know what semaphore it is?

Yes. It is an inode->i_sem semaphore for a file being written to by the
high-priority SCHED_FIFO task.

> 
> This way you dump the semaphore you can see what task it is 
> holding it.  Have the module dump the semaphore and you can 
> id the task
>  
> > It would be helpful to get a kernel stacktrace for the culprit too.
> 
> Have you tried sysrq t?  See the Documentation/sysrq.txt file.

This is a headless system.

>  
> How stuck is the system? 
> 
> Keith

Very. Only pingable, but can't login via telnet/ssh/anything. Reason is
the same reason the low priority mystery task is unable to run and
release the held semaphore.

Thanks

- Bhavesh


Bhavesh P. Davda | Distinguished Member of Technical Staff | Avaya |
1300 West 120th Avenue | B3-B03 | Westminster, CO 80234 | U.S.A. |
Voice/Fax: 303.538.4438 | bhavesh@avaya.com 
