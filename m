Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267237AbTATWaF>; Mon, 20 Jan 2003 17:30:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267252AbTATWaE>; Mon, 20 Jan 2003 17:30:04 -0500
Received: from pc-62-31-74-42-ed.blueyonder.co.uk ([62.31.74.42]:27269 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S267237AbTATW3v>; Mon, 20 Jan 2003 17:29:51 -0500
Subject: Re: 2.4.21-pre3 - problems with ext3
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Lukasz Trabinski <lukasz@wsisiz.edu.pl>
Cc: ext3 users list <ext3-users@redhat.com>, akpm@zip.com.au,
       Andreas Dilger <adilger@clusterfs.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.51.0301141401260.6636@oceanic.wsisiz.edu.pl>
References: <Pine.LNX.4.51.0301141401260.6636@oceanic.wsisiz.edu.pl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 20 Jan 2003 22:38:17 +0000
Message-Id: <1043102297.13050.59.camel@sisko.scot.redhat.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 2003-01-14 at 13:15, Lukasz Trabinski wrote:

> Since 2.4.20, we have problems with ext3. Machine is 2xPentium III (1GHz),
> 2GB RAM, 1GB swap. RH 8.0 (glibc-2.3.1-21), gcc (GCC) 3.2 20020903

So it was stable under earlier kernels?

> Is it a problem with ext3 or problems with disk (hardware problem) or 
> something else?

There's nothing in the trace to indicate a hardware fault.  Is there
anything else showing up in the logs which might indicate the kernel
getting into a tangle?

>From the assert failure:

> Jan 14 12:53:52 oceanic kernel: Assertion failure in
>  journal_start_Rsmp_909c88ec() at transaction.c:249:
> "handle->h_transaction->t_journal == journal"

it looks as if either the VM has been recursing into the filesystem
(filesystem problem or a missing GFP_NOFS somewhere), or there has been
a stack overflow (the data structure that the mismatch is on is just
about the very last thing on the task structure that the stack grows
towards.)

But as for the decoded OOPS, I can't immediately trace through it
successfully.  There's no syscall entry point at the top of the stack,
and there appear to be two separate possible interpretations of the call
trace.  Do you have any other captured oopses that I might be able to
find some common threads in?

Cheers,
 Stephen

