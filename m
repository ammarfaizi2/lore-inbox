Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261180AbTIKOY0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 10:24:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261186AbTIKOY0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 10:24:26 -0400
Received: from ns.suse.de ([195.135.220.2]:6297 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261180AbTIKOYZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 10:24:25 -0400
Date: Thu, 11 Sep 2003 16:24:21 +0200
From: Andi Kleen <ak@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: torvalds@osdl.org, richard.brunner@amd.com, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [PATCH] 2.6 workaround for Athlon/Opteron prefetch errata
Message-Id: <20030911162421.419f4432.ak@suse.de>
In-Reply-To: <1063289641.2967.3.camel@dhcp23.swansea.linux.org.uk>
References: <Pine.LNX.4.44.0309110650390.28410-100000@home.osdl.org>
	<1063289641.2967.3.camel@dhcp23.swansea.linux.org.uk>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Sep 2003 15:14:02 +0100
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> 
> There is *one* change needed. We shouldnt call is_prefetch unless the
> current CPU is an Athlon. That way its a performance improvement for
> PIV, and Athlon in general, fixes the bug and causes no fancy athlon
> fixup code for non AMD processors.

I considered that when writing the patch, but: is_prefetch is a single byte 
memory access for something already in cache. Checking for an Athlon
CPU needs two memory accesses in boot_cpu_data at least (checking vendor
and model) 

So checking for Athlon first would be actually more expensive for other CPUs.

The switch is left in the noise, gcc compiles it to very efficient code.

This ignores the possibility of a recursive fault in the __get_user, but these
are rather unlikely. Normal page-on-demand code faults are handled 
before is_prefetch is reached.

-Andi 
