Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbQLPBTq>; Fri, 15 Dec 2000 20:19:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129289AbQLPBTh>; Fri, 15 Dec 2000 20:19:37 -0500
Received: from mail-04-real.cdsnet.net ([63.163.68.109]:54801 "HELO
	mail-04-real.cdsnet.net") by vger.kernel.org with SMTP
	id <S129183AbQLPBTY>; Fri, 15 Dec 2000 20:19:24 -0500
Message-ID: <3A3ABBED.6D727B0@mvista.com>
Date: Fri, 15 Dec 2000 16:48:45 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.72 [en] (X11; I; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Jason Wohlgemuth <jwohlgem@mindspring.com>, linux-kernel@vger.kernel.org
Subject: Re: lock_kernel() / unlock_kernel inconsistency Don't do this!
In-Reply-To: <E1475MO-00026g-00@the-village.bc.nu>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > Both of these methods have problems, especially with the proposed
> > preemptions changes.  The first case causes the thread to run with the
> > BKL for the whole time.  This means that any other task that wants the
> > BKL will be blocked.  Surly the needed protections don't require this.
> 
> The BKL is dropped on rescheduling of that task. Its an enforcement of the
> old unix guarantees against other code making the same assumptions. Its also
> the standard 2.4 locking for several things still
> 
Yes, I am aware of the drop on schedule, but a preemptive schedule call
should (can not) do this.  Result, no preemption, i.e. the thread does
not let anyone else in.  Some how I don't think a long term hold, such
as this is needed.  Of course, if the code blocks (i.e. calls
schedule()) often... but then we find folks using such code a pattern
and learning tool.  Remember this thread was started by just such a
study.

George
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
