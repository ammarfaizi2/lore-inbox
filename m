Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287599AbSALW1r>; Sat, 12 Jan 2002 17:27:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287609AbSALW1i>; Sat, 12 Jan 2002 17:27:38 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:6163 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S287599AbSALW1U>; Sat, 12 Jan 2002 17:27:20 -0500
Message-ID: <3C40B6F3.1531F931@zip.com.au>
Date: Sat, 12 Jan 2002 14:21:39 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jussi Laako <jussi.laako@kolumbus.fi>
CC: linux-kernel@vger.kernel.org, linux-audio-dev@music.columbia.edu
Subject: Re: [PATCH] Additions to full lowlatency patch
In-Reply-To: <3C40AF23.18C811A8@kolumbus.fi>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jussi Laako wrote:
> 
> Hi,
> 
> I've done some changes to lowlatency patched kernel. Mainly "fixes" to DRM
> drivers and few network drivers. Most probably I have done something really
> stupid, but those work here(tm). Especially the Radeon driver patch has got
> a lot of testing and seems to have huge impact to latencies in my system.
> 

Thanks, Jussi - I'll crunch on this, merge the bits I agree with :)

As Arjan points out, the eepro100 change will cause deadlocks on SMP,
and general badness on uniprocessor.  But I've done a heap of testing
on a eepro100 machine and it hasn't been a problem.  I expect that
wait_for_cmd_done() is only a problem during device startup and shutdown.
And possibly in error recovery.

I take the position that device driver startup and shutdown functions
are a complete basket case, and they are on the "don't do that" list.
Generally, this is OK.  Latency-critical applications should be
careful to ensure that all required kernel modules are loaded beforehand,
and that the cron jobs which reap idle kernel modules be disabled.
Maybe, they should also ensure that any device-special files are held
open across the life of the application.

I used to take the same position on fileystem mount and unmount,  however
things like autofs and some applciations which poll cdrom drives made this
impractical, so filesystem mounts and unmounts are on the "do do that"
list.  I hope.

-
