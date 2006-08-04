Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161037AbWHDOev@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161037AbWHDOev (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 10:34:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161224AbWHDOev
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 10:34:51 -0400
Received: from thunk.org ([69.25.196.29]:54471 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1161037AbWHDOeu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 10:34:50 -0400
Date: Fri, 4 Aug 2006 10:34:29 -0400
From: Theodore Tso <tytso@mit.edu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Zachary Amsden <zach@vmware.com>, Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>,
       Rusty Russell <rusty@rustcorp.com.au>, Jack Lo <jlo@vmware.com>
Subject: Re: A proposal - binary
Message-ID: <20060804143420.GB16313@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Zachary Amsden <zach@vmware.com>, Greg KH <greg@kroah.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
	Christoph Hellwig <hch@infradead.org>,
	Rusty Russell <rusty@rustcorp.com.au>, Jack Lo <jlo@vmware.com>
References: <44D1CC7D.4010600@vmware.com> <20060803190605.GB14237@kroah.com> <44D24DD8.1080006@vmware.com> <20060803200136.GB28537@kroah.com> <44D26D87.2070208@vmware.com> <1154644383.23655.142.camel@localhost.localdomain> <44D2794A.0@vmware.com> <1154647835.23655.161.camel@localhost.localdomain> <44D28985.8050200@vmware.com> <1154686885.23655.198.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1154686885.23655.198.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 04, 2006 at 11:21:25AM +0100, Alan Cox wrote:
> Every other hypervisor system supported by Linux has a source code
> interface on the Linux side that works reliably and compatibly through
> versions and releases. The terrible things you claim will happen have
> not. IBM have been doing virtualisation for something like forty years.
> IBM is not using magic binary blobs. this also leads me to the
> conclusion that you are wrong.

Well, let's be a little fair here.  Part of the problem, which is not
VMWare's fault, is that Intel a long time ago screwed up the x86 ISA
to make it non-virtualizable without all sorts of nasty hacks.  (Some
say that this was done deliberately so Intel could sell more chips,
but I haven't personally seen any proof of this; it's not the point
either way, however.)

IBM's virtualization *does* have magic blobs; it's called the
hypervisor.  The difference is that the PowerPC have a delibierately
castrated architecture such that when you are running a guest
operating system in an LPAR, so that when you do things like mess with
page tables (for example), it traps to the hypervisor which is really
"a magic binary blob" running on the bare Power architecture.  The
difference is that the way you trap into the hypervisor is via a
PowerPC instructure that looks like a native instruction call.

The bottom line is that the line between magic binary blobs and
whether or not they are legal or not is more of a grey line than we
might want to admit. 

For example, what if Transmeta was still around, and released a
digitally signed "magic binary blob" which provided VT/Pacific
capabilities to a Transmeta processor?  (And if --- hypothetically ---
a version of Linux that required VT/Pacfica under the was released
under the GPLv3, would the RSA private key used to sign Transmeta's
"magic binary blob" be considered "corresponding source" and the GPLv3
used as a way to beat Transmeta to produce the private keys used to
sign their firmware update; it's after all a "necessary authentication
and encryption key" needed to install this hypothetical version of
Linux.  :-)

As another example, the Alpha architecture has specified magic binary
blobs --- called PALcode --- where different binary PALcodes can be
needed for different OS's, and implement various privileged
instructures which are specifically intended for OS-level
functionality.

The real problem, though, is demonstrated by yet another "magic binary
blob" which we in fact already deal with, and that's ACPI.  The
problem with "magic binary blobs" is that it's incredibly easy to do
an disastrously bad job with defining the interfaces, providing,
requiring, and performing conformance tests for the binary blobs, and
the on-going, continuing nightmare caused by different ACPI binary
blob providers doing stupid things that are only tested on Windows.

So I don't think the argument is necessarily that magic binary blobs
are illegal from the GPL perspective, but rather that magic binary
blobs are very hard to get right.  (For example, I still remember
really bad experiences with different firmware versions for Cisco's
aironet wireless hardware being needed depending on which OS and which
version of the driver you had on your OS.  Troubleshooting *that* was
a nightmare.)  And that I think is the biggest problem with the VMI
proposal; which is a lack of trust that the various VM providers will
actually do something sane, both from an interface design and provided
implementation perspective.  This is why I think everyone keeps
harping on the question of debuggability.  

No one has really complained about the dubbugability, or lack thereof,
of the Power hypervisor, but OTOH IBM does spend vast amounts of $$$
making sure that it is stable and the interfaces are well-documented
and locked down.

						- Ted
