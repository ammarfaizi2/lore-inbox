Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261798AbTJGFYT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 01:24:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261802AbTJGFYT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 01:24:19 -0400
Received: from gemini.smart.net ([205.197.48.109]:56337 "EHLO gemini.smart.net")
	by vger.kernel.org with ESMTP id S261798AbTJGFYS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 01:24:18 -0400
Message-ID: <3F824E03.C309F2BE@smart.net>
Date: Tue, 07 Oct 2003 01:24:19 -0400
From: "Daniel B." <dsb@smart.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18+dsb+smp+ide i686)
X-Accept-Language: en
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org
Subject: Re: IDE DMA errors, massive disk corruption: Why? Fixed Yet? Whynot  
 re-do failed op?
References: <785F348679A4D5119A0C009027DE33C105CDB20A@mcoexc04.mlm.maxtor.com>	            <3F81CE9A.851806B8@smart.net> <200310062045.h96KjxJP008005@turing-police.cc.vt.edu> <3F81D995.D9C13F33@smart.net> <3F81DE1D.6070304@pobox.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> 
> Daniel B. wrote:
> > If the kernel starts a write command for block 993, wouldn't it wait
> > for a DMA interrupt signalling that the drive has received and accepted
> > the command before the kernel starts the write command for block 10934?
> 
> With command queueing, no, it would not wait.

Other than the write-back caching, it's not an open-loop system, 
right?  Regardless of how commands are batched or queued, isn't there 
some acknowledgment back from the drive that some batch of commands
(or some command, or some part of some command) was completed?

Surely the kernel checks for such acknowledgments, right? 

DMA-complete interrupts are probably how some of those acknowledgments 
are communicated, right?

So if the kernel doesn't get an expected DMA interrupt, it should
know that some command(/batch/part) wasn't acknowledged successfully,
right?  And surely it can tell _which_ command/batch/part wasn't
acknowledged (if multiple ones can be outstanding), right?

So if some command/batch/etc. wasn't acknowledged, why can't the 
kernel retry the command/batch/etc.?


> > If it timed out waiting for that interrupt, can't it re-issue the
> > write for block 993 before proceeding?
> 
> Assuming a large amount of sanity in your OS driver... certainly.

Given the serious of disk data corruption, why isn't the Linux kernel
more reliable here?  Hasn't this family of IDE problems been around
for a couple of years now?


Daniel
-- 
Daniel Barclay
dsb@smart.net
