Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750811AbVJJQKP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750811AbVJJQKP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 12:10:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750847AbVJJQKP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 12:10:15 -0400
Received: from kanga.kvack.org ([66.96.29.28]:16851 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S1750811AbVJJQKO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 12:10:14 -0400
Date: Mon, 10 Oct 2005 12:08:56 -0400
From: Benjamin LaHaise <bcrl@kvack.org>
To: Karthik Sarangan <karthiks@cdac.in>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: AIO!!
Message-ID: <20051010160856.GI13986@kvack.org>
References: <434A6EFC.4010100@cdac.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <434A6EFC.4010100@cdac.in>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 10, 2005 at 07:09:08PM +0530, Karthik Sarangan wrote:
> I wrote a small program to do Async IO from a raw disk
> open has no problems.
> My program gets stuck up at aio_read(paio);
> !!WHY!!

O_DIRECT buffers must be aligned on block sized boundaries (minimum 512 
bytes).  Check the actual return code from the aiocb and you'll find that 
it is likely -EINVAL, no -EINPROGRESS.  See the man page for 
posix_memalign() to properly align the pointer.

		-ben
