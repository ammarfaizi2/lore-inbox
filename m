Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750987AbWFRF63@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750987AbWFRF63 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 01:58:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751098AbWFRF63
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 01:58:29 -0400
Received: from smtp.osdl.org ([65.172.181.4]:23985 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750987AbWFRF62 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 01:58:28 -0400
Date: Sat, 17 Jun 2006 22:58:13 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: sturmflut@lieberbiber.de, linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: Re: [patch 2/3] vdso: improve print_fatal_signals support by adding
 memory maps
Message-Id: <20060617225813.1f0fbe15.akpm@osdl.org>
In-Reply-To: <20060617215818.7bc728af.rdunlap@xenotime.net>
References: <200606171614.58610.sturmflut@lieberbiber.de>
	<20060617215818.7bc728af.rdunlap@xenotime.net>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 17 Jun 2006 21:58:18 -0700
"Randy.Dunlap" <rdunlap@xenotime.net> wrote:

> On Sat, 17 Jun 2006 16:14:52 +0200 Simon Raffeiner wrote:
> 
> > When compiling 2.6.17-rc6-mm2 (which contains this patch) my gcc 4.0.3 (Ubuntu 
> > 4.0.3-1ubuntu5) complains about "int len;" being used uninitialized in 
> > print_vma(). AFAICS len is not initialized and then passed to 
> > pad_len_spaces(int len), which uses it for some calculations.
> > 
> > I also noticed that similar code is used in fs/proc/task_mmu.c, where 
> > show_map_internal() passes an uninitialised int len; to pad_len_spaces(struct 
> > seq_file *m, int len).
> 
> Ack both of those.  And both of them pass &len as a parameter to
> printk/seq_printf where it looks as though they want just <len>
> (after it has been initialized).
> 

printk("%n", &len) will initialise `len'.  gcc is being wrong again.
