Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263617AbTJQWua (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 18:50:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261245AbTJQWua
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 18:50:30 -0400
Received: from fw.osdl.org ([65.172.181.6]:8620 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261193AbTJQWu0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 18:50:26 -0400
Date: Fri, 17 Oct 2003 15:50:28 -0700
From: Andrew Morton <akpm@osdl.org>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] prevent "dd if=/dev/mem" crash
Message-Id: <20031017155028.2e98b307.akpm@osdl.org>
In-Reply-To: <200310171610.36569.bjorn.helgaas@hp.com>
References: <200310171610.36569.bjorn.helgaas@hp.com>
X-Mailer: Sylpheed version 0.9.6 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bjorn Helgaas <bjorn.helgaas@hp.com> wrote:
>
> Old behavior:
> 
>     # dd if=/dev/mem of=/dev/null
>     <unrecoverable machine check>

I recently fixed this for ia32 by changing copy_to_user() to not oops if
the source address generated a fault.  Similarly copy_from_user() returns
an error if the destination generates a fault.

In other words: drivers/char/mem.c requires that the architecture's
copy_*_user() functions correctly handle faults on either the source or
dest of the copy.

