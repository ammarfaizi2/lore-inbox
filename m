Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261196AbULWQiy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261196AbULWQiy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Dec 2004 11:38:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261197AbULWQix
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Dec 2004 11:38:53 -0500
Received: from fsmlabs.com ([168.103.115.128]:56523 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S261196AbULWQit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Dec 2004 11:38:49 -0500
Date: Thu, 23 Dec 2004 09:38:53 -0700 (MST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Zhenyu Wu <y030729@njupt.edu.cn>
cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel BUG at slab.c:1128!
In-Reply-To: <303791597.15361@njupt.edu.cn>
Message-ID: <Pine.LNX.4.61.0412230937460.7013@montezuma.fsmlabs.com>
References: <303791597.15361@njupt.edu.cn>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Dec 2004, Zhenyu Wu wrote:

> when i am going to add some code in the linux kernel source code, i meet such
> questions:
> 
> kernel BUG at slab.c: 1128
> 
> Kernel panic: Aiee, killing interrupt handler!
> In interrupt handler -not syncing.
> 
> Reading from slab.c 1128, there is a check -in_interrupt(), have called some
> fuctions in the interrupt handler?
> But i just use "Kmalloc" to allocate some memory, is it the matter?

If you want to call kmalloc from interrupt context you have to do it with 
the GFP_ATOMIC flag to specify that you do not want to sleep, in which 
case there is an increased chance that your request won't be met so you 
have to have error handling in case of allocation failure.
