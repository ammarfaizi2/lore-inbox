Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261397AbTJFVHc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 17:07:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261667AbTJFVHc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 17:07:32 -0400
Received: from gemini.smart.net ([205.197.48.109]:30469 "EHLO gemini.smart.net")
	by vger.kernel.org with ESMTP id S261397AbTJFVHb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 17:07:31 -0400
Message-ID: <3F81D995.D9C13F33@smart.net>
Date: Mon, 06 Oct 2003 17:07:33 -0400
From: "Daniel B." <dsb@smart.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18+dsb+smp+ide i686)
X-Accept-Language: en
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org
Subject: Re: IDE DMA errors, massive disk corruption: Why? Fixed Yet? Why not 
 re-do failed op?
References: <785F348679A4D5119A0C009027DE33C105CDB20A@mcoexc04.mlm.maxtor.com>
	            <3F81CE9A.851806B8@smart.net> <200310062045.h96KjxJP008005@turing-police.cc.vt.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote:
> 
> ...
> 
> The ordering issue comes when the following type of thing happens:
> 
> 1) a write for block 993 is issued (metadata, perhaps)
> 2) a write for block 10934 is issued - actual file contents or something that
> depends on 993 being written.
> 3) Disk writes 10934 out.
> 4) Things go bad  (power hit, whatever) before 993 gets written out.
> 5) fsck. ;)

It that scenario relevant to DMA errors?  

I'm talking about problems in steps 1 and 2, not in later steps.

If the kernel starts a write command for block 993, wouldn't it wait
for a DMA interrupt signalling that the drive has received and accepted
the command before the kernel starts the write command for block 10934?

If it timed out waiting for that interrupt, can't it re-issue the
write for block 993 before proceeding?


Daniel
-- 
Daniel Barclay
dsb@smart.net
