Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315580AbSECHb5>; Fri, 3 May 2002 03:31:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315581AbSECHb4>; Fri, 3 May 2002 03:31:56 -0400
Received: from supreme.pcug.org.au ([203.10.76.34]:21934 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S315580AbSECHbz>;
	Fri, 3 May 2002 03:31:55 -0400
Date: Fri, 3 May 2002 17:31:09 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Burgess <aab@cichlid.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: dnotify oddity in 2.4.19pre6aa1
Message-Id: <20020503173109.1afdbec1.sfr@canb.auug.org.au>
In-Reply-To: <200204231658.g3NGwE203196@athlon.cichlid.com>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

Sorry I have been a bit slow on this.

On Tue, 23 Apr 2002 09:58:14 -0700 Andrew Burgess <aab@cichlid.com> wrote:
>
> I am seeing something very strange with the dnotify feature in kernel
> 2.4.19pre6aa1. I'm developing a file copy daemon that makes backups of
> files as soon as they change so I run dnotify on every directory in my
> system (essentially). I based my program on the example in dnotify.txt
> in the Documentation directory.

So far, so good :-)

> I notice that after a while two things happen:
> 
> 1) In my copyd process I start getting signals for directories that are
> not changing. Even stranger, I get signals for fd that I've never
> opened.

OK, this is weird, but I am looking into it.

> 2) Other processes, like sendmail, start exiting with the same signal
> (RTMIN+5). (I use +5 because I started seeing the problem with +0 and I
> took a wild guess that RTMIN+0 was being used for something else).

Does your copyd fork and exit after it has enabled the dnotify?  Is it
still running when other processes start being killed?

> This does not seem to happen if I reboot and do not restart my copyd
> process.
> 
> My system does cycle through process descriptors every few minutes (lots
> of short lived server processes) and sendmail also runs through pids
> rapidly.
> 
> I'm wondering if something isn't being properly reset or cleared when a
> process exits so when the same process or fd data structure (or
> whatever) is reused inside the kernel the signals are still active
> somehow? This is a SMP Athlon, perhaps an SMP race?

That is a possibility, although I thought we had stomped on this bug.

> Do I need to configure something more in my kernel? I don't see any
> config options for realtime or rt or anything like that. And it does
> work fine after a reboot.

No, should be fine.

Can you send me a copy of your copyd (or the relevant subparts of it),
please?
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
