Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263297AbUCTJ64 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 04:58:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263296AbUCTJ6z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 04:58:55 -0500
Received: from mail.shareable.org ([81.29.64.88]:6543 "EHLO mail.shareable.org")
	by vger.kernel.org with ESMTP id S263294AbUCTJ6s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 04:58:48 -0500
Date: Sat, 20 Mar 2004 09:58:36 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Andi Kleen <ak@muc.de>, linux-raid@vger.kernel.org,
       justin_gibbs@adaptec.com, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: "Enhanced" MD code avaible for review
Message-ID: <20040320095836.GA10398@mail.shareable.org>
References: <1AOTW-4Vx-7@gated-at.bofh.it> <1AOTW-4Vx-5@gated-at.bofh.it> <m3wu5jey76.fsf@averell.firstfloor.org> <405902A2.8060801@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <405902A2.8060801@pobox.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> I'll probably have to illustrate with code, but basically, read/write 
> can be completely ignorant of 32/64-bit architecture, endianness, it can 
> even be network-transparent.  ioctls just can't do that.

Apart from the network transparency, yes they can.

Ioctl is no different from read/write/read-modify-write except
the additional command argument.

You can write architecture-specific ioctls which take and return
structs -- and you can do the same with read/write.  This is what
Andi is thinking of as dangerous: the read/write case is then much
harder to emulate.

Or, you can write architecture-independent read/write, which use fixed
formats, which you seem to have in mind.  That works fine with ioctls too.

It isn't commonly done, because people prefer the convenience of a
struct.  But it does work.  It's slightly easier in the driver to
implement commands this way using an ioctl, because you don't have to
check the read/write length.  It's about the same to use from
userspace: both read/write and ioctl methods using an
architecture-independent data format require the program to lay out
the command bytes and then issue one system call.

-- Jamie
