Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263266AbTIVS6b (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 14:58:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263267AbTIVS6a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 14:58:30 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:40765 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S263266AbTIVS61 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 14:58:27 -0400
To: arjanv@redhat.com
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jamie Lokier <jamie@shareable.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Can we kill f inb_p, outb_p and other random I/O on port 0x80, in 2.6?
References: <m1isnlk6pq.fsf@ebiederm.dsl.xmission.com>
	<1064229778.8584.2.camel@dhcp23.swansea.linux.org.uk>
	<20030922162602.GB27209@mail.jlokier.co.uk>
	<1064248391.8895.6.camel@dhcp23.swansea.linux.org.uk>
	<1064250691.6235.2.camel@laptop.fenrus.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 22 Sep 2003 12:58:04 -0600
In-Reply-To: <1064250691.6235.2.camel@laptop.fenrus.com>
Message-ID: <m165jkk5vn.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjanv@redhat.com> writes:

> On Mon, 2003-09-22 at 18:33, Alan Cox wrote:
> \
> > > I've also seen much DOS code that didn't have extra delays for
> > > keyboard I/Os.  What sort of breakage did you observe with the
> > > keyboard?
> > 
> > DEC laptops hang is the well known example of that one.
> > 
> > I'm *for* making this change to udelay, it just has to start up with a
> > suitably pessimal udelay assumption until calibrated.
> 
> or we make udelay() do the port 80 access in the uncalibrated case....
> 
> The first person to complain about the extra branch miss in udelay for
> this will get laughed at by me ;)

Sounds like a solution.  I will see what I can do in that direction.
Maintaining a suitably pessimistic udelay with multi gigahertz chips
sounds like a challenge, so using outb to port 0x80 may be a
reasonable solution there. 

Alan, can you describe a little more what the original delay is needed
for?  I don't see it documented in my 8254 data sheet.  The better I
can understand the problem the better I can write the comments on this
magic bit of code as I fix it.

The oldest machine I have is a 386 MCA system.  Any chance of the bug
showing up there?  I'd love to have a test case.

Another reason for fixing this is we are killing who knows how much
I/O bandwidth with this stream of failing writes to port 0x80.

Eric
