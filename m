Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269352AbUINMOZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269352AbUINMOZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 08:14:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269345AbUINL6F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 07:58:05 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:6077 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S269342AbUINL5E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 07:57:04 -0400
Subject: Re: [patch] sched, tty: fix scheduling latencies in tty_io.c
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20040914110611.GA32077@elte.hu>
References: <20040914093855.GA23258@elte.hu>
	 <20040914095110.GA24094@elte.hu> <20040914095731.GA24622@elte.hu>
	 <20040914100652.GB24622@elte.hu> <20040914101904.GD24622@elte.hu>
	 <20040914102517.GE24622@elte.hu> <20040914104449.GA30790@elte.hu>
	 <20040914105048.GA31238@elte.hu> <20040914105904.GB31370@elte.hu>
	 <20040914110237.GC31370@elte.hu>  <20040914110611.GA32077@elte.hu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1095159217.16572.29.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 14 Sep 2004 11:53:39 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2004-09-14 at 12:06, Ingo Molnar wrote:
> the attached patch fixes long scheduling latencies in tty_read() and 
> tty_write() caused by the BKL.

Have you verified that none of the ldisc methods rely on the big kernel
lock. In doing the tty audit I found several cases that tty drivers
still rely on this lock so I am curious why you make this change.

Would it not be better to fix the tty layer locking rather than
introduces new random memory corruptors ?


Alan
