Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315630AbSGSP4T>; Fri, 19 Jul 2002 11:56:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316855AbSGSP4T>; Fri, 19 Jul 2002 11:56:19 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:27607 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S315630AbSGSP4S>;
	Fri, 19 Jul 2002 11:56:18 -0400
Content-Type: text/plain; charset=US-ASCII
From: Hubertus Franke <frankeh@watson.ibm.com>
Reply-To: frankeh@watson.ibm.com
Organization: IBM Research
To: root@chaos.analogic.com, Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: if_exist_pid()
Date: Fri, 19 Jul 2002 10:55:40 -0400
User-Agent: KMail/1.4.1
References: <Pine.LNX.3.95.1020716131206.19310A-100000@chaos.analogic.com>
In-Reply-To: <Pine.LNX.3.95.1020716131206.19310A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200207191055.40646.frankeh@watson.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 16 July 2002 01:19 pm, Richard B. Johnson wrote:
> Anybody know the 'correct' way of determining if a pid still
> exists?  I've been using "kill(pid, 0)" and, if it does not
> return an error, it is supposed to exist. This is to release
> a user-mode lock (semaphore) if the task that held the lock
> crashed. Maybe there is a 'if_exist_pid(pid)' call somewhere?
> Sending signal 0 to a pid sometimes returns 0, even if the pid
> is long-gone and I don't want to read /proc to look for info.
>
> Cheers,
> Dick Johnson
>
> Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
>
>                  Windows-2000/Professional isn't.
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


You can take your clues from the get_pid algo and implementation.

The currently correct way to do this is to 
scan all tasks and figure out whether either of pid, gid, tgid .. is using 
your questioned pid number for small number of task this should be
trivial timewise, for large number of task its a different story

Bill Irwin is working on a patch that release pids upon their last usage
and such thing could then be recorded in a bitmap. Checking availability
would simply then mean checking a particular bit.
I have a patch lying around to move pid allocation to a bitmap.


-- 
-- Hubertus Franke  (frankeh@watson.ibm.com)
