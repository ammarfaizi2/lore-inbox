Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262731AbTDUXiH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 19:38:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262734AbTDUXiH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 19:38:07 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:9604 "EHLO mail.jlokier.co.uk")
	by vger.kernel.org with ESMTP id S262731AbTDUXiF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 19:38:05 -0400
Date: Tue, 22 Apr 2003 00:50:09 +0100
From: Jamie Lokier <jamie@shareable.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] new system call mknod64
Message-ID: <20030421235009.GC17595@mail.jlokier.co.uk>
References: <UTC200304212143.h3LLh6e02148.aeb@smtp.cwi.nl> <b81tan$637$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b81tan$637$1@cesium.transmeta.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote:
> > and in fact the patches I have been giving out use kdev_t
> > as internal format, where you can think of kdev_t as
> > u64, or, if you prefer, as struct { u32 major, minor; }.
> 
> Any reason why we don't just *make it* a struct?  (Well, besides that
> it'd somewhat suck on 64-bit architectures?)

It varies very much between architectures.

I just checked, and simple copies of this structure are absolutely
atrocious in GCC 3.2 (I tried Alpha, Mips64 and Sparc64).  The code
was approx. 3 times longer to copy the 32:32 struct than to copy a 64
bit scalar.

On x86_64, the struct produces the same code as the scalar.
The same is true on s390x.

If you change this to test 16:16, on i386 (or x86_64 with -m32),
the struct still produces the same code as the scalar.

Looks like a part of GCC that might be easy to improve, given that it
works quite well on some architectures already.

-- Jamie
