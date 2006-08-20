Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751185AbWHTTuU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751185AbWHTTuU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 15:50:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751194AbWHTTuU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 15:50:20 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:33492 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751185AbWHTTuT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 15:50:19 -0400
Subject: Re: Possible deadlock in videobuf_dma_init_user
From: Arjan van de Ven <arjan@infradead.org>
To: Petr Vandrovec <petr@vandrovec.name>
Cc: video4linux-list@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <20060820191930.GA21729@platan.vc.cvut.cz>
References: <20060820191930.GA21729@platan.vc.cvut.cz>
Content-Type: text/plain
Organization: Intel International BV
Date: Sun, 20 Aug 2006 21:50:15 +0200
Message-Id: <1156103415.23756.58.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-08-20 at 21:19 +0200, Petr Vandrovec wrote:
> Hello,
>   my kernel is a bit unhappy with lock ordering between mm->mmap_sem 
> and videobuf_queue->lock.
> 					Thanks,
> 						Petr Vandrovec


looks like a real deadlock to me...

bttv_prepare_buffer takes mutex then
videobuf_dma_init_user takes mmap_sem



do_mmap_pgoff takes mmap_sem then calls
bttv_mmap which calls
videobuf_mmap_mapper takes the mutex


so a classic AB-BA deadlock....


