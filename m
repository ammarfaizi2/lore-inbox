Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263303AbUAXXjO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 18:39:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263310AbUAXXjO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 18:39:14 -0500
Received: from fw.osdl.org ([65.172.181.6]:55972 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263303AbUAXXjN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 18:39:13 -0500
Date: Sat, 24 Jan 2004 15:39:10 -0800
From: Andrew Morton <akpm@osdl.org>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, piggin@cyberone.com.au
Subject: Re: [PATCH][2.6-mm] Fix CONFIG_SMT oops on UP
Message-Id: <20040124153910.2421e35a.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0401241303070.26103@montezuma.fsmlabs.com>
References: <Pine.LNX.4.58.0401241303070.26103@montezuma.fsmlabs.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo <zwane@arm.linux.org.uk> wrote:
>
> +	cpu_sibling_map[0] = CPU_MASK_NONE;

alas, this will not compile with NR_CPUS > 4*BITS_PER_LONG because this:

	#define CPU_MASK_NONE   { {[0 ... CPU_ARRAY_SIZE-1] =  0UL} }

is not a suitable rhs - it can only be used for initalisers.  Fixing this
would be appreciated.

Meanwhile, I'll use cpus_clear() in there.

