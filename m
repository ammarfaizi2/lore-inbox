Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261343AbVBWNva@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261343AbVBWNva (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 08:51:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261353AbVBWNva
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 08:51:30 -0500
Received: from alog0084.analogic.com ([208.224.220.99]:2432 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261343AbVBWNvU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 08:51:20 -0500
Date: Wed, 23 Feb 2005 08:50:19 -0500 (EST)
From: linux-os <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Bodo Eggert <7eggert@gmx.de>
cc: linux-kernel@vger.kernel.org, theant@nodivisions.com
Subject: Re: uninterruptible sleep lockups
In-Reply-To: <E1D3ksD-0001NH-MI@be1.7eggert.dyndns.org>
Message-ID: <Pine.LNX.4.61.0502230815380.5548@chaos.analogic.com>
References: <fa.duv6ag6.p5mth0@ifi.uio.no> <fa.irk349q.1c3si2o@ifi.uio.no>
 <E1D3ksD-0001NH-MI@be1.7eggert.dyndns.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Feb 2005, Bodo Eggert wrote:

> linux-os <linux-os@analogic.com> wrote:
>
>> You don't seem to understand. A process that's stuck in 'D' state
>> shows a SEVERE error, usually with a hardware driver.
>
> Or a network filesystem mount to a no longer existing server or share.
>

But that's a whole different problem. That's a systemic problem
of "fail-over". Network file-systems really need to interface
with an intermediate virtual device that can isolate failed
systems and make them look "perfect" to individual machines.

If you don't do this, then as soon as somebody trips over a
wire, your database is trashed. I'm surprised that NFS, PCNFS,
SMB, etc., actually work as well as everybody seems to
think they do. Until the architectural problem is resolved,
there are still going to be hung processes, trashed databases,
etc.

>> For instance,
>> somebody may have coded something in a critical section that will
>> wait forever for some bit to be set when, in fact, that bit may
>> never be set because of a hardware glitch. Such problems must
>> be found. One can't just suck some process out of the 'D' state.
>
> But you can easily fall into one, e.g. by mounting a SMB share to ~/mnt,
> working until after the windows box breaks down and trying to save the
> work of the last hour (which involves enumerating and stat()ing all
> entries in ~).
>

Yes. See above.

>> The 'D' state usually stands for 'Down' where a task
>> was 'down()' on a semaphore. To get out of that state,
>> that task (and none other) needs to execute `up()`.
>> This means that whatever that task was waiting for
>> needs to happen or it won't call 'up()'.
>
> Maybe the device/mountpoint causing the processes to hang can be declared
> dead (This is the more important part to me) and/or the syscall can be
> forced to fail. If it involves wasting some MB of RAM for copying all
> possibly affected memory in order to avoid corrupting used RAM, that
> will be the price to pay for not losing your data.
>

That's not how it's done.

> How to clean up the stuck processes: (This requires a MMU)
> Add an error path to each syscall (or create some generic error paths) and
> keep the original stack frame. On errors, you can "longjump" (not exactly,
> but similar) to the error path after copying the memory. The semaphore will
> not be taken, and the code depending on the semaphore will not be executed.
>

Again, you are attacking the symptom. The problem could be resolved
by using a local disk (or a disk file) for the immediate I/O and
the I/O to the file-servers could occur whenever they are available.
It's just ordinary transaction processing. Nothing new. It's just
that people continue to use primitive garbage (really, usually
developed by amateur hackers with no formal education) that is
then specified by the likes of Microsoft and then, to be compatible,
other operating systems create clones with the same kinds of
unfixable bugs.

>
> BTW: Your Reply-To: should be omited if it's equal to the From:
>

The problem with From: is this machine is not "known" to
the outside world, although somebody has entries in
the auth02.ns.uu.net name-server that claims to be my
machine, which gets cached and cloned everywhere. Mail
to this system needs to go to the Reply-To: address.

Our network "experts" here have tried to track down the
bad name-server entry and they say it's not here.

All of my machine names mysteriously appear in
auth02.ns.uu.net with 204.178.40.nnn IP addresses.
This really screws up email because email tries
to verify the sender by contacting those bogus
addresses.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.10 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
