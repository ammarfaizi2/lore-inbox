Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932559AbWAKA7A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932559AbWAKA7A (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 19:59:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932555AbWAKA7A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 19:59:00 -0500
Received: from smtp.osdl.org ([65.172.181.4]:43140 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932553AbWAKA67 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 19:58:59 -0500
Date: Tue, 10 Jan 2006 17:00:37 -0800
From: Andrew Morton <akpm@osdl.org>
To: Mattia Dongili <malattia@linux.it>
Cc: linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com,
       linux-acpi@vger.kernel.org, Pavel Machek <pavel@ucw.cz>
Subject: Re: 2.6.15-mm2: reiser3 oops on suspend and more (bonus oops shot!)
Message-Id: <20060110170037.4a614245.akpm@osdl.org>
In-Reply-To: <20060110235554.GA3527@inferi.kami.home>
References: <20060110235554.GA3527@inferi.kami.home>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mattia Dongili <malattia@linux.it> wrote:
>
> Hello,
> 
> I didn't tested -mm1 but -mm2 has definitely too many problems currently,
> let's start:

Thanks for testing and reporting - it really helps.

> 1- reiser3 oopsed[1] twice while suspending to ram. It seems
>    reproducible (have some activity on the fs and suspend)

No significant reiser3 changes in there, so I'd be suspecting something
else has gone haywire.

> 2- I had already written this email once, but the box completely
>    froze, nothing in the logs, only mouse and X activity. I suspect
>    again of reiser3.

Yes, that sounds like a filesystem failed while holding locks.

> 3- This laptop experienced 2 long stalls (20~25 sec) during boot,
>    apparently after scanning usb_storage devices and starting portmap.

You mean before starting portmap?

>    I logged the call traces (sysrq+t) during this time, I don't know if
>    it is useful[2].

Hard to see anything in there.  If you set CONFIG_FRAME_POINTER=y you'll
get better traces.

>    Is it time for me to learn to git bisect? (Tomorrow morning I'll try
>    (CET) if plain 2.6.15 also shows the same stalls).

Please test the next Linus git tree (2.6.15-git7) and see if we've
propagated it into there too.

There's not much point in fiddling with -mm2.  If git7 is OK then please
test the next -mm and if it still fails then yes, doing a bisection would
really help.

<types madly>

See http://www.zip.com.au/~akpm/linux/patches/stuff/bisecting-mm-trees.txt

> 4- I'm also affected by the ACPI Misaligned resource pointer error.

ACPI cc'ed

> 5- That's an older problem I never reported (never tracked to be a
>    reiser4 problem): reiser4 shows a very bad slowness. Use case: backup
>    my ~/ (rsync)
>    a- from reiser4 to xfs rsync stalls for some seconds from time to
>       time while building the file list (call trace during the stall[3])
>       Even using mutt and editing a file with vim causes short freezes)
>    b- from xfs to reiser4 after finishing the copy, sync-ing takes ages,
>       gkrellm disk monitor shows 1MB/s

Don't know, sorry.

> [1]: http://oioio.altervista.org/linux/dsc03133.jpg
> [2]: http://oioio.altervista.org/linux/boot-2.6.15-mm2.3
> [3]: http://oioio.altervista.org/linux/dmesg_reiser4_stalls
> 
> The reiser oops seems reproducible by suspending with some dirty cache
> (I've been able to suspend/resume cycle 3 times without reiser crashing
> but I also didn't have big activities on that partition).
> If really necessary I can try to reproduce it (oh, poor filesystem).
> Other than that are ther suggestions/patches to start with?

Pavel, have you heard of anything like this??

