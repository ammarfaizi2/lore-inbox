Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264337AbTKZVzE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 16:55:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264351AbTKZVzE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 16:55:04 -0500
Received: from ee.oulu.fi ([130.231.61.23]:45244 "EHLO ee.oulu.fi")
	by vger.kernel.org with ESMTP id S264337AbTKZVzB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 16:55:01 -0500
Date: Wed, 26 Nov 2003 23:54:55 +0200
From: Pekka Pietikainen <pp@ee.oulu.fi>
To: Jamie Lokier <jamie@shareable.org>
Cc: "David S. Miller" <davem@redhat.com>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: Fire Engine??
Message-ID: <20031126215455.GA15502@ee.oulu.fi>
References: <BAY1-DAV15JU71pROHD000040e2@hotmail.com.suse.lists.linux.kernel> <20031125183035.1c17185a.davem@redhat.com.suse.lists.linux.kernel> <p73fzgbzca6.fsf@verdi.suse.de> <20031126113040.3b774360.davem@redhat.com> <20031126200153.GG14383@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20031126200153.GG14383@mail.shareable.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 26, 2003 at 08:01:53PM +0000, Jamie Lokier wrote:
> > Andi, I know this is a problem, but for the millionth time your idea
> > does not work because we don't know if the user asked for the timestamp
> > until we are deep within the recvmsg() processing, which is long after
> > the packet has arrived.
> 
> Do the timestamps need to be precise and accurately reflect the
> arrival time in the irq handler?  Or, for TCP timestamps, would it be
> good enough to use the time when the protocol handlers are run, and
> only read the hardware clock once for a bunch of received packets?  Or
> even use jiffies?

> Apart from TCP, precise timestamps are only used for packet capture,
> and it's easy to keep track globally of whether anyone has packet
> sockets open.
It should probably noted that really hardcore timestamp users 
have their NICs do it for them, since interrupt coalescing 
makes timestamps done in the kernel too inaccurate for them even
if rdtsc is used (http://www-didc.lbl.gov/papers/SCNM-PAM03.pdf)
Not that it's anywhere near a univeral solution since more or less only 
one brand of NICs supports them.

It would probably be a useful experiment to see whether the performance is
improved in a noticeable way if say jiffies were used. If so, it might be a
reasonable choice for a configurable option, if not then not. 
Isn't stuff like this the reason why the experimental network patches tree
that was announced a while back is out there? ;-)
