Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262129AbTJYGYO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Oct 2003 02:24:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262133AbTJYGYO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Oct 2003 02:24:14 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:37606 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S262129AbTJYGYN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Oct 2003 02:24:13 -0400
Date: Fri, 24 Oct 2003 23:27:59 -0700
From: Mike Anderson <andmike@us.ibm.com>
To: Fredrik Tolf <fredrik@dolda2000.com>
Cc: Patrick Mansfield <patmans@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: Elevator bug in concert with usb-storage
Message-ID: <20031025062759.GB1288@beaverton.ibm.com>
Mail-Followup-To: Fredrik Tolf <fredrik@dolda2000.com>,
	Patrick Mansfield <patmans@us.ibm.com>, linux-kernel@vger.kernel.org
References: <16279.15393.575929.983297@pc7.dolda2000.com> <20031023082726.A20073@beaverton.ibm.com> <16280.9893.292564.320412@pc7.dolda2000.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16280.9893.292564.320412@pc7.dolda2000.com>
X-Operating-System: Linux 2.0.32 on an i486
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fredrik Tolf [fredrik@dolda2000.com] wrote:
> Sorry, that didn't work well. It doesn't crash on the same thing
> anymore, but nonetheless crashes. In addition, when I have removed the
> device but not yet umounted the filesystem, I tried to ls its root
> dir. Before, nothing extraordinary happened then, but now there's a
> couple of oopses for the ls process as well.
>
> .. snip ..
>
> Call Trace:
>  [<c02176b3>] elv_queue_empty+0x1d/0x20
>  [<c0219ab4>] __make_request+0x80/0x4ae
>  [<c021a016>] generic_make_request+0x134/0x186

I tried to reproduce this error last night using the scsi_debug driver,
but could not. I tried different combinations of file systems (fat, ext2,
ext3). I did notice that I had elevator=deadline on the cmdline. I
removed this in case the elevator_queue_empty_fn between the two
elevators made a difference. I still was unable to reproduce. I will try
a few more combinations of things this weekend and let you know what I
find out. There might be a race still with our cleanups and I am not
able to reproduce it exactly on my system.

-andmike
--
Michael Anderson
andmike@us.ibm.com

