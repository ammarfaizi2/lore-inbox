Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261606AbVFWLNm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261606AbVFWLNm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 07:13:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262095AbVFWLNm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 07:13:42 -0400
Received: from mx2.elte.hu ([157.181.151.9]:11466 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261606AbVFWLNi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 07:13:38 -0400
Date: Thu, 23 Jun 2005 13:13:06 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: DEBUG_PAGEALLOC & SMP?
Message-ID: <20050623111306.GA6480@elte.hu>
References: <20050623090936.GA28112@elte.hu> <20050623022000.094169d4.akpm@osdl.org> <20050623092902.GA29602@elte.hu> <20050623094008.GA31207@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050623094008.GA31207@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> > full log attached below. (ob'fun: the oom-killer picked the migration 
> > thread to kill ;)
> 
> this was with the -RT tree - let me try whether the same happens on 
> vanilla 2.6.12 too.

[ 1 hour later ... ] the mystery is solved: i had a ~15 MB kernel image 
size due to various debugging options plus per-CPU tracing buffer at 
NR_CPUS=8. PAGEALLOC caused an extra +1MB of DMA-zone kernel footprint 
(the 4k granular kernel pagetables of 1 GB physical RAM), which was the 
final drop and depleted the DMA pool completely.

	Ingo
