Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263462AbUBCDpI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 22:45:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264542AbUBCDpH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 22:45:07 -0500
Received: from fw.osdl.org ([65.172.181.6]:4744 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263462AbUBCDpE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 22:45:04 -0500
Date: Mon, 2 Feb 2004 19:46:26 -0800
From: Andrew Morton <akpm@osdl.org>
To: Philip Martin <philip@codematters.co.uk>
Cc: linux-kernel@vger.kernel.org, Nick Piggin <piggin@cyberone.com.au>
Subject: Re: 2.6.1 slower than 2.4, smp/scsi/sw-raid/reiserfs
Message-Id: <20040202194626.191cbb95.akpm@osdl.org>
In-Reply-To: <87oesieb75.fsf@codematters.co.uk>
References: <87oesieb75.fsf@codematters.co.uk>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Philip Martin <philip@codematters.co.uk> wrote:
>
> My test is a software build of about 200 source files (written in C)
>  that I usually build using "nice make -j4".  Timing the build on
>  2.4.24 I typically get something like
> 
>  242.27user 81.06system 2:44.18elapsed 196%CPU (0avgtext+0avgdata 0maxresident)k
>  0inputs+0outputs (1742270major+1942279minor)pagefaults 0swaps
> 
>  and on 2.6.1 I get
> 
>  244.08user 116.33system 3:27.40elapsed 173%CPU (0avgtext+0avgdata 0maxresident)k
>  0inputs+0outputs (0major+3763670minor)pagefaults 0swaps

I didn't notice the increase in system time.

Could you generate a kernel profile?  Add `profile=1' to the kernel boot
command line and run:

sudo readprofile -r
sudo readprofile -M10
time make -j4
readprofile -n -v -m /boot/System.map | sort -n +2 | tail -40 | tee ~/profile.txt >&2

on both 2.4 and 2.6?  Make sure the System.map is appropriate to the
currently-running kernel.


