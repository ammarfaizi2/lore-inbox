Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262804AbTIWANF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 20:13:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263068AbTIWAMj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 20:12:39 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:199 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S262804AbTIWAL2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 20:11:28 -0400
Subject: Re: Can we kill f inb_p, outb_p and other random I/O on port 0x80,
	in 2.6?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: arjanv@redhat.com, Jamie Lokier <jamie@shareable.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <m165jkk5vn.fsf@ebiederm.dsl.xmission.com>
References: <m1isnlk6pq.fsf@ebiederm.dsl.xmission.com>
	 <1064229778.8584.2.camel@dhcp23.swansea.linux.org.uk>
	 <20030922162602.GB27209@mail.jlokier.co.uk>
	 <1064248391.8895.6.camel@dhcp23.swansea.linux.org.uk>
	 <1064250691.6235.2.camel@laptop.fenrus.com>
	 <m165jkk5vn.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1064275788.9832.1.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-7) 
Date: Tue, 23 Sep 2003 01:09:49 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2003-09-22 at 19:58, Eric W. Biederman wrote:
> Alan, can you describe a little more what the original delay is needed
> for?  I don't see it documented in my 8254 data sheet.  The better I
> can understand the problem the better I can write the comments on this
> magic bit of code as I fix it.

If I remember rightly its because it is a 2Mhz part on an 8Mhz bus.

> The oldest machine I have is a 386 MCA system.  Any chance of the bug
> showing up there?  I'd love to have a test case.

No idea

> Another reason for fixing this is we are killing who knows how much
> I/O bandwidth with this stream of failing writes to port 0x80.

Definitely - and if we can boot up with udelay() using some pessimal
value then we don't even need the branch, just the udelay for the 8 ISA
cycles. 

Alan

