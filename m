Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263536AbTJCGe0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 02:34:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263543AbTJCGe0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 02:34:26 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:56455 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S263536AbTJCGeS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 02:34:18 -0400
Date: Fri, 3 Oct 2003 07:34:11 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Catalin BOIE <util@deuroconsult.ro>
Cc: linux-kernel@vger.kernel.org
Subject: Re: idt change in a running kernel? what locking?
Message-ID: <20031003063411.GF15691@mail.shareable.org>
References: <Pine.LNX.4.58.0310030850110.10930@hosting.rdsbv.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0310030850110.10930@hosting.rdsbv.ro>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Catalin BOIE wrote:
> What may happen if I modify idt on a running kernel?
> It's lock_kernel enough?

lock_kernel won't help at all.  It doesn't disable interrupts.

It's more likely, you want to use get_cpu()/put_cpu() to prevent the
current kernel thread from being pre-empted to a different CPU.

> Of course that the new location contain a valid idt table.

If the new table has the same entries as the old one for all
interrupts which are enabled it should be fine.  "lidt" is an atomic
operation with respect to interrupts.

If you are intending to change idt on all CPUs, you'll need something
more complicated.

-- Jamie
