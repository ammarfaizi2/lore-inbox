Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270470AbTGUQKl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 12:10:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270472AbTGUQKM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 12:10:12 -0400
Received: from supreme.pcug.org.au ([203.10.76.34]:43164 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id S270470AbTGUQJk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 12:09:40 -0400
Date: Tue, 22 Jul 2003 02:24:24 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Kurt Roeckx <Q@ping.be>
Cc: linux-kernel@vger.kernel.org
Subject: Re: siginfo pad problem.
Message-Id: <20030722022424.7480af8e.sfr@canb.auug.org.au>
In-Reply-To: <20030721142259.GA4315@ping.be>
References: <20030721142259.GA4315@ping.be>
X-Mailer: Sylpheed version 0.9.3 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Jul 2003 16:23:00 +0200 Kurt Roeckx <Q@ping.be> wrote:
>
> It seems the _timer part of siginfo is a little bit broken.
> 
> It has:
>                         char _pad[sizeof( __ARCH_SI_UID_T) - sizeof(int)];
> 
> Where __ARCH_SI_UID_T can be a short.

Except __ARCH_SI_UID_T is defined to be uid_t everywhere except sparc
where it is "unsigned int".  In include/linux/types.h, uid_t is typdef'ed
to be __kernel_uid32_t (in the kernel), so __ARCH_SI_UID_T is always (at
least) 32 bits.

I was worried about that the first time I saw it as well.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
