Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129483AbQKJPcL>; Fri, 10 Nov 2000 10:32:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130409AbQKJPcC>; Fri, 10 Nov 2000 10:32:02 -0500
Received: from d185fcbd7.rochester.rr.com ([24.95.203.215]:48657 "EHLO
	d185d0f1c.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S129483AbQKJPb5>; Fri, 10 Nov 2000 10:31:57 -0500
Date: Fri, 10 Nov 2000 10:31:00 -0500
From: Chris Mason <mason@suse.com>
To: David Ford <david@linux.com>, LKML <linux-kernel@vger.kernel.org>,
        reiserfs-list@namesys.com
Subject: Re: [reiserfs-list] [bug] kernel panic related to reiserfs,
 2.4.0-test11-pre1 and 3.6.18
Message-ID: <911040000.973870260@coffee>
In-Reply-To: <3A0C030C.DE694934@linux.com>
X-Mailer: Mulberry/2.0.6a8 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Friday, November 10, 2000 06:15:40 -0800 David Ford <david@linux.com>
wrote:

> Over the last three weeks my box has been locking up w/ a black screen
> of death.  This time I had kdb patched in and got the following:
> 
> Entering kdb (current=0xcf906000, pid 16808) Panic: invalid operand
> due to panic @ 0xc0163d7a

Odd.  There is nothing in de_still_valid that should panic, unless there is
some major memory corruption going on.  Do you always get the same trace?

[ ... ]

> I have been writing code on it for the last two days straight.  It was
> fully functional until I left for 15 minutes for a shower.  I came back
> and the system is hosed.  Everything is quickly going to D state.  I can
> move and type until I attempt to execute or reference anything.  It's
> all downhill from there.
> 
> It is 2.4.0-test11-pre1 with reiserfs 3.6.18.
> 
> With kdb, after the panic happens, I can hit 'sr s' then 'g', it will
> OOPS (process sendmail) then continue.  Without kdb, I am SOL and have
> to hit the power button.  sysrq won't react.
> 

Once you get inside reiserfs_rename, you've started a transaction.  If you
oops inside there, the transaction never finishes, and all the other
transactions end up waiting on it.  So, if you can continue without hanging
the box, the oops didn't happen in reiserfs_rename ;-)  Could you send a
decoded version?

-chris

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
