Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263157AbTJBCEW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 22:04:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263163AbTJBCEW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 22:04:22 -0400
Received: from web41408.mail.yahoo.com ([66.218.93.74]:46992 "HELO
	web41408.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263157AbTJBCEM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 22:04:12 -0400
Message-ID: <20031002020411.65718.qmail@web41408.mail.yahoo.com>
Date: Wed, 1 Oct 2003 22:04:11 -0400 (EDT)
From: David Gordon <davidgordonca@yahoo.ca>
Subject: Re: [ANNOUNCE] DigSig 0.2: kernel module for digital  signatureverification for binaries
To: Edgar Toernig <froese@gmx.de>, Radu Filip <socrate@infoiasi.ro>
Cc: viro@parcelfarce.linux.theplanet.co.uk,
       Makan Pourzandi <Makan.Pourzandi@ericsson.ca>,
       Pavel Machek <pavel@suse.cz>, linux-kernel@vger.kernel.org,
       Axelle Apvrille <Axelle.Apvrille@ericsson.ca>,
       Vincent Roy <vincent.roy@ericsson.ca>,
       David Gordon <davidgordonca@yahoo.ca>
In-Reply-To: <3F7B6EB5.78245F53@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The "How do I make sure that only licensed software
> will run on my new gizmo?" problem?
> 
> Why should an open source developer encourage this?

Digital signatures in open source software are aimed
at running only allowed (read signed) binaries, the
license question is a side issue. IMHO, this has a
potential to increase the security of a Linux box.

> AFAICS if I want to exec something, I can avoid 
> exec() syscall and do mmaps by hand...
> 				Pavel

That is true. A digital signature will only protect
binary data on hard disk. The whole process from the
hard disk to memory is harder to cover (see
http://www.phrack.org/show.php?p=59&a=5 Short Stories
about execve). I believe that digital signature
verification in the kernel must be placed as close as
possible to the actual mmap of the binary. LSM
framework is the current way of implementing this but
not quite sufficient.

> Don't be ridiculous.  It's trivial to exploit a
local 
> buffer overrun in one of your signed binaries and 
> have the shellcode mmap the rest.  All pre-built, of

> course.

That's also true. A digital signature will not protect
against an already existing vulnerability in a binary
(bo). Let's say for instance that a linux box is
compromised with a bo, usually another backdoor is
created. Even if the system is running Pax (mentioned
by Makan), "http://www.phrack.org/show.php?p=61&a=8
Cerberus Elf interface" describes how to circumvent
this.

But on a system with digitally signed binaries, this
is no longer possible since it requires modification
of the binary which is signed.

My point is that a system with digitally signed
binaries won't prevent existing security holes, but
will prevent the creation of other ones. The attacker
is constrained to use the system as is, ie. to exploit
the same bo. Unless of course the bo gives him access
to the kernel and he disables digital signature
verification.

David



______________________________________________________________________ 
Post your free ad now! http://personals.yahoo.ca
