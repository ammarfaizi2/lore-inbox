Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317952AbSFSRpe>; Wed, 19 Jun 2002 13:45:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317953AbSFSRpd>; Wed, 19 Jun 2002 13:45:33 -0400
Received: from wb2-a.mail.utexas.edu ([128.83.126.136]:6919 "HELO
	mail.utexas.edu") by vger.kernel.org with SMTP id <S317952AbSFSRpc>;
	Wed, 19 Jun 2002 13:45:32 -0400
Date: Wed, 19 Jun 2002 12:45:31 -0500 (CDT)
From: Brent Cook <busterb@mail.utexas.edu>
X-X-Sender: busterb@abbey.hauschen
To: Dave Jones <davej@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: File permission problem with NFSv3 and 2.5.20-dj4
In-Reply-To: <20020615142330.C16772@suse.de>
Message-ID: <20020619124252.V4360-100000@abbey.hauschen>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Jun 2002, Dave Jones wrote:

> On Fri, Jun 14, 2002 at 05:30:01PM -0500, Brent Cook wrote:
>
>  >   Looks like there is a problem with NFSv3 and file permissions in the DJ
>  > kernels.
>  >
>  > A file that is marked as executable will lose its executable flag whenever
>  > it is written to. I suspect the proble lies in the changes to the NFS file
>  > info cacheing in the DJ kernels at least since 2.5.20-dj1 (I was unable
>  > to find where this change occured in the changelog).
>
> The NFS changes need going over. I'll see whats left after backing out
> Trond's READDIRPLUS patch. I'm expecting it to be just some small bits
> like BKL shifting around, but that shouldn't be causing the problems
> you saw..
>
>         Dave
>

You were right. Backing out READDIRPLUS fixes the problem with NFS and
files losing the executable bit. I just tried things with 2.5.23-dj1 and
all is well.

Here are a couple of compile fixes for that kernel though:

drivers/input/keyboard/ps2serkbd.c is missing

 #include <linux/tqueue.h>

drivers/input/serio/ct82c710.c is missing

 #include <linux/sched.h>
 #include <asm/errno.h>

Thanks,
 - Brent

