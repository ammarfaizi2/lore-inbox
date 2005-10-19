Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751199AbVJSSAl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751199AbVJSSAl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 14:00:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751204AbVJSSAl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 14:00:41 -0400
Received: from mail.s.netic.de ([212.9.160.11]:62729 "EHLO mail.s.netic.de")
	by vger.kernel.org with ESMTP id S1751199AbVJSSAk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 14:00:40 -0400
From: Guido Fiala <gfiala@s.netic.de>
To: linux-kernel@vger.kernel.org
Subject: Re: large files unnecessary trashing filesystem cache?
Date: Wed, 19 Oct 2005 19:58:37 +0200
User-Agent: KMail/1.7.2
References: <200510182201.11241.gfiala@s.netic.de> <1129695001.8910.57.camel@mindpipe>
In-Reply-To: <1129695001.8910.57.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510191958.37542.gfiala@s.netic.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 19 October 2005 06:10, Lee Revell wrote:
> On Tue, 2005-10-18 at 22:01 +0200, Guido Fiala wrote:
> > Of course one could always implement f_advise-calls in all
> > applications
>
> Um, this seems like the obvious answer.  The application doing the read
> KNOWS it's a streaming read, while the best the kernel can do is guess.
>
> You don't really make much of a case that fadvise can't do the job.
>

Kernel could do the best to optimize default performance, applications that 
consider their own optimal behaviour should do so, all other files are kept 
under default heuristic policy (adaptable, configurable one)

Heuristic can be based on access statistic:

streaming/sequential can be guessed by getting exactly 100% cache hit rate 
(drop behind pages immediately),

random access/repeated reads can be guessed by >100% hit rate (keep as much in 
memory as possible).

Less than 100% hit rate is already handled sanely i guess by reducing 
readahead, precognition would gather access patterns (every n-th block is 
read so readahead every n-th block, unlikely scenario i guess, but might 
happen in databases).

How about backward-read-files? Others?
