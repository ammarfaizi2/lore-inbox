Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932382AbVHLHHk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932382AbVHLHHk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 03:07:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932348AbVHLHHk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 03:07:40 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:9947 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932382AbVHLHHj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 03:07:39 -0400
Subject: Re: files_lock deadlock?
From: Arjan van de Ven <arjan@infradead.org>
To: Martin Wilck <martin.wilck@fujitsu-siemens.com>
Cc: Alexander Nyberg <alexn@telia.com>, linux-kernel@vger.kernel.org
In-Reply-To: <42FC448F.6070702@fujitsu-siemens.com>
References: <42DD2E37.3080204@fujitsu-siemens.com>
	 <1121870871.1103.14.camel@localhost.localdomain>
	 <42FB8ECF.4090106@fujitsu-siemens.com>
	 <1123782699.3201.43.camel@laptopd505.fenrus.org>
	 <42FC448F.6070702@fujitsu-siemens.com>
Content-Type: text/plain
Date: Fri, 12 Aug 2005 09:07:33 +0200
Message-Id: <1123830453.3218.0.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 2.9 (++)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (2.9 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	2.8 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-08-12 at 08:41 +0200, Martin Wilck wrote:
> Arjan van de Ven wrote:
> 
> > I disagree, it's a performance cost.
> > It's a lot easier to make remove_proc_entry() a might_sleep().. (I'm
> > surprised it isn't already btw given that it's vfs related and the vfs
> > is mostly semaphore based)
> 
> Well enough. But to my understanding using spin_lock implies that we can 
> _prove_ the lock won't be taken in softirq context, and that we will be 
> able to prevent new such paths to be introduced in the future. I wonder 
> if that's possible for this lock.

doing anything with files implies having a defined usercontext really,
and generally sleeping as well. So think this is quite safe.


