Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261272AbVGTOr6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261272AbVGTOr6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Jul 2005 10:47:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261280AbVGTOr6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Jul 2005 10:47:58 -0400
Received: from mailfe02.swip.net ([212.247.154.33]:52720 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S261272AbVGTOr4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Jul 2005 10:47:56 -0400
X-T2-Posting-ID: jLUmkBjoqvly7NM6d2gdCg==
Subject: Re: files_lock deadlock?
From: Alexander Nyberg <alexn@telia.com>
To: Martin Wilck <martin.wilck@fujitsu-siemens.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <42DD2E37.3080204@fujitsu-siemens.com>
References: <42DD2E37.3080204@fujitsu-siemens.com>
Content-Type: text/plain
Date: Wed, 20 Jul 2005 16:47:51 +0200
Message-Id: <1121870871.1103.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tis 2005-07-19 klockan 18:45 +0200 skrev Martin Wilck:
> Hello,
> 
> I apologize in advance if this is a dummy question. My web search turned 
> up nothing, so I'm trying it here.
> 
> We came across the following error message:
> 
> Kernelpanic - not syncing: fs/proc/
> Generic.c:521: spin_lock(fs/file_table.c:ffffffff80420280)
> Already locked by fs/file_table.c/204
> 
> This shows a locking problem with the files_lock on a UP kernel with 
> spinlock debugging enabled.
> 
> I noticed that files_lock is only protected with spin_lock() 
> (file_list_lock(), include/linux/fs.h). Is it possible that this should 
> be changed to spin_lock_irq()) or spin_lock_irqsave()? Or am I misssing 
> something obvious?

spin_lock_irqsave is only needed when a lock is taken both in normal
context and in interrupt context. Clearly this lock is not intended to
be taken in interrupt context. 

I'll take a look, that spinlock debugging information unfortunately
doesn't give too much info :|


