Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266005AbUFIWEX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266005AbUFIWEX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 18:04:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266011AbUFIWEX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 18:04:23 -0400
Received: from fw.osdl.org ([65.172.181.6]:63910 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266005AbUFIWEV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 18:04:21 -0400
Date: Wed, 9 Jun 2004 15:06:58 -0700
From: Andrew Morton <akpm@osdl.org>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: axboe@suse.de, edt@aei.ca, linux-kernel@vger.kernel.org
Subject: Re: ide errors in 7-rc1-mm1 and later
Message-Id: <20040609150658.5e5e6653.akpm@osdl.org>
In-Reply-To: <200406092352.18470.bzolnier@elka.pw.edu.pl>
References: <1085689455.7831.8.camel@localhost>
	<200406041814.35003.bzolnier@elka.pw.edu.pl>
	<20040605091853.GA13641@suse.de>
	<200406092352.18470.bzolnier@elka.pw.edu.pl>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl> wrote:
>
> Sure, you don't need my ACK, that's obvious - you need it from Linus/Andrew.

But your nack would almost certainly prevent a merge, pending resolution of
whatever the issues are.

> 
> ...
>
> BTW are you aware of two (minor?) corner cases of the current implementation?
> 
> - you can't have journal on a separate device
>   (pre and post flushes will only flush device storing journal not data)

External journals in ext3 aren't really supported - they just happen to
work as a plaything.  I haven't tested it in several years, but I believe
people do use it.

That being said, the bug you identify is an ext3 bug.  The easiest way for
me to fix it up within ext3 would be to issue some flush command to the
filesystem's disk, wait for that to complete, then write the buffer_ordered
commit block to the journal's disk.  That's blkdev_issue_flush(), yes?

> - if you more than > 1 filesystem on the disk (quite likely scenario) it
>   can happen that barrier (flush) will fail for sector for file from the
>   other fs and later barrier for this other fs will succeed

I don't understand this one.

