Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263930AbTGKPw0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 11:52:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263738AbTGKPwQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 11:52:16 -0400
Received: from f25.mail.ru ([194.67.57.151]:50958 "EHLO f25.mail.ru")
	by vger.kernel.org with ESMTP id S263945AbTGKPvm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 11:51:42 -0400
From: =?koi8-r?Q?=22?=Peter Lojkin=?koi8-r?Q?=22=20?= <ia6432@inbox.ru>
To: =?koi8-r?Q?=22?=Oleg Drokin=?koi8-r?Q?=22=20?= <green@namesys.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.22-pre3 and reiserfs problem (not boot)
Mime-Version: 1.0
X-Mailer: mPOP Web-Mail 2.19
X-Originating-IP: unknown via proxy [81.89.69.194]
Date: Fri, 11 Jul 2003 20:06:23 +0400
In-Reply-To: <20030711154959.GJ17180@namesys.com>
Reply-To: =?koi8-r?Q?=22?=Peter Lojkin=?koi8-r?Q?=22=20?= 
	  <ia6432@inbox.ru>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E19b0Pf-000Jzx-00.ia6432-inbox-ru@f25.mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Jul 10 06:25:10 host kernel: journal-601, buffer write failed
> 
> Well, the write to journal failed. Reiserfs panics in such an event as it does not
> know what to do in such a case (there are some works at SuSE by Jeff Mahoney to
> remount r/o if such an event happens).
yes, once i found the "buffer write failed" i knew it wasn't a random
reiserfs oops. just missed it first time, sorry.

and i think that close timming of oopses was caused by some cron job
started at this time, the one that does search through entire fs tree...

> Well, how about some i/o error messages from block device drivers?
> 
> > in the logs we often get messages like:
> > Jul 11 14:25:59 host kernel: (scsi0:A:10:0): parity error detected in Data-out phase. SEQADDR(0x55) SCSIRATE(0xc2)
> > Jul 11 14:25:59 host kernel: ^INo terminal CRC packet recevied
> 
> Hm, can that lead to i/o error propagated up to reiserfs? If yes,
> then thats' the problem.
sure if there were real errors, but with earlier kernels we get
this errors in logs but no problems or data loss. strange...

> Hm, I guess you need to stop the driver to propagate i/o errors upstream
> (perhaps find a recent change that started to do this).
> There is nothing to do from reiserfs perspective (except for better error handling,
> which will not do you anything good anyway).
well i cannot do a lot of reboots on this box, so i guess i just
try to move promise to another host with another scsi hba and see if
it works... 

Big thanks for quick reply!

