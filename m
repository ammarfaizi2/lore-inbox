Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288385AbSACXRZ>; Thu, 3 Jan 2002 18:17:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288384AbSACXRP>; Thu, 3 Jan 2002 18:17:15 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:27659 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S288375AbSACXQ6>; Thu, 3 Jan 2002 18:16:58 -0500
Message-ID: <3C34E4DF.F439FD70@zip.com.au>
Date: Thu, 03 Jan 2002 15:10:23 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andy Gaynor <silver@silver.unix-fu.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: losetuping files in tmpfs fails?
In-Reply-To: <3C2F0AEE.ACABAAFA@silver.unix-fu.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Gaynor wrote:
> 
> Whilst trying to figure out why my dang stripes won't persist (a separate
> but worrisome issue), I wrote a dittie which creates a couple junk files in
> /tmp (tmpfs), associates loop devices with them, whoops, losetup craps out.
> 
> ...
>   /tmp# mount | grep tmp                # Filesystem is ...
>   tmpfs on /tmp type tmpfs (rw)         #   tmpfs
>   /tmp# echo foo > foo                  # Create file foo
>   /tmp# losetup /dev/loop/5 foo         # Give foo to /dev/loop/5
>   ioctl: LOOP_SET_FD: Invalid argument  #   DISCO!!!                <o >  <o >

Yup, tmpfs doesn't provide some of the facilities which the
loop driver requires.   Specifically, prepare_write() and 
commit_write().  

Probably it's not too hard to change loop to use generic_file_write(),
and it will then permit tmpfs file-backed loop mounts.

It's not obvious that there's a burning need to support loop-on-tmpfs
though, is there?

-
