Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283626AbRLWTM1>; Sun, 23 Dec 2001 14:12:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283780AbRLWTMR>; Sun, 23 Dec 2001 14:12:17 -0500
Received: from mail.xmailserver.org ([208.129.208.52]:15116 "EHLO
	mail.xmailserver.org") by vger.kernel.org with ESMTP
	id <S283626AbRLWTMA>; Sun, 23 Dec 2001 14:12:00 -0500
Date: Sun, 23 Dec 2001 11:15:17 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Benjamin LaHaise <bcrl@redhat.com>
cc: Keith Owens <kaos@ocs.com.au>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] Assigning syscall numbers for testing
In-Reply-To: <20011223120604.B19863@redhat.com>
Message-ID: <Pine.LNX.4.40.0112231046410.7257-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Dec 2001, Benjamin LaHaise wrote:

> On Sun, Dec 23, 2001 at 04:10:21PM +1100, Keith Owens wrote:
> > I'm glad somebody understands the code :).
>
> There are two directions of binary compatibility: forwads and backwards.
> Your patch breaks forwards compatibility if used outside the main tree.  Try
> to understand this.

Guys, doing this in the correct way is not difficult, just we need glibc
cooperation. The module ( app or sl ) will have a table of system call
mappings :

unsinged sysmap[];

and it'll know that sys_getpid is entry 0, etc... ( static knowledge ).
When invoking sys_getpid it'll load the syscall # register with sysmap[0]
and then it'll invoke the syscall entry. Current system call will retain
their current #ID and this will provide backward compatibility.
The table is filled at module initialization time by calling ( for
performance reasons ) a fixed #ID system call sys_namemap(), that will use
an internal hashed map of system names to #ID, and will return the #ID
given a system call name. If the module require a system call that it's
not present inside the loading kernel, it'll fail the module load.
glibc ver >= N will require kernel ver >= M ( that will have the
sys_namemap() function ). System call names should be placed in a special
gcc section where they can be easily looped at init time to fill the
sysmap[] table. Where does it break ?




- Davide



