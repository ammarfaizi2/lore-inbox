Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267251AbUBSNNl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 08:13:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267242AbUBSNNl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 08:13:41 -0500
Received: from pr-117-210.ains.net.au ([202.147.117.210]:61125 "EHLO
	mail.ocs.com.au") by vger.kernel.org with ESMTP id S267251AbUBSNNh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 08:13:37 -0500
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Matthew Rench <lists@pelennor.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: problem rmmod'ing module 
In-reply-to: Your message of "Wed, 18 Feb 2004 12:58:40 MDT."
             <20040218125840.A25346@pelennor.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 20 Feb 2004 00:13:20 +1100
Message-ID: <5651.1077196400@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Feb 2004 12:58:40 -0600, 
Matthew Rench <lists@pelennor.net> wrote:
>Feb 17 13:56:35 aragorn kernel:  <1>Unable to handle kernel NULL pointer derefer
>ence at virtual address 00000000
>Feb 17 13:56:35 aragorn kernel: c0118b7e
>Feb 17 13:56:35 aragorn kernel: *pde = 00000000
>Feb 17 13:56:35 aragorn kernel: Oops: 0000
>Feb 17 13:56:35 aragorn kernel: CPU:    0
>Feb 17 13:56:35 aragorn kernel: EIP:    0010:[qm_symbols+194/500]    Not tainted
>Feb 17 13:56:35 aragorn kernel: EFLAGS: 00010246
>Feb 17 13:56:35 aragorn kernel: eax: 00000000   ebx: 00000000   ecx: ffffffff   
>edx: 00000000
>Feb 17 13:56:35 aragorn kernel: esi: 00000048   edi: 00000000   ebp: d881bc24   
>esp: cb3dbf7c

That corresponds to kernel/module.c::qm_symbols, line 837:838

	for (; i < mod->nsyms ; ++i, ++s, vals += 2) {
		len = strlen(s->name)+1;

The symbol table for the module has been corrupted, one of the string
pointers is NULL.

>By the way, I don't suppose there's any way to clean this up without
>rebooting, is there?

Afraid not.

