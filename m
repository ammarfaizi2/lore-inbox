Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264107AbTEOQox (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 12:44:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264110AbTEOQow
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 12:44:52 -0400
Received: from tom.hrz.tu-chemnitz.de ([134.109.132.38]:52967 "EHLO
	tom.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id S264107AbTEOQou (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 12:44:50 -0400
Date: Thu, 15 May 2003 17:58:34 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Muthian Sivathanu <muthian_s@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: isolated memory pools ?
Message-ID: <20030515175834.A626@nightmaster.csn.tu-chemnitz.de>
References: <20030514163558.56819.qmail@web40611.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20030514163558.56819.qmail@web40611.mail.yahoo.com>; from muthian_s@yahoo.com on Wed, May 14, 2003 at 09:35:58AM -0700
X-Spam-Score: -4.5 (----)
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *19GM31-0006BK-00*F6M6pcogLyA*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Muthian,

On Wed, May 14, 2003 at 09:35:58AM -0700, Muthian Sivathanu wrote:
> Ideally, I would like to be able to allocate my own
> memory pool, say, with 10% of the host memory, and
> then have total control over it, i.e. the rest of the
> kernel should not allocate from this space, and my
> local free_pages should return memory back to my local
> pool.  One obvious way to do this would be to pin
> those pages to memory and then write my own memory
> management routines to handle allocations within the
> pool, but that seems time consuming and hard.  Is
> there a way the existing kernel memory management
> routines can be harnessed to manage
> such an isolated free pool ?

#include <linux/mempool.h>

and look at the functions, which implement this.

linux/mm/mempool.c is the actual implementation.

This is not exactly, what you want (you CAN allocate more than
your 10% from this pool and the amount over your minimum number
of pages to be reserved is free for the kernel to use), but
should be what you really need.

Regards

Ingo Oeser

