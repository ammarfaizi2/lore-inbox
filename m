Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262337AbUK3UsK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262337AbUK3UsK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 15:48:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262334AbUK3UsJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 15:48:09 -0500
Received: from mx1.redhat.com ([66.187.233.31]:31163 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262309AbUK3Urk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 15:47:40 -0500
To: Linus Torvalds <torvalds@osdl.org>
Cc: David Howells <dhowells@redhat.com>, Paul Mackerras <paulus@samba.org>,
       Greg KH <greg@kroah.com>, David Woodhouse <dwmw2@infradead.org>,
       Matthew Wilcox <matthew@wil.cx>, hch@infradead.org,
       linux-kernel@vger.kernel.org, libc-hacker@sources.redhat.com
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
References: <Pine.LNX.4.58.0411290926160.22796@ppc970.osdl.org>
	<19865.1101395592@redhat.com>
	<20041125165433.GA2849@parcelfarce.linux.theplanet.co.uk>
	<1101406661.8191.9390.camel@hades.cambridge.redhat.com>
	<20041127032403.GB10536@kroah.com>
	<16810.24893.747522.656073@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.58.0411281710490.22796@ppc970.osdl.org>
	<ord5xwvay2.fsf@livre.redhat.lsd.ic.unicamp.br>
	<8219.1101828816@redhat.com>
	<Pine.LNX.4.58.0411300744120.22796@ppc970.osdl.org>
From: Alexandre Oliva <aoliva@redhat.com>
Organization: Red Hat Global Engineering Services Compiler Team
Date: 30 Nov 2004 18:47:17 -0200
In-Reply-To: <Pine.LNX.4.58.0411300744120.22796@ppc970.osdl.org>
Message-ID: <ormzwzrrmy.fsf@livre.redhat.lsd.ic.unicamp.br>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 30, 2004, Linus Torvalds <torvalds@osdl.org> wrote:

> I object sternuously to your "the header files". If you can't even say 
> _which_ header file, I'm not interested.

How about this formulation then:

- move anything that is not protected by #ifdef __KERNEL__ to the
ukabi header tree, adding an include in the beginning of the original
header that includes the ukabi header.  Since ukabi stuff can't depend on
kernel-internal stuff, having this include as the first thing in the
existing header should work.

- figure out what should have been protected by #ifdef __KERNEL__ but
wasn't, and move it back

- wait for bug reports from the world and deal with them

- repeat until you feel you got it right


> See what I'm saying? Whole-sale "move things around because we want to" 
> I'm not interested in. Specific problems, yes.

The specific problem we're trying to address is the creation of header
files that define the ABI between userland and kernel, that both
kernel and userland can use.

>> Personally, I'd prefer us to move to using standard C99 types in lieu of u32
>> and co at least for the interface to userspace because they are just that:
>> standard.

> No. I told you why it cannot and MUST NOT be done. Repeat after me:

> 	WE MUST NOT POLLUTE THE NAMESPACE!

David, Linus is right.  Using standard types is not an option because
they're not built in type names; you have to include a header to bring
them in, and ideally you shouldn't gratuitously get the names defined
just because you include some unrelated header, although the C
Standard grants standard headers freedom to include other headers or
something along these lines; I don't recall the exact passage of the
Standard that says so, but we should strive to not pollute the user
namespace anyway.

-- 
Alexandre Oliva             http://www.ic.unicamp.br/~oliva/
Red Hat Compiler Engineer   aoliva@{redhat.com, gcc.gnu.org}
Free Software Evangelist  oliva@{lsd.ic.unicamp.br, gnu.org}
