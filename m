Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262405AbUK3XW3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262405AbUK3XW3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 18:22:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262394AbUK3XWH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 18:22:07 -0500
Received: from mx1.redhat.com ([66.187.233.31]:11939 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262405AbUK3XOb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 18:14:31 -0500
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: Mariusz Mazur <mmazur@kernel.pl>, Sam Ravnborg <sam@ravnborg.org>,
       Linus Torvalds <torvalds@osdl.org>,
       David Woodhouse <dwmw2@infradead.org>,
       Paul Mackerras <paulus@samba.org>, Greg KH <greg@kroah.com>,
       Matthew Wilcox <matthew@wil.cx>, David Howells <dhowells@redhat.com>,
       hch@infradead.org, linux-kernel@vger.kernel.org,
       libc-hacker@sources.redhat.com
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
References: <19865.1101395592@redhat.com>
	<Pine.LNX.4.58.0411301243000.22796@ppc970.osdl.org>
	<20041130223359.GA15443@mars.ravnborg.org>
	<200411302344.21907.mmazur@kernel.pl>
	<20041130230325.GY26051@parcelfarce.linux.theplanet.co.uk>
From: Alexandre Oliva <aoliva@redhat.com>
Organization: Red Hat Global Engineering Services Compiler Team
Date: 30 Nov 2004 21:13:46 -0200
In-Reply-To: <20041130230325.GY26051@parcelfarce.linux.theplanet.co.uk>
Message-ID: <orvfbnq6ad.fsf@livre.redhat.lsd.ic.unicamp.br>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 30, 2004, Al Viro <viro@parcelfarce.linux.theplanet.co.uk> wrote:

> WTF?  I've got a dozen kernel trees hanging around, which one (and WTF any,
> while we are at it) should be "linked to"?

Whichever you chose to install in your /usr/include, and use as the
kernel ABI definition as far as userland is concerned.

I don't think `make install' should touch /usr/include at all.  It
should be a separate step, such that one can build a kernel abi
headers package out of the kernel source tree, ideally without even
having to configure it first, and use that as the kernel ABI
definition.  You should only have to do this again *if* the ABI
changes (ideally no removals, only additions) *and* you want to take
advantage of them, *and* you're willing to rebuild userland pieces
that could take advantage of them.

On most systems, people won't do that, they'll just use whatever
kernel headers and glibc binaries their distro ships.  If they want to
change any of these, they have to know what they're doing.

-- 
Alexandre Oliva             http://www.ic.unicamp.br/~oliva/
Red Hat Compiler Engineer   aoliva@{redhat.com, gcc.gnu.org}
Free Software Evangelist  oliva@{lsd.ic.unicamp.br, gnu.org}
