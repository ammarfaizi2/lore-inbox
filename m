Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261374AbTDICEU (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 22:04:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261387AbTDICEU (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 22:04:20 -0400
Received: from dp.samba.org ([66.70.73.150]:18073 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S261374AbTDICET (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Apr 2003 22:04:19 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Christoph Hellwig <hch@infradead.org>, Paul Mackerras <paulus@au1.ibm.com>,
       Fabrice Bellard <fabrice.bellard@free.fr>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Qemu support for PPC 
In-reply-to: Your message of "07 Apr 2003 12:21:48 +0100."
             <1049714507.2967.29.camel@dhcp22.swansea.linux.org.uk> 
Date: Wed, 09 Apr 2003 12:07:24 +1000
Message-Id: <20030409021558.A186C2C013@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <1049714507.2967.29.camel@dhcp22.swansea.linux.org.uk> you write:
> > This is not qemu specific, of course.  If you say it's not going in,
> > then I'll accept that and do the work inside qemu.  It'll be damn
> > slow, of course.
> 
> WTF should that make it slow ?

Well, there are two obvious methods.  The first, which I've
implemented, builds a tree at start time, which assumes things stay
static, but has significant startup overhead.

The fully dynamic solution (which personality + emul_prefix gives you
at the moment) means that you double every open, every stat, quadruple
every readlink, etc.  Of course, remember to handle relative paths (my
current code punts on this in the hope that noone will notice: we'll
see).

Unfortunately, it's not just /lib and /usr/lib, there's
/var/run/.nscd_socket which doesn't seem to like speaking wrong
endian.

Hey, I'd *love* read-only union mounts which can be done by non-root
(and obviously don't survive exec), but AFAICT noone but Al can write
one acceptable to the VFS maintainer 8).

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
