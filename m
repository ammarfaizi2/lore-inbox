Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314685AbSEHQnf>; Wed, 8 May 2002 12:43:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314687AbSEHQnd>; Wed, 8 May 2002 12:43:33 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:19951 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S314685AbSEHQnc>; Wed, 8 May 2002 12:43:32 -0400
Subject: Re: kill task in TASK_UNINTERRUPTIBLE
From: Robert Love <rml@tech9.net>
To: vda@port.imtp.ilyichevsk.odessa.ua
Cc: Amol Lad <dal_loma@yahoo.com>, linux-kernel@vger.kernel.org
In-Reply-To: <200205081519.g48FJEX24062@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-4) 
Date: 08 May 2002 09:43:30 -0700
Message-Id: <1020876211.2084.125.camel@bigsur>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-05-08 at 13:23, Denis Vlasenko wrote:
> On 8 May 2002 12:01, Amol Lad wrote:
> > Hi,
> >  Is there any way i can kill a task in
> > TASK_UNINTERRUPTIBLE state ?
> 
> No. Everytime you see hung task in this state
> you see kernel bug.
> 
> Somebody correct me if I am wrong.

Generally correct.  Of course, what is "hung" ?

If it is just sitting in uninterruptible sleep, it could legitimately be
waiting for an event.  More than likely, however, after some sane period
of time something is broken.

So, yah, it is a kernel bug.

I'll expand on your answer too - _why_ can't we kill it?  Same argument
we had over saving the futexes if a process bails.  You hold a semaphore
because you are entering a critical section.  If you die in the middle,
who knows the state the data is in and you do _not_ want to reenter it.

	Robert Love 

