Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932507AbVHYTEz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932507AbVHYTEz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 15:04:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932509AbVHYTEz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 15:04:55 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:21694 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S932507AbVHYTEx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 15:04:53 -0400
Date: Thu, 25 Aug 2005 20:07:55 +0100
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Paul Jackson <pj@sgi.com>, paulus@samba.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, rth@twiddle.net
Subject: Re: Linux-2.6.13-rc7
Message-ID: <20050825190755.GV9322@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.58.0508232203520.3317@g5.osdl.org> <20050824064342.GH9322@parcelfarce.linux.theplanet.co.uk> <20050824114351.4e9b49bb.pj@sgi.com> <20050824191544.GM9322@parcelfarce.linux.theplanet.co.uk> <20050824201301.GA23715@mipter.zuzino.mipt.ru> <20050824213859.GN9322@parcelfarce.linux.theplanet.co.uk> <20050825072731.GA876@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050825072731.GA876@mipter.zuzino.mipt.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2005 at 11:27:32AM +0400, Alexey Dobriyan wrote:
> Mine is alpha-unknown-linux-gnu-gcc (GCC) 3.4.4 (Gentoo 3.4.4)
> 
> > Which place triggers it in your build?
> 
> net/ipv4/route.c:3152, call to rt_hash_lock_init().
> 
> >From preprocessed source (reformatted):
> -----------------------------------------------------------------------
> typedef struct {
> 	volatile unsigned int lock;
> 
> 	int on_cpu;
> 	int line_no;
> 	void *previous;
> 	struct task_struct * task;
> 	const char *base_file;
> } spinlock_t;
> 
> static inline void *kmalloc(size_t size, unsigned int flags)

Oh, lovely...

a) gcc4 on alpha refuses to make that inline
b) bug is real, indeed - spinlock debugging + >32 CPU => panic in ip_rt_init()

IMO that's a question to rth: why do we really need to block always_inline
on alpha?

