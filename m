Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129697AbRAAUFZ>; Mon, 1 Jan 2001 15:05:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129999AbRAAUFP>; Mon, 1 Jan 2001 15:05:15 -0500
Received: from tweetie.comstar.net ([130.205.120.2]:10112 "EHLO
	tweetie.comstar.net") by vger.kernel.org with ESMTP
	id <S129697AbRAAUE5>; Mon, 1 Jan 2001 15:04:57 -0500
Date: Mon, 1 Jan 2001 14:34:30 -0500 (EST)
From: Gregory McLean <gregm@comstar.net>
To: <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.0-prerelease shmget woes.
In-Reply-To: <Pine.LNX.4.30.0101011402001.1416-100000@tweetie.comstar.net>
Message-ID: <Pine.LNX.4.30.0101011429380.1416-100000@tweetie.comstar.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Jan 2001, Gregory McLean wrote:

>
> Hi, I just compiled and booted up 2.4.0-prerelease, dropped into X-Windows
> and now gtk/gnome apps are giving the following warning:
>
> Gdk-WARNING **: shmget failed!
>
> Any ideas on what changed in the shm space to cause this?
>
> This is a PII 333 RH 7.0 system 2.4.0-test10 worked just fine on this
> machine.

Per request here is an strace around where the shmget fails:
(xmms is the target app running Full file available if needed)
getrlimit(0x3, 0xbffff430, 0xbffff4f8, 0xbffff430, 0xbffff430) = 0
setrlimit(RLIMIT_STACK, {rlim_cur=2044*1024, rlim_max=RLIM_INFINITY}) = 0
brk(0x8172000)                          = 0x8172000
pipe([5, 6])                            = 0
clone(child_stack=0x8171ac8,
flags=CLONE_VM|CLONE_FS|CLONE_FILES|CLONE_SIGHAND)
= 6299
write(6, "\0\0\0\0\5\0\0\0\0\0\0\0\0\200\31@\0\0\0\0\30l\1@\360A"..., 148)
= 148
rt_sigprocmask(SIG_SETMASK, NULL, [RT_0], 8) = 0
write(6, "\0\17\35@\0\0\0\0\0\0\0\0 \223\6\10\0\0\0\0\0\0\0\200\0"...,
148) = 14
8
rt_sigprocmask(SIG_SETMASK, NULL, [RT_0], 8) = 0
rt_sigsuspend([] <unfinished ...>
--- SIGRT_0 (Real-time signal 0) ---
<... rt_sigsuspend resumed> )           = -1 EINTR (Interrupted system
call)
sigreturn()                             = ? (mask now [])
shmget(IPC_PRIVATE, 32768, IPC_CREAT|0x1ff|0666) = -1 ENOSPC (No space
left on d
evice)
write(2, "\n", 1
)                       = 1
write(2, "Gdk", 3Gdk)                      = 3
write(2, "-", 1-)                        = 1
write(2, "WARNING **: ", 12WARNING **: )            = 12
write(2, "shmget failed!", 14shmget failed!)          = 14
write(2, "\n", 1
)                       = 1
brk(0x817b000)                          = 0x817b000
brk(0x8184000)                          = 0x8184000
brk(0x818d000)                          = 0x818d000
brk(0x8196000)                          = 0x8196000
brk(0x819f000)                          = 0x819f000
brk(0x81a8000)                          = 0x81a8000
brk(0x81b9000)                          = 0x81b9000
write(3, "\211\30\2\0\2\0\0\0\20\0\10\0\30\0op_WIN_SUPPORTING_"..., 40) =
40
read(3, "\1`)\0\0\0\0\0\34\1\0\0\0\0\0\0\0\0\0\0\1\0\0\0\200\252"..., 32)
= 32
write(3, "\20\0\5\0\n\0\0\0_WIN_LAYERIN", 20) = 20
read(3, "\1\0*\0\0\0\0\0#\1\0\0\0\0\0\0\1\0\0\0\1\0\0\0\200\252"..., 32) =
32
write(3, "\20\0\5\0\n\0\0\0_WIN_HINTSIN", 20) = 20
(bunch more garbage of xmms talking to the x server)

>From what I can tell its saying no space left on device.

>From proc:
---------
 cat /proc/sys/kernel/shmmax
33554432
cat /proc/sys/kernel/shmall
0
 cat /proc/sys/kernel/shmmni
4096



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
