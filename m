Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263615AbTDNUhx (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 16:37:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263688AbTDNUhx (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 16:37:53 -0400
Received: from chaos.analogic.com ([204.178.40.224]:8587 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S263615AbTDNUhv (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Apr 2003 16:37:51 -0400
Date: Mon, 14 Apr 2003 16:52:36 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Frank van Maarseveen <frankvm@xs4all.nl>
cc: linux-kernel@vger.kernel.org
Subject: Re: Memory mapped files question
In-Reply-To: <20030414202741.GA26414@iapetus.localdomain>
Message-ID: <Pine.LNX.4.53.0304141645470.29118@chaos>
References: <A46BBDB345A7D5118EC90002A5072C780BEBAD8D@orsmsx116.jf.intel.com>
 <004301c302bd$ed548680$fe64a8c0@webserver> <Pine.LNX.4.53.0304141559140.28851@chaos>
 <20030414202741.GA26414@iapetus.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Apr 2003, Frank van Maarseveen wrote:

> On Mon, Apr 14, 2003 at 04:13:52PM -0400, Richard B. Johnson wrote:
> >
> > Memory mapped files are supposed to be accessed through memory!
> > Any program that needs to know what's on the physical disk is
> > broken. If you need to write to files and know when they are
> > written to the physical media, you use a journaled file-system.
>
> It is not that simple.
> Shared mmaped files are _never_ flushed, at least in 2.4.x. So,
> without an explicit msync() a process (innd comes to mind) may loose
> years of updates upon a system crash or power outage.
>
> I have learned to live with it but I still find this a bit awkward.
>
> --
> Frank
>

But it is that simple. If you need to update the file with the
memory copy an explicit msync() must be used. Also note that
msync() takes some parameters that may be different in different
processes that access that mmapped file. Therefore, even msync()
goesn't guarantee that everything gets updated for the next
power outage. So, if you absolutely-posix-a-tively need to get
that data onto a disk, they you need to use some kind of signaling
mechanism (to pause all writers), explicitly write everything from
the lowest to the highest, update your check-point file and close
it, then restart all writers. Upon restart, you can unwind to
the check-point file and restart.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

