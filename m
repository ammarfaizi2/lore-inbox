Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275319AbTHSDds (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 23:33:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275320AbTHSDds
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 23:33:48 -0400
Received: from fw.osdl.org ([65.172.181.6]:62389 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S275319AbTHSDdq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 23:33:46 -0400
Date: Mon, 18 Aug 2003 20:35:13 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: davej@redhat.com, mpm@selenic.com, linux-kernel@vger.kernel.org
Subject: Re: Debug: sleeping function called from invalid context
Message-Id: <20030818203513.393c4a48.akpm@osdl.org>
In-Reply-To: <32789.4.4.25.4.1061263463.squirrel@www.osdl.org>
References: <20030815101856.3eb1e15a.rddunlap@osdl.org>
	<20030815173246.GB9681@redhat.com>
	<20030815123053.2f81ec0a.rddunlap@osdl.org>
	<20030816070652.GG325@waste.org>
	<20030818140729.2e3b02f2.rddunlap@osdl.org>
	<20030819001316.GF22433@redhat.com>
	<20030818171545.5aa630a0.akpm@osdl.org>
	<32789.4.4.25.4.1061263463.squirrel@www.osdl.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Randy.Dunlap" <rddunlap@osdl.org> wrote:
>
> Debug: sleeping function called with interrupts disabled at
>  include/asm/uaccess.h:473

OK, now my vague understanding of what's going on is that the app has
chosen to disable local interupts (via iopl()) and has taken a vm86 trap. 
I guess we'd see the same thing if the app performed some sleeping syscall
while interrupts are disabled.

If that is correct then it really is just a false positive.

It could also point at a bug in the application; it is presumably disabling
interrupts for some form of locking, atomicity or timing guarantee.  But it
will not lock against other CPUs and the fact that it trapped into the
kernel indicates tat it may not be getting the atomicity which it desires.

