Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130145AbRCBXib>; Fri, 2 Mar 2001 18:38:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130153AbRCBXiW>; Fri, 2 Mar 2001 18:38:22 -0500
Received: from ns1.uklinux.net ([212.1.130.11]:49929 "EHLO s1.uklinux.net")
	by vger.kernel.org with ESMTP id <S130145AbRCBXiH>;
	Fri, 2 Mar 2001 18:38:07 -0500
Envelope-To: linux-kernel@vger.kernel.org
From: Russell King <rmk@arm.linux.org.uk>
Message-Id: <200103022337.XAA01526@raistlin.arm.linux.org.uk>
Subject: Re: [PATCH] alloc_tty_struct() wastage?
To: hugh@veritas.com (Hugh Dickins)
Date: Fri, 2 Mar 2001 23:37:26 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), tytso@mit.edu (Theodore Ts'o),
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0103022326070.1719-100000@localhost.localdomain> from "Hugh Dickins" at Mar 02, 2001 11:29:02 PM
X-Location: london.england.earth.mulky-way.universe
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins writes:
> I've been puzzling over alloc_tty_struct(), which seems determined
> to waste memory on a machine of page size 8KB.

Maybe you could change the ">" to ">="?

> I've come to the conclusion that it represents great caution on
> Russell's part when introducing ARM, not to interfere with
> existing code of other architectures - is that so, Russell?

My understanding of the usage of get_free_page there is as follows:
The problem was that sizeof(struct tty_struct) was very close to
the page size of x86 machines (4K), and kmalloc wasted space
unnecessarily.  Therefore get_free_page was used by x86 to allocate
this structure.  I think I'm right in saying that allocating
anything larger than half your page size is best done with
get_free_page.

Someone will probably correct me on that comment above though.
Can someone confirm please: is it safe and reasonable to use
kmalloc on allocating tty_struct on all architectures now?

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

