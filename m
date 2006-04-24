Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751241AbWDXUd7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751241AbWDXUd7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 16:33:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751240AbWDXUd7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 16:33:59 -0400
Received: from smtp.osdl.org ([65.172.181.4]:52891 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751242AbWDXUd6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 16:33:58 -0400
Date: Mon, 24 Apr 2006 13:32:34 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: linux-kernel@vger.kernel.org, ericy@cais.com
Subject: Re: [PATCH] binfmt_elf CodingStyle cleanup and remove some
 pointless casts
Message-Id: <20060424133234.34a29533.akpm@osdl.org>
In-Reply-To: <200604241932.49912.jesper.juhl@gmail.com>
References: <200604231858.15646.jesper.juhl@gmail.com>
	<20060423142648.6ef34b9f.akpm@osdl.org>
	<9a8748490604240015s61b8b897r34a8be65dc9bac22@mail.gmail.com>
	<200604241932.49912.jesper.juhl@gmail.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl <jesper.juhl@gmail.com> wrote:
>
> We still need to cast u_platform from pointer to integer or gcc will yell 
>  at us. But, I don't see why we should first cast it to `unsigned long' and 
>  then to elf_addr_t, so I removed the `unsigned long' cast.

On 64 bit platforms, these:

	some_pointer = (something *)some_u32;
	some_u32 = (u32)pointer;

will generate compile warnings concerning the differently-sized quantities
on the lhs and rhs.

The usual way of suppressing this is

	some_pointer = (something *)(unsigned long)some_u32;
	some_u32 = (unsigned long)pointer;

