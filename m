Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270814AbTHKBEM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 21:04:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270817AbTHKBEM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 21:04:12 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:19589 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S270814AbTHKBEL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 21:04:11 -0400
Date: Mon, 11 Aug 2003 02:04:10 +0100
From: Jamie Lokier <jamie@shareable.org>
To: linux-kernel@vger.kernel.org
Subject: Re: NULL.  Again.  (was Re: [PATCH] 2.4.22pre10: {,un}likely_p())
Message-ID: <20030811010410.GC10446@mail.jlokier.co.uk>
References: <1060087479.796.50.camel@cube> <20030809002117.GB26375@mail.jlokier.co.uk> <20030809081346.GC29616@alpha.home.local> <20030809015142.56190015.davem@redhat.com> <1060425774.4933.73.camel@dhcp22.swansea.linux.org.uk> <20030809162332.GB29647@mail.jlokier.co.uk> <20030809173001.GG24349@perlsupport.com> <6ufzkad8w1.fsf@zork.zork.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ufzkad8w1.fsf@zork.zork.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Neakums wrote:
> I had thought that the need for writing NULL where a pointer is
> expected in varags functions was because the machine may have
> different sizes for pointers and int.  In the case of the second
> printf call above, if pointers are 64-bit and integers are 32-bit,
> printf will read eight bytes from the stack, and only four will have
> been occupied by the integer 0.

It is incorrect to write NULL as a varargs argument.  It won't
necessarily pass a pointer because:

   1. a valid definition of NULL is "0".

If you want to pass a pointer to varargs, you might have considered
writing "(void *) 0", but that doesn't work because:

   2. a machine may have different sizes for different pointer types.

You must write "(type) 0" or "(type) NULL", using the correct pointer type.

-- Jamie
