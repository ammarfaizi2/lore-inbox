Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269316AbUINOSm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269316AbUINOSm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 10:18:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269317AbUINOSm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 10:18:42 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:55229 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S269316AbUINOSZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 10:18:25 -0400
Subject: Re: [patch] sched: fix scheduling latencies in mtrr.c
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040914132536.GA9742@elte.hu>
References: <20040914095731.GA24622@elte.hu>
	 <20040914100652.GB24622@elte.hu> <20040914101904.GD24622@elte.hu>
	 <20040914102517.GE24622@elte.hu> <20040914104449.GA30790@elte.hu>
	 <20040914105048.GA31238@elte.hu> <20040914105904.GB31370@elte.hu>
	 <20040914110237.GC31370@elte.hu> <20040914110611.GA32077@elte.hu>
	 <20040914112847.GA2804@elte.hu>  <20040914132536.GA9742@elte.hu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1095167722.16845.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 14 Sep 2004 14:15:23 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2004-09-14 at 14:25, Ingo Molnar wrote:
> caveat: one of the wbinvd() removals is correct i believe, but the other
> one might be problematic. It doesnt seem logical to do a wbinvd() at
> that point though ...

See the intel ppro manual volume 3 page 11-25. Its quite specific about
the sequence, so unless anything changes with AMD or later processors
the change seems to match the description.

IRQs are required to be off far longer than this sequence according to
the docs however, and PGE is supposed to be cleared too.

Step 11: set CD flag
Step 12: wbinvd
Step 13: set pge in CR4 if previously cleared


