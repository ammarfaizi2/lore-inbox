Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964883AbWALA4b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964883AbWALA4b (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 19:56:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964878AbWALA4b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 19:56:31 -0500
Received: from mx2.suse.de ([195.135.220.15]:16805 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964883AbWALA4a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 19:56:30 -0500
From: Andi Kleen <ak@suse.de>
To: "Bryan O'Sullivan" <bos@pathscale.com>
Subject: Re: [PATCH 2 of 2] __raw_memcpy_toio32 for x86_64
Date: Thu, 12 Jan 2006 01:56:11 +0100
User-Agent: KMail/1.8.2
Cc: akpm@osdl.org, rdreier@cisco.com, linux-kernel@vger.kernel.org
References: <f03a807a80b8bc45bf91.1137025776@eng-12.pathscale.com>
In-Reply-To: <f03a807a80b8bc45bf91.1137025776@eng-12.pathscale.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200601120156.11529.ak@suse.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 12 January 2006 01:29, Bryan O'Sullivan wrote:

>  lib-y := csum-partial.o csum-copy.o csum-wrappers.o delay.o \
>  	usercopy.o getuser.o putuser.o  \
> diff -r cd6d8a62dad5 -r f03a807a80b8 arch/x86_64/lib/raw_memcpy_io.S
> --- /dev/null	Thu Jan  1 00:00:00 1970 +0000
> +++ b/arch/x86_64/lib/raw_memcpy_io.S	Wed Jan 11 16:26:59 2006 -0800
> @@ -0,0 +1,29 @@
> +/*
> + * Copyright 2006 PathScale, Inc.  All Rights Reserved.

At least some people have complained about the "All Rights reserved"
in the past. Best you drop it.


> +/*
> + * override generic version in lib/raw_memcpy_io.c
> + */
> + 	.globl __raw_memcpy_toio32

Usually one should use .p2align or ENTRY() at function beginning,
otherwise you might get some penalty on K8.

> +__raw_memcpy_toio32:
> +	movl %edx,%ecx
> +	shrl $1,%ecx

1? If it's called memcpy it should get a byte argument, no? If not
name it something else, otherwise everybody will be confused. 

> +	andl $1,%edx
> +	rep movsq

movsq? I thought you wanted 32bit IO? 

The movsd also looks weird.

-Andi
