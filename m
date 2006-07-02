Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964831AbWGBLOX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964831AbWGBLOX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jul 2006 07:14:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932668AbWGBLOX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jul 2006 07:14:23 -0400
Received: from smtp.osdl.org ([65.172.181.4]:64686 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932484AbWGBLOX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jul 2006 07:14:23 -0400
Date: Sun, 2 Jul 2006 04:14:15 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andy Whitcroft <apw@shadowen.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-mm5
Message-Id: <20060702041415.d35c3e90.akpm@osdl.org>
In-Reply-To: <44A7A29A.9050908@shadowen.org>
References: <20060701033524.3c478698.akpm@osdl.org>
	<44A799E4.5010803@shadowen.org>
	<20060702031457.f5995b38.akpm@osdl.org>
	<44A7A29A.9050908@shadowen.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 02 Jul 2006 11:40:26 +0100
Andy Whitcroft <apw@shadowen.org> wrote:

> > Well there are only a handful of divides in find_busiest_group().  Wanna
> > have a poke around in gdb and work out which one you're hitting?
> 
> Sure I'll see what information I can get on this one.

Easy way:

Set CONFIG_DEBUG_INFO, do:

make kernel/sched.o
gdb kernel/sched.o
(gdb) p find_busiest_group
$1 = {struct sched_group *(struct sched_domain *, int, long unsigned int *, 
    enum idle_type, int *)} 0xff0 <find_busiest_group>
(gdb) l *(0xff0 + 0x1a3)

