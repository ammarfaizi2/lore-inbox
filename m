Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266982AbTAIUKN>; Thu, 9 Jan 2003 15:10:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267731AbTAIUKN>; Thu, 9 Jan 2003 15:10:13 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:19725 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S266982AbTAIUKL>; Thu, 9 Jan 2003 15:10:11 -0500
Date: Thu, 9 Jan 2003 12:18:01 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Luca Barbieri <ldb@ldb.ods.org>
cc: Linux-Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Use %ebp rather than %ebx for thread_info pointer
In-Reply-To: <20030109194935.GA2098@ldb>
Message-ID: <Pine.LNX.4.44.0301091216490.1890-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 9 Jan 2003, Luca Barbieri wrote:
>
> This patch changes assembly code that accesses thread_info to use %ebp
> rather than %ebx. 
> 
> This allows me to take advantage of the fact that %ebp is restored by
> user mode in the sysenter register pop removal patch.

Hmm.. Did you check what fork/execve/vm86 do? I know at least the vm86()  
stuff sets up %ebx before calling the asm functions in entry.S, I bet 
those need to be changed to use %ebp too with something like this.

		Linus

