Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261461AbVBWL2f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261461AbVBWL2f (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 06:28:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261462AbVBWL2f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 06:28:35 -0500
Received: from TYO201.gate.nec.co.jp ([210.143.35.51]:48083 "EHLO
	tyo201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S261461AbVBWL2c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 06:28:32 -0500
Message-ID: <421C690A.4070102@ak.jp.nec.com>
Date: Wed, 23 Feb 2005 20:29:14 +0900
From: Kaigai Kohei <kaigai@ak.jp.nec.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: jlan@sgi.com, lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       guillaume.thouvenin@bull.net, tim@physik3.uni-rostock.de,
       erikj@subway.americas.sgi.com, limin@dbear.engr.sgi.com,
       jbarnes@sgi.com
Subject: Re: [Lse-tech] Re: A common layer for Accounting packages
References: <42168D9E.1010900@sgi.com>	<20050218171610.757ba9c9.akpm@osdl.org>	<421993A2.4020308@ak.jp.nec.com>	<421B955A.9060000@sgi.com>	<421C2B99.2040600@ak.jp.nec.com> <20050222232002.4d934465.akpm@osdl.org>
In-Reply-To: <20050222232002.4d934465.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Thanks for your comments.

Andrew Morton wrote:
 >> Some process-aggregation model have own philosophy and implemantation,
 >> so it's hard to integrate. Thus, I think that common 'fork/exec/exit' event handling
 >> framework to implement any kinds of process-aggregation.
 >
 >
 > We really want to avoid doing such stuff in-kernel if at all possible, of
 > course.
 >
 > Is it not possible to implement the fork/exec/exit notifications to
 > userspace so that a daemon can track the process relationships and perform
 > aggregation based upon individual tasks' accounting?  That's what one of
 > the accounting systems is proposing doing, I believe.
 >
 > (In fact, why do we even need the notifications?  /bin/ps can work this
 > stuff out).

It's hard to prove that we can't implement the process-aggregation only
in user-space, but there are some difficulties on imaplementation, I think.

For example, each process must have a tag or another identifier to explain
what process-aggregation does it belong, but kernel does not support thoes
kind of information, currently. Thus, we can't guarantee associating one
process-aggregation with one process.
# /proc/<uid>/loginuid might be candidate, but it's out of original purpose.

We might be able to make alike system, but is it hard to implement strict
process-aggregation without any kernel supports?
I think that well thought out kernel-modification is better than ad-hoc
implementation on user-space.

Thanks.
-- 
Linux Promotion Center, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>
