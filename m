Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265354AbUAYX0a (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 18:26:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265357AbUAYX0a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 18:26:30 -0500
Received: from fw.osdl.org ([65.172.181.6]:20205 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265354AbUAYX01 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 18:26:27 -0500
Date: Sun, 25 Jan 2004 15:25:59 -0800
From: Andrew Morton <akpm@osdl.org>
To: Eric <eric@cisu.net>
Cc: sboyce@blueyonder.co.uk, linux-kernel@vger.kernel.org, bunk@fs.tum.de,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: 2.6.2-rc1-mm2 kernel oops
Message-Id: <20040125152559.55165860.akpm@osdl.org>
In-Reply-To: <200401251714.57799.eric@cisu.net>
References: <4013D0AA.8060906@blueyonder.co.uk>
	<16404.8968.349900.566999@gargle.gargle.HOWL>
	<4014283D.9040207@blueyonder.co.uk>
	<200401251714.57799.eric@cisu.net>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric <eric@cisu.net> wrote:
>
> 	I am now having this problem. See the thread "Kernels > 2.6.1-mm3 do not 
>  boot." I had a kernel that would hang after uncompressing. Seems that gcc 3.3 
>  generates bad code w/ -funit-at-a-time. Now I get the test_wp_bit oops w/ 
>  kernel version 2.6.2-rc2-mm2.
>  	Since I have already commented out the line.. and it led to this oops, what 
>  the heck is the real problem here?
>  	Seems alot of other SMP systems are breaking with this too.

Pretty simple:

init/main.c does

	mem_init();
	kmem_cache_init();
	sort_main_extable();

but mem_init() calls test_wp_bit().  The exception tables haven't been
sorted yet.

