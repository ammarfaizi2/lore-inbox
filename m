Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbQLGJy1>; Thu, 7 Dec 2000 04:54:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129406AbQLGJyR>; Thu, 7 Dec 2000 04:54:17 -0500
Received: from smtp1.ihug.co.nz ([203.109.252.7]:19461 "EHLO smtp1.ihug.co.nz")
	by vger.kernel.org with ESMTP id <S129183AbQLGJyL>;
	Thu, 7 Dec 2000 04:54:11 -0500
Message-ID: <3A2F5706.5CCF5771@ihug.co.nz>
Date: Thu, 07 Dec 2000 22:23:18 +1300
From: Gerard Sharp <gsharp@ihug.co.nz>
Reply-To: gsharp@ihug.co.nz
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.4.0-test11-ac4-smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "kernel@netravi.net" <kernel@netravi.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: HPT366 + SMP = slight corruption in 2.3.99 - 2.4.0-11
In-Reply-To: <Pine.LNX.4.10.10012060315450.31693-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"kernel@netravi.net" wrote:
> On 2.2.17 I had good luck with BP6.

Never tried the 2.2 series with this controller - probably should get
around to doing that this weekend. :S

> EX:
> [root@animal /root]# uptime
>   3:17am  up 51 days, 20:17,  2 users,  load average: 0.00, 0.04, 0.02

Uptime proves nothing alas; I could get 30+ days if I wanted :S

> Can you post/e-mail any additional details about the lockups. I am very
> curious about this. We have a huge mosix cluster in production with BP6
> mobo's and have plans to upgrade to 2.4 as soon as an official stable
> kernel is released.

The problem is not one of lockups. The system in question doesn't lock;
it doesn't crash; it doesn't even log anything at the time - not even
APIC errors.
Instead it quietly and silently corrupts exactly four bytes at a time;
mostly on the last four bytes of a 4096 block...

I can most easily cause the corruption by copying a large amount of
known data across the disk, and then checking for differences:
cp -aR /usr/src/linux /usr/src/l2 ; diff -dur /usr/src/linux /usr/src/l2

When it does corrupt in this manner, it is not so much of a concern - I
can detect, delete, and recopy the corrupted file(s).
What is more worrying is, what if it is quietly silently and happily
corrupting other data - when I'm NOT staring at it with a paranoid
concern; for example, compiling binaries; or altering large data
files...

As such, I cannot at this time reduce the problem to one of Software or
Hardware Error; and while it is A Major Problem in my eyes; I avoid it
currently by not using the hpt366 controller :)


Gerard Sharp
Two Penguins at 1024x768
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
