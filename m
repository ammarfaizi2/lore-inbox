Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263737AbTGKPgR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 11:36:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263597AbTGKPgR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 11:36:17 -0400
Received: from angband.namesys.com ([212.16.7.85]:37004 "EHLO
	angband.namesys.com") by vger.kernel.org with ESMTP id S263823AbTGKPfS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 11:35:18 -0400
Date: Fri, 11 Jul 2003 19:49:59 +0400
From: Oleg Drokin <green@namesys.com>
To: Peter Lojkin <ia6432@inbox.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.22-pre3 and reiserfs problem (not boot)
Message-ID: <20030711154959.GJ17180@namesys.com>
References: <20030711142914.GB24682@namesys.com> <E19b019-000Grz-00.ia6432-inbox-ru@f25.mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E19b019-000Grz-00.ia6432-inbox-ru@f25.mail.ru>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Fri, Jul 11, 2003 at 07:41:03PM +0400, "Peter Lojkin"  wrote:

> > There was one more reiserfs message in kernel log just before this
> > line, can you please include it?
> right. ksymoops cut it out so i missed it.
> Jul 10 06:25:10 host kernel: journal-601, buffer write failed

Well, the write to journal failed. Reiserfs panics in such an event as it does not
know what to do in such a case (there are some works at SuSE by Jeff Mahoney to
remount r/o if such an event happens).

> another thing to note, both oopses happend exactly at 06:25:41 (Jul 10 and 11), and both times there were "journal-601, buffer write failed"
> close prior to it.

Well, how about some i/o error messages from block device drivers?

> in the logs we often get messages like:
> Jul 11 14:25:59 host kernel: (scsi0:A:10:0): parity error detected in Data-out phase. SEQADDR(0x55) SCSIRATE(0xc2)
> Jul 11 14:25:59 host kernel: ^INo terminal CRC packet recevied

Hm, can that lead to i/o error propagated up to reiserfs? If yes, then thats' the problem.

> _but_ with 2.4.21-rc? kernel it cause no problems and no data loss.
> promise box itself doesn't detect any errors.
> i've checked the list and found coule of messages about such "parity
> errors" in recent kernels, but no solution or any info about it
> causing problems.
> hoping to get rid of this messages i've tried 2.4.22-pre3 and got
> oopses...

Hm, I guess you need to stop the driver to propagate i/o errors upstream
(perhaps find a recent change that started to do this).
There is nothing to do from reiserfs perspective (except for better error handling,
which will not do you anything good anyway).

Bye,
    Oleg
