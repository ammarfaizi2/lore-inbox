Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266417AbRGNOjz>; Sat, 14 Jul 2001 10:39:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267062AbRGNOjp>; Sat, 14 Jul 2001 10:39:45 -0400
Received: from mail.intrex.net ([209.42.192.246]:6667 "EHLO intrex.net")
	by vger.kernel.org with ESMTP id <S266417AbRGNOjk>;
	Sat, 14 Jul 2001 10:39:40 -0400
Date: Sat, 14 Jul 2001 10:44:47 -0400
From: jlnance@intrex.net
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RFC: Remove swap file support
Message-ID: <20010714104447.A1327@bessie.localdomain>
In-Reply-To: <3B472C06.78A9530C@mandrakesoft.com> <m1elrk3uxh.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <m1elrk3uxh.fsf@frodo.biederman.org>; from ebiederm@xmission.com on Sat, Jul 14, 2001 at 12:07:38AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 14, 2001 at 12:07:38AM -0600, Eric W. Biederman wrote:
> 
> The case to watch out for are deadlocks doing things like using
> swapfiles on an NFS mount.  As you point out we can already do this
> with the loop back devices so it isn't really a special case.  The
> only new case I can see working are swapfiles with holes in them, or
> swapfiles that do automatic compression.  I doubt those cases are
> significant improvements but it looks like they will fall out
> naturally. 

The case of swap files with holes would be a nice thing to have.
It would effectivly give us a way to say "use the extra space on this
file system for swap" and at the same time the ability to set a limit
on how much space could be taken up by swap.  For example you could
create a totally sparse 1G file at bootup, and use it as a swap file.
If the system needed swap it could grow the file, but you would know
that it would never grow beyond 1G.

I dont know if the kernel should punch holes back into the swap file when
it no longer needed the space.  That would be nice, but it might be a lot
of work as I am not sure the VFS supports that.  You could accomplish the
same thing by having a daemon that added a new swap file every hour and
did a swapoff & rm of the old file.

Thanks,

Jim
