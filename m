Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268986AbTBSGHB>; Wed, 19 Feb 2003 01:07:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268987AbTBSGHB>; Wed, 19 Feb 2003 01:07:01 -0500
Received: from are.twiddle.net ([64.81.246.98]:21914 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S268986AbTBSGHB>;
	Wed, 19 Feb 2003 01:07:01 -0500
Date: Tue, 18 Feb 2003 22:16:56 -0800
From: Richard Henderson <rth@twiddle.net>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: rusty@rustcorp.com.au, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] eliminate warnings in generated module files
Message-ID: <20030218221656.A23989@twiddle.net>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	rusty@rustcorp.com.au, linux-kernel@vger.kernel.org
References: <20030218194351.A23525@twiddle.net> <Pine.LNX.4.44.0302182115500.1923-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0302182115500.1923-100000@home.transmeta.com>; from torvalds@transmeta.com on Tue, Feb 18, 2003 at 09:16:35PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2003 at 09:16:35PM -0800, Linus Torvalds wrote:
> Some people are still using 2.95, I think anything past that is long since 
> unsupported and not worth worrying about.

[kanga:~] cat z.c
static char foo []
  __attribute__((unused))
  __attribute__((section(".data.foo")))
  = "asdfasdf";
[kanga:~] /usr/bin/gcc -Wall -c z.c
[kanga:~] /usr/bin/gcc -v
Reading specs from /usr/lib/gcc-lib/alpha-linux/2.95.4/specs
gcc version 2.95.4 20011002 (Debian prerelease)
[kanga:~] objdump -h z.o | grep foo
  3 .data.foo     00000009  0000000000000000  0000000000000000  00000040  2**0

Seems to work, both wrt the warning message and 
honoring the section directive.


r~
