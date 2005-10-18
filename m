Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751317AbVJRXGd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751317AbVJRXGd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 19:06:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751472AbVJRXGd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 19:06:33 -0400
Received: from qproxy.gmail.com ([72.14.204.197]:61841 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751317AbVJRXGd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 19:06:33 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=bf7ypfKN/X5oar3vdD1yS82+b5UfSMMjLAk5mbC0/6L0pHJdkWHo/vQP8w3LWrdj2qBdc/98lJ9RxkNa1LCX6ne3xAYpeEJgit/aW24TWzVhHvxSBeB3xbZfna8m3w/VHwsm95AsrCX+4GcwZ8/gmBfYUirm4wnzAMxzKADIick=
Subject: Re: large files unnecessary trashing filesystem cache?
From: Badari Pulavarty <pbadari@gmail.com>
To: 7eggert@gmx.de
Cc: Guido Fiala <gfiala@s.netic.de>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <E1ERzTq-0001IA-Ba@be1.lrz>
References: <4Z5WG-1iM-19@gated-at.bofh.it> <4Z6zs-27l-39@gated-at.bofh.it>
	 <E1ERzTq-0001IA-Ba@be1.lrz>
Content-Type: text/plain
Date: Tue, 18 Oct 2005 16:05:53 -0700
Message-Id: <1129676753.23632.90.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-10-18 at 23:58 +0200, Bodo Eggert wrote:
> Badari Pulavarty <pbadari@gmail.com> wrote:
> > On Tue, 2005-10-18 at 22:01 +0200, Guido Fiala wrote:
> 
> [large files trash cache]
> 
> > Is there a reason why those applications couldn't use O_DIRECT ?
> 
> The cache trashing will affect all programs handling large files:
> 
> mkisofs * > iso
> dd < /dev/hdx42 | gzip > imagefile
> perl -pe's/filenamea/filenameb/' < iso | cdrecord - # <- never tried
> 

Are these examples which demonstrate the thrashing problem.
Few product (database) groups here are trying to get me to 
work on a solution before demonstrating the problem. They 
also claim exactly what you are saying. They want a control
on how many pages (per process or per file or per filesystem
or system wide) you can have in filesystem cache.

Thats why I am pressing to find out the real issue behind this.
If you have a demonstratable testcase, please let me know.
I will be happy to take a look.


> Changing a few programs will only partly cover the problems.
> 
> I guess the solution would be using random cache eviction rather than
> a FIFO. I never took a look the cache mechanism, so I may very well be
> wrong here.

Read-only pages should be re-cycled really easily & quickly. I can't
belive read-only pages are causing you all the trouble.


Thanks,
Badari

