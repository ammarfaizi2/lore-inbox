Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261404AbUCATHO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 14:07:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261405AbUCATHO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 14:07:14 -0500
Received: from chaos.analogic.com ([204.178.40.224]:50308 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261404AbUCATHH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 14:07:07 -0500
Date: Mon, 1 Mar 2004 14:09:45 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Nuno Monteiro <nuno@itsari.org>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: something funny about tty's on 2.6.4-rc1-mm1
In-Reply-To: <20040301184512.GA21285@hobbes.itsari.int>
Message-ID: <Pine.LNX.4.53.0403011402100.10151@chaos>
References: <20040301184512.GA21285@hobbes.itsari.int>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Mar 2004, Nuno Monteiro wrote:

>
> Hi all,
>
> I just took 2.6.4-rc1-mm1 for a spin, and there's definitely something
> funny about tty's. I left the computer unattended and had visitors over,
> among them small children who, apparently, decided I needed 350 aterm's
> open ;-). So, after they left I issued a 'killall -9 aterm' and fired up
> a new one, and here's something definitely interesting:
>
> nuno@hobbes:~$ w
>  18:33:56 up  4:08, 157 users,  load average: 0.03, 0.89, 1.51
> USER     TTY        LOGIN@   IDLE   JCPU   PCPU WHAT
> nuno     :0        14:26   ?xdm?   3:55   0.95s gnome-session
> nuno     pts/358   18:30    0.00s  0.10s  0.00s w
>

But `w` just reads /var/run/utmp to see who's logged on. It reads
/proc for info. If you just killed all the tasks as you state,
(with KILL instead of TERM) utmp probably doesn't have logout
entries. This seems like a `w` problem, not a kernel problem.

The pts ttys will get recycled just like pids. There is no
error here either.

>
> I know for a fact that I don't have 157 logged in users (well, there's
> only 45 processes running right now), and shouldn't pts' be recycled, and
> a lower number be assigned? The last kernel I ran was 2.6.3, and none of
> this happened.
>
> My config is:
>
> CONFIG_UNIX98_PTYS=y
> CONFIG_LEGACY_PTYS=y
> CONFIG_LEGACY_PTY_COUNT=512
>
> and this is a plain jane static /dev -- not devfs nor udev. Despite the
> supposedly 157 users logged in, /dev/pts only contains '358', which is
> the one allocated to this instance of aterm right now.
>
> nuno@hobbes:~$ ls -l /dev/pts
> total 0
> crw--w----    1 nuno     users    136, 102 Mar  1 18:41 358
>
> In the mean time I'll fall back to 2.6.3.
>
>
> Regards,
>
>
> 		Nuno
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


