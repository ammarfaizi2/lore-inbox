Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262497AbTJOKWF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 06:22:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262536AbTJOKWF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 06:22:05 -0400
Received: from fw.osdl.org ([65.172.181.6]:25521 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262497AbTJOKWD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 06:22:03 -0400
Date: Wed, 15 Oct 2003 03:25:39 -0700
From: Andrew Morton <akpm@osdl.org>
To: Holger Kiehl <Holger.Kiehl@dwd.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Finding memory leak
Message-Id: <20031015032539.4cfe71c7.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.44.0310141345070.17096-100000@praktifix.dwd.de>
References: <Pine.LNX.4.44.0310141345070.17096-100000@praktifix.dwd.de>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Holger Kiehl <Holger.Kiehl@dwd.de> wrote:
>
>    - Is it correct to assume that an application cannot be the cause
>       of the leak, ie. it can only be in kernel or a driver?

Yes.

>     - How can I really prove that its the driver leaking the memory?

Look for instances of kmalloc(n, ...) for n in the range 1025 to 2048 which
do not have a matching kfree.

>     - What is the meaning of size-2048 in slabinfo?

It is the pool which is used to satisfy kmalloc requests in the range 1025
to 2048 bytes inclusive.

