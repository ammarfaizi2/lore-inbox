Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264386AbTEJPTY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 11:19:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264389AbTEJPTY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 11:19:24 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:51584 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S264386AbTEJPTV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 11:19:21 -0400
Date: Sat, 10 May 2003 16:31:56 +0100
From: Jamie Lokier <jamie@shareable.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i386 uaccess to fixmap pages
Message-ID: <20030510153156.GA29271@mail.jlokier.co.uk>
References: <20030509124042.GB25569@mail.jlokier.co.uk> <Pine.LNX.4.44.0305090856500.9705-100000@home.transmeta.com> <b9hrhg$5v7$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9hrhg$5v7$1@cesium.transmeta.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote:
> Another option would be to put it in the "user" part of the address
> space at 0xbffff000 (and move the %esp base value.)  That would have
> the nice side benefit that stuff like UML or whatever who wanted to
> map something over the vsyscall could do so.  Downside: each process
> needs a PTE for this.

It doesn't need a PTE.  The vsyscall code could be _copied_ to the end
of the page at 0xbffff000, with the stack immediately preceding it.

In fact that's 1 fewer TLB entries than the current arrangement.  The
fork-time copy should be negligable as it is a very small code
fragment.

I suspect this would cause difficulties with the latest ELF and unwind
tables, but apart from that, why _not_ place the vsyscall trampoline
at the end of the stack?

-- Jamie
