Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263909AbUCZDaF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 22:30:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263910AbUCZDaE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 22:30:04 -0500
Received: from mail.cyclades.com ([64.186.161.6]:11215 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S263909AbUCZD30
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 22:29:26 -0500
Date: Thu, 25 Mar 2004 17:52:48 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH/2.4]: do_write_mem() return value check
Message-ID: <20040325205248.GA18172@logos.cnet>
References: <200403231707.14088.blaisorblade_work@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200403231707.14088.blaisorblade_work@yahoo.it>
User-Agent: Mutt/1.5.5.1i
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 24, 2004 at 07:59:01PM +0100, BlaisorBlade wrote:
> From: Andrew Morton, and me (I did a first fix for 2.6 and sent to him, he 
> checked everything and committed it and I changed the trivial bits for 2.4).
> 
> - remove unused `file *' arg from do_write_mem()
> 
> - Add checking for copy_from_user() failures in do_write_mem()
> 
> (Note: /dev/kmem can be written to only by root, so this *cannot* have 
> security implications)
> 
> - Return correct value from kmem writes() when a fault is encountered.  A
>   write()-style syscall's return values are:
> 
>    0 when nothing was written and there was no error (someone tried to
>    write zero bytes)
> 
>    >0: the number of bytes copied, whether or not there was an error. 
>    Userspace detects errors by noting that the write() return value is less
>    than was requested.
> 
>    <0: there was an error and no bytes were copied
> 
> TODO: Do the same changes for read_mem() and read_kmem(). The code is more 
> messy so I must create do_read_mem() to avoid clumsy counting; I will post the 
> patch first for 2.6.

Hi Paolo, 

This is nice -- although I see it as a 2.6 cleanup only.

Do you actually have any practical problem caused by the current broken 
"always return -EFAULT" ? 

Otherwise leave it for 2.6.
