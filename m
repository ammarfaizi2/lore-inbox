Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265877AbUAPWVz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 17:21:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265922AbUAPWVx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 17:21:53 -0500
Received: from intra.cyclades.com ([64.186.161.6]:7332 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S265877AbUAPWUR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 17:20:17 -0500
Date: Fri, 16 Jan 2004 20:13:27 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: Brad Tilley <bradtilley@usa.net>
Cc: linux-kernel@vger.kernel.org, Oleg Drokin <green@linuxhacker.ru>
Subject: Re: Possible Bug in 2.4.24???
In-Reply-To: <306iaPsCz6064S16.1074277731@uwdvg016.cms.usa.net>
Message-ID: <Pine.LNX.4.58L.0401162000200.30607@logos.cnet>
References: <306iaPsCz6064S16.1074277731@uwdvg016.cms.usa.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 16 Jan 2004, Brad Tilley wrote:

> While running a script that recursively changes permissions on a ftp
> directory, I received an error to the term window where the script was
> running. I then checked out /var/log/messages and saw the below kernel errors.
> The machine was generally unresponsive and had to be physically rebooted at
> the power switch. It worked fine upon reboot an fsck ran w/o producing any
> error... the script ran fine too. This is a HP XW4100 with a P4, 1.5GB DDR RAM
> and two very fast (15,000 RPM), very large (140GB) SCSI HDDs. It had been up
> for 9 days (since compiling and installing 2.4.24) and has worked fine until
> this point. Could someone tell me if this is or isn't a kernel bug?
>
>
> Jan 16 11:50:43 athop1 kernel: SCSI disk error : host 0 channel 0 id 1 lun 0
> return code = 8000002
> Jan 16 11:50:43 athop1 kernel: Info fld=0x2cd1bd9, Current sd08:15: sense key
> Hardware Error
> Jan 16 11:50:43 athop1 kernel: Additional sense indicates Internal target
> failure
> Jan 16 11:50:43 athop1 kernel:  I/O error: dev 08:15, sector 54128
> Jan 16 11:50:43 athop1 kernel: journal-601, buffer write failed
> Jan 16 11:50:43 athop1 kernel:  (device sd(8,21))
> Jan 16 11:50:43 athop1 kernel: kernel BUG at prints.c:341!
> Jan 16 11:50:43 athop1 kernel: invalid operand: 0000
> Jan 16 11:50:43 athop1 kernel: CPU:    0
> Jan 16 11:50:43 athop1 kernel: EIP:    0010:[<c0189878>]    Tainted: P

Brad,

A device error happened (you see the "SCSI disk error : " message and
"Additional sense indicates Internal target failure") which reiserfs
could not handle.

kernel BUG at prints.c:341 == reiserfs_panic().
