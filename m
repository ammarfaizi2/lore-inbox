Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269396AbUINMXI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269396AbUINMXI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 08:23:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269337AbUINMVn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 08:21:43 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:11453 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S269361AbUINMVX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 08:21:23 -0400
Subject: Re: [patch] sched, tty: fix scheduling latencies in tty_io.c
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20040914120016.GA5422@elte.hu>
References: <20040914095731.GA24622@elte.hu>
	 <20040914100652.GB24622@elte.hu> <20040914101904.GD24622@elte.hu>
	 <20040914102517.GE24622@elte.hu> <20040914104449.GA30790@elte.hu>
	 <20040914105048.GA31238@elte.hu> <20040914105904.GB31370@elte.hu>
	 <20040914110237.GC31370@elte.hu> <20040914110611.GA32077@elte.hu>
	 <1095159217.16572.29.camel@localhost.localdomain>
	 <20040914120016.GA5422@elte.hu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1095160687.16572.34.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 14 Sep 2004 12:18:08 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2004-09-14 at 13:00, Ingo Molnar wrote:
> > Would it not be better to fix the tty layer locking rather than
> > introduces new random memory corruptors ?
> 
> sure ... any volunteers?

Not that I've seen. I'm fixing some locking but not stuff that depends
on lock_kernel(). In the meantime therefore it seems inappropriate to
add random corruptors and bugs to the kernel in pursuit of low latency
other than as private "add this but beware" patches.

The tty I/O patches should not be applied until the tty layer doesn't
rely on the lock_kernel locking. So if people want the low latency stuff
covering the tty code I suggest that rather than making other peoples
machines crash more, they volunteer. The console driver might be a good
starting point.

Alan
