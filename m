Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312925AbSDBU7H>; Tue, 2 Apr 2002 15:59:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312931AbSDBU65>; Tue, 2 Apr 2002 15:58:57 -0500
Received: from chaos.analogic.com ([204.178.40.224]:58240 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S312925AbSDBU6y>; Tue, 2 Apr 2002 15:58:54 -0500
Date: Tue, 2 Apr 2002 16:01:56 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Evan Harris <eharris@puremagic.com>
cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Problem with scsi tape drives (2.4.18) and soft error count (BusLogic, AIC7xxx)
In-Reply-To: <Pine.LNX.4.33.0204021416450.1454-100000@kinison.puremagic.com>
Message-ID: <Pine.LNX.3.95.1020402155215.6919A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Apr 2002, Evan Harris wrote:

> 
> I've had a long time problem with trying to get the total soft error count
> from tape devices when using the kernel provided tape interface.
> Hopefully, someone here can shed some light on the problem.  Using several
> different DAT and DLT tape drives, the behavior seems the same.
> 
> I'm trying to figure out how to retrieve the soft error count from a tape
> drive after having performed a backup.  It helps me to gauge when a tape
> needs to be retired, and I'm used to being able to get the total soft error
> count from other backup software packages for dos/windows.
> 
> mt apparently queries the soft error count, but it always seems to be zero.
> I've dug into the problem a bit, and it seems that mt reports zero because
> the tape drive has had it checked and cleared by the kernel at every drive
> operation.  Is there any place in the kernel that this information is stored
> so that it may be retrieved?


Not really. The soft error count is preserved across the 'correct' kinds
of open/close operations. To use `mt` to get the count and, to preserve
the state of the tape machine, you need to do your open/close against
the minor number that has the high-bit set:

# file /dev/st*
st0:    character special (9/0)
st1:    character special (9/1)
st3:    character special (9/128)

Instead of using /dev/st0, you would use (on this machine) /dev/st3.

So, if you do your I/O and status through /dev/st3, you will get
meaningful information. Once you close /dev/st0, all history is
lost (correctly). Note that if you do I/O through /dev/st3, the
tape will not automatically rewind on close. You will need to
use `mt` for that.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.

