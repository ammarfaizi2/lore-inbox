Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313673AbSDJTr0>; Wed, 10 Apr 2002 15:47:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313678AbSDJTrZ>; Wed, 10 Apr 2002 15:47:25 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:24008 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S313673AbSDJTrY>;
	Wed, 10 Apr 2002 15:47:24 -0400
Content-Type: text/plain; charset=US-ASCII
From: Hubertus Franke <frankeh@watson.ibm.com>
Reply-To: frankeh@watson.ibm.com
Organization: IBM Research
To: "Bill Abt" <babt@us.ibm.com>
Subject: Re: [PATCH] Futex Generalization Patch
Date: Wed, 10 Apr 2002 14:47:50 -0400
X-Mailer: KMail [version 1.3.1]
Cc: drepper@redhat.com, linux-kernel@vger.kernel.org, Martin.Wirth@dlr.de,
        pwaechtler@loewe-Komp.de, Rusty Russell <rusty@rustcorp.com.au>
In-Reply-To: <OF0676911E.A8260761-ON85256B97.006AB10C@raleigh.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020410194702.C8A6D3FE06@smtp.linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 10 April 2002 03:30 pm, Bill Abt wrote:
> On 04/10/2002 at 02:10:59 PM AST, Hubertus Franke <frankeh@watson.ibm.com>
>
> wrote:
> > So you are OK with having only poll  or  select.  That seems odd.
> > It seems you still need SIGIO on your fd to get the async notification.
>
> Duh...  You're right.  I forgot about that...
>
> Regards,
>       Bill Abt
>       Senior Software Engineer
>       Next Generation POSIX Threading for Linux
>       IBM Cambridge, MA, USA 02142
>       Ext: +(00)1 617-693-1591
>       T/L: 693-1591 (M/W/F)
>       T/L: 253-9938 (T/Th/Eves.)
>       Cell: +(00)1 617-803-7514
>       babt@us.ibm.com or abt@us.ibm.com
>       http://oss.software.ibm.com/developerworks/opensource/pthreads

Yes,

The current interface is  

(A) 
async wait:
	sys_futex (uaddr, FUTEX_AWAIT, value, (struct timespec*) sig);
upon signal handling
	sys_futex(uaddrs[], FUTEX_WAIT, size, NULL);
	to retrieve the uaddrs that got woken up...

If you simply want a notification with SIGIO (or whatever you desire)
We can change that to 
(A) 
sys_futex(uaddr, FUTEX_WAIT, value, (truct timespec*) fd);

I send a SIGIO and you can request via ioctl or read the pending 
notifications from fd. 
(B)        { struct futex *notarray[N]
              int n = read( futex_fd, (void**)notarray, 
	                    N*sizeof(struct futex));
	}
I am mainly concerned that SIGIO can be overloaded in a thread package ?
How would you know whether a SIGIO came from the futex or from other file 
handle.


That is your call to make. Let me know !!!

-- 
-- Hubertus Franke  (frankeh@watson.ibm.com)
