Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269121AbUIBWYb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269121AbUIBWYb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 18:24:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269152AbUIBWYM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 18:24:12 -0400
Received: from mx2.elte.hu ([157.181.151.9]:7297 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S269146AbUIBWXi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 18:23:38 -0400
Date: Fri, 3 Sep 2004 00:24:34 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Mark_H_Johnson@raytheon.com
Cc: "K.R. Foley" <kr@cybsft.com>, linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <lkml@felipe-alfaro.com>,
       Daniel Schmitt <pnambic@unu.nu>, Lee Revell <rlrevell@joe-job.com>
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-Q5
Message-ID: <20040902222434.GA28716@elte.hu>
References: <OFC12F3DB5.BA677210-ON86256F02.00545B49-86256F02.00545B58@raytheon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OFC12F3DB5.BA677210-ON86256F02.00545B49-86256F02.00545B58@raytheon.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Mark_H_Johnson@raytheon.com <Mark_H_Johnson@raytheon.com> wrote:

> TSC mcount
> ==========
> 
> >From your patch, added several mcount() calls to mark_offset_tsc.
> To summarize the trace results, here is a table that reports the
> delta times for each location. Each row represents one of the dozen
> trace outputs per latency trace. Row columns are the file names
> (lt.xx) in the tar file. Times are in usec.
> 
>      01  03  04  13  16  26  27  31  32  35  37  39
> 01  000 000 000 069 000 000 000 000 000 081 136 000
> 02  032 000 000 000 000 000 000 000 000 000 000 000
> 03  000 000 000 000 000 000 000 000 000 000 000 000
> 04  001 000 000 070 231 139 138 093 252 062 000 067
> 05  000 000 000 000 000 000 000 000 000 000 000 000
> 06  042 003 003 004 003 004 004 053 145 076 003 004
> 07  004 004 004 004 008 004 005 006 010 011 004 005
> 08  001 001 002 002 008 002 002 002 001 002 001 002
> 09  000 000 000 000 000 000 000 000 000 000 000 000
> 10  000 000 000 000 000 000 000 000 000 000 000 000
> 11  000 000 000 000 000 000 000 000 000 000 000 000
> 12  000 000 000 061 000 130 129 129 000 000 000 060

so ... not all codepaths contribute to the high latency.

it seems the following ones generate the highest overhead: #03-#04,
#05-#06. What code is there between mcount() #03 and #04?

	Ingo
