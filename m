Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131586AbRCSVhs>; Mon, 19 Mar 2001 16:37:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131603AbRCSVhi>; Mon, 19 Mar 2001 16:37:38 -0500
Received: from chaos.analogic.com ([204.178.40.224]:48002 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S131586AbRCSVhe>; Mon, 19 Mar 2001 16:37:34 -0500
Date: Mon, 19 Mar 2001 16:35:40 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Brian Gerst <bgerst@didntduck.org>
cc: Otto Wyss <otto.wyss@bluewin.ch>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Linux should better cope with power failure
In-Reply-To: <3AB67134.762CFF32@didntduck.org>
Message-ID: <Pine.LNX.3.95.1010319162020.12070A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Mar 2001, Brian Gerst wrote:
[SNIPPED...]

> 
> At the very least the disk should be consistent with memory.  If the
> dirty pages aren't written back to the disk (but not necessarily removed
> from memory) after a reasonable idle period, then there is room for
> improvement.
> 

Hmmm. Now think about it a minute. You have a database operation
with a few hundred files open, most of which will be deleted after
a sort/merge completes. At the same time, you've got a few thousand
directories with their ATIME being updated. Also, you have thousands
of temporary files being created in /tmp during a compile that didn't
use "-pipe".

If you periodically write everything to disk, you don't have many
CPU cycles available to do anything useful.

It is up to the application to decide if anything is 'precious'.
If you've got some database running, it's got to be checkpointed
with some "commitable" file-system so it can be interrupted at any time.

If you make your file-systems up of "slices", you can mount the
executable stuff read/only. Currently, only /var and /tmp need to
be writable for normal use, plus any user "slices", of course.
 -- Yes I know you need to modify /etc/stuff occasionally (startup
and shutdown, plus an occasional password change). I proposed
a long time ago that /etc/mtab get moved to /var.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


