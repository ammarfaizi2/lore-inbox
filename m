Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932165AbWIZR0n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932165AbWIZR0n (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 13:26:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932166AbWIZR0n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 13:26:43 -0400
Received: from mx1.redhat.com ([66.187.233.31]:56787 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932165AbWIZR0m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 13:26:42 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <Pine.LNX.4.64.0609260909470.3952@g5.osdl.org> 
References: <Pine.LNX.4.64.0609260909470.3952@g5.osdl.org>  <20060925142016.GI29920@ftp.linux.org.uk> <1159186771.11049.63.camel@localhost.localdomain> <1159183568.11049.51.camel@localhost.localdomain> <20060924223925.GU29920@ftp.linux.org.uk> <22314.1159181060@warthog.cambridge.redhat.com> <5578.1159183668@warthog.cambridge.redhat.com> <7276.1159186684@warthog.cambridge.redhat.com> <20660.1159195152@warthog.cambridge.redhat.com> <1159199184.11049.93.camel@localhost.localdomain> <1159258013.3309.9.camel@pmac.infradead.org> <4518EA39.40309@pobox.com> <1159260980.3309.22.camel@pmac.infradead.org> 
To: Linus Torvalds <torvalds@osdl.org>
Cc: David Woodhouse <dwmw2@infradead.org>, Jeff Garzik <jgarzik@pobox.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       David Howells <dhowells@redhat.com>, Al Viro <viro@ftp.linux.org.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] restore libata build on frv 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Tue, 26 Sep 2006 18:25:28 +0100
Message-ID: <7848.1159291528@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus Torvalds <torvalds@osdl.org> wrote:

> Zero _is_ an appropriate choice, dammit!
> ...
> and then, if your actual _hardware_ things that the bit-pattern with all 
> bits clear is a valid irq that can be used for normal devices,

PCI, for example.  According to the spec, 0x00 is valid in the Interrupt Line
register and 0xFF indicates unconnected or unset.

> then what you do is you add a irq number translation layer (WHICH WE NEED
> AND HAVE _ANYWAY_) and make sure that nobody sees that on a _software_
> level.

So, by your argument, if you _have_ to have an IRQ translation layer anyway,
then what's the problem with having zero as a valid IRQ and using some other
value to indicate an invalid IRQ?  As you say, you have a translation layer
anyway...

That would mean the arch maintainer could make the optimal choice for their
arch - perhaps picking 255 which would be consistent with PCI.

As far as FRV goes, I'm quite happy with 0 as being NO_IRQ, since the 0 bit in
the primary PIC registers is the master switch, not a per-level bit (there are
no source indicators unfortunately).

However, x86, x86_64, and others *do* treat IRQ 0 as being valid, and expose
it to userspace in various ways:

	warthog>cat /proc/interrupts 
		   CPU0       
	  0:  287035291    IO-APIC-edge  timer
	...

So on *that* basis, using IRQ 0 to indicate unset/invalid/etc would seem to be
bad.

David
