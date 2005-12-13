Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964794AbVLMInj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964794AbVLMInj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 03:43:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964793AbVLMInj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 03:43:39 -0500
Received: from smtp.osdl.org ([65.172.181.4]:3286 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964780AbVLMInh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 03:43:37 -0500
Date: Tue, 13 Dec 2005 00:42:57 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andi Kleen <ak@suse.de>
Cc: mingo@elte.hu, dhowells@redhat.com, torvalds@osdl.org, hch@infradead.org,
       arjan@infradead.org, matthew@wil.cx, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
Message-Id: <20051213004257.0f87d814.akpm@osdl.org>
In-Reply-To: <20051213075835.GZ15804@wotan.suse.de>
References: <dhowells1134431145@warthog.cambridge.redhat.com>
	<20051212161944.3185a3f9.akpm@osdl.org>
	<20051213075441.GB6765@elte.hu>
	<20051213075835.GZ15804@wotan.suse.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> wrote:
>
> > - i introduced a 'type-sensitive' macro wrapper that switches down() 
> >   (and the other APIs) to either to the assembly variant (if the 
> >   variable's type is struct compat_semaphore), or switches it to the new 
> >   generic mutex (if the type is struct semaphore), at build-time. There 
> >   is no runtime overhead due to this build-time-switching.
> 
> Didn't that drop compatibility with 2.95?  The necessary builtins
> are only in 3.x. 
> 
> Not that I'm not in favour - I would like to use C99 everywhere 
> and it would get of the ugly spinlock workaround for i386
> and x86-64 doesn't support earlier compilers anyways - 
> but others might not agree.
> 

2.95.x is basically buggered at present.  There's one scsi driver which
doesn't compile due to weird __VA_ARGS__ tricks and the rather useful
scsi/sd.c is currently getting an ICE.  None of the new SAS code compiles,
due to extensive use of anonymous unions.  The V4L guys are very good at
exploiting the gcc-2.95.x macro expansion bug (_why_ does each driver need
to implement its own debug macros?) and various people keep on sneaking in
anonymous unions.

It's time to give up on it and just drink more coffee or play more tetris
or something, I'm afraid.
