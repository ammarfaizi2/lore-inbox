Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130245AbQKKJpy>; Sat, 11 Nov 2000 04:45:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130368AbQKKJpo>; Sat, 11 Nov 2000 04:45:44 -0500
Received: from [62.172.234.2] ([62.172.234.2]:65447 "EHLO saturn.homenet")
	by vger.kernel.org with ESMTP id <S130245AbQKKJpb>;
	Sat, 11 Nov 2000 04:45:31 -0500
Date: Sat, 11 Nov 2000 09:46:45 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: grandsolo@sina.com
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: newbie in kernel
In-Reply-To: <20001111033012.E4BAC1C860F83@mx1.netease.com>
Message-ID: <Pine.LNX.4.21.0011110943320.943-100000@saturn.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Nov 2000, Nick Cheng wrote:

> Dear Sirs,
>    May I have your help on re-build kernel?
>    I wanna find /usr/src/linux/include/linux/tasks.h and change the NR_TASKS to increase the limitation of max processes. But It's not there under kernel 2.4.0-test10. where can I find it?
>    All I wanna get, is to increate the max processes and max_open files under 2.4.0-test10.
>    I've changed my OPEN_MAX to 1024 in limits.h . is it 1024 the max under 2.4.0?
>    I don't know is this mail right to the linux-kernel maillist. If it's wrong, Say sorry to you and please ignore this mail.
>    Thanks and sorry to bother you! 

Only ancient Linux kernels (2.2.x and earlier) had the limitation on how
many processes you can create. This was due to the fact that we used a
segment (or two -- LDT + TSS) per each process. Nowadays we only need such
per engine -- thus we cannot have more than about 2000 engines on an IA32
system.

Anyway, NR_TASKS is no more -- you can have as many tasks as you like --
unlimited. (i.e. limited only by about 32k which is the maximum PID, but
that surely ought to be enough for everyone...)

The default limit is the 0.25 * physpages but you can change that easily
by:

echo 100000 > /proc/sys/threads-max

(haven't you read LKI -- it explains you how to do it:

  http://www.moses.uklinux.net/patches/lki.sgml

)

Regards,
Tigran

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
