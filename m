Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262344AbUK3VmS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262344AbUK3VmS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 16:42:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262345AbUK3VlA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 16:41:00 -0500
Received: from emilia.lsd.ic.unicamp.br ([143.106.24.129]:30638 "EHLO
	emilia.lsd.ic.unicamp.br") by vger.kernel.org with ESMTP
	id S262340AbUK3Vk2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 16:40:28 -0500
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
	<ormzwzrrmy.fsf@livre.redhat.lsd.ic.unicamp.br>
	<Pine.LNX.4.58.0411301249590.22796@ppc970.osdl.org>
	<orekibrpmn.fsf@livre.redhat.lsd.ic.unicamp.br>
From: Alexandre Oliva <oliva@lsd.ic.unicamp.br>
Date: 30 Nov 2004 19:39:34 -0200
In-Reply-To: <orekibrpmn.fsf@livre.redhat.lsd.ic.unicamp.br>
Message-ID: <oracszrp7t.fsf@livre.redhat.lsd.ic.unicamp.br>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 30, 2004, Alexandre Oliva <aoliva@redhat.com> wrote:

>> I've suggested "include/user/" and "include/asm-xxx/user", which handles 
>> architecture-specific parts too. I'm ok with doing it the other way 
>> around, ie "include/user/" and "include/user/arch-xxxx".

> As I pointed out, `user' is a very bad name.  As you said yourself,
> we're talking about the *kernel* ABI.  So what's `user' supposed to
> mean?  Was I so successful in my arguments that you now see it as the
> userland ABI? :-)

I got carried away with joking and failed to repeat why I consider it
a bad name (assuming that, since you missed the beginning of the
thread, you probably missed the first reply I posted to the message
that started it): since we're going to install these headers in
/usr/include (where headers for userland live), /usr/include/user is
quite misleading.  /usr/include/kernel would be far more
appropriate for this purpose.

Sure, we could take headers from linux-*/include/user and install them
in /usr/include/kernel, but then includes in there that reference
other headers in user/ or in asm-<arch>/ will cease to work.

So we should come up with a name that makes sense for both users of
these headers, which is why I suggested ukabi.  linux/abi and
asm-<mach>/abi work just as well, and then we can soft-link `abi -> .'
in /usr/include/{linux,asm-<mach>} if needed.  Ideally, we wouldn't
have to.

-- 
Alexandre Oliva             http://www.ic.unicamp.br/~oliva/
Red Hat Compiler Engineer   aoliva@{redhat.com, gcc.gnu.org}
Free Software Evangelist  oliva@{lsd.ic.unicamp.br, gnu.org}
