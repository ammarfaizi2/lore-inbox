Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268092AbUHXUHc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268092AbUHXUHc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 16:07:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267565AbUHXUHb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 16:07:31 -0400
Received: from fw.osdl.org ([65.172.181.6]:47802 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268262AbUHXUHU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 16:07:20 -0400
Date: Tue, 24 Aug 2004 13:05:31 -0700
From: Andrew Morton <akpm@osdl.org>
To: Dominik Karall <dominik.karall@gmx.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: page allocation failure
Message-Id: <20040824130531.3cbb03d1.akpm@osdl.org>
In-Reply-To: <200408242205.20571.dominik.karall@gmx.net>
References: <200408242205.20571.dominik.karall@gmx.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dominik Karall <dominik.karall@gmx.net> wrote:
>
> is this a kernel bug, or smbd failure? I think it could be caused by kernel 
>  and less memory. Cause the machine is running with 56MB ram. But IMHO I think 
>  the kernel shouldn't handle it this way. Running 2.6.8-rc4-mm1.

It's networking trying to allocate eight physically-contiguous pages with
GFP_ATOMIC.  Can you say "snowball's chance in hell"?

Probably we should kill off those noisy printk's, or make them dependent on
some debugging option.  But we keep on finding quite serious cases, such as
this one.

Sure, networking will recover from memory allocation failures - presumably
by dropping a packet.  But if it's doing frequent atomic 3-order allocations
then it will end up dropping a *lot* of packets, and performance will suffer.
