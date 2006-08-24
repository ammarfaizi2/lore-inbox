Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422769AbWHXWWB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422769AbWHXWWB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 18:22:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422768AbWHXWWA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 18:22:00 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:57741 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1422766AbWHXWV7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 18:21:59 -0400
Subject: Re: Serial custom speed deprecated?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: linux-serial@vger.kernel.org, "'LKML'" <linux-kernel@vger.kernel.org>,
       libc-alpha@sources.redhat.com
In-Reply-To: <m31wr6otlr.fsf@defiant.localdomain>
References: <028a01c6c6fc$e792be90$294b82ce@stuartm>
	 <1156411101.3012.15.camel@pmac.infradead.org>
	 <m3bqqap09a.fsf@defiant.localdomain>
	 <1156441293.3007.184.camel@localhost.localdomain>
	 <m31wr6otlr.fsf@defiant.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 24 Aug 2006 23:43:07 +0100
Message-Id: <1156459387.3007.218.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Iau, 2006-08-24 am 20:51 +0200, ysgrifennodd Krzysztof Halasa:
> Hmm... I'm not sure if I understand this correctly. Can't we just
> create the 3 new ioctls in the kernel and teach glibc to use it?

We could implement an entirely new TCSETS/TCGETS/TCSETSA/SAW which used
different B* values so B9600 was 9600 etc and the data was stored in
c_ospeed/c_ispeed type separate fields and we'd support arbitary speeds
for input and output once and for all, shoot all the multiplier hacks
etc. As it happens the kernel code for this is easy owing to some
fortuitous good design long ago in the tty layer.

We could also implement a Linux "improved" TCSET* new set of ioctls that
had sensible speed fields, utf-8 characters for the _cc[] array and new
flags for all the utf-8 handling and the like. That would be less
compatible though.

Or we could just add a standardised extra set of speed ioctls, but then
we need to decide what occurs if I set the speed and then issue a
termios call - does it override or not.

> The old ioctls would be optional in the kernel (and perhaps in glibc,
> sometime).

The kernel side translation is thankfully really trivial.

> Not sure if we want int, uint, or long long for speed values :-)

You want speed_t according to POSIX.

I've no idea what the glibc impact of this kind of thing would be
(consider new glibc, old kernel etc).  I've cc'd the libc folks but I am
not sure it is practical to do.

Alan

