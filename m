Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262330AbUK3Vb2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262330AbUK3Vb2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 16:31:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262328AbUK3Vb2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 16:31:28 -0500
Received: from mx1.redhat.com ([66.187.233.31]:8405 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262325AbUK3Vax (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 16:30:53 -0500
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
From: Alexandre Oliva <aoliva@redhat.com>
Organization: Red Hat Global Engineering Services Compiler Team
Date: 30 Nov 2004 19:30:40 -0200
In-Reply-To: <Pine.LNX.4.58.0411301249590.22796@ppc970.osdl.org>
Message-ID: <orekibrpmn.fsf@livre.redhat.lsd.ic.unicamp.br>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 30, 2004, Linus Torvalds <torvalds@osdl.org> wrote:

> On Tue, 30 Nov 2004, Alexandre Oliva wrote:
>> 
>> - move anything that is not protected by #ifdef __KERNEL__ to the
>> ukabi header tree, adding an include in the beginning of the original
>> header that includes the ukabi header.

> No. I want stuff that goes into the ABI tree to be clearly _defined_ to be 
> user-visible. Not a "let's move it all there and then prune it". 

Right.  Which brings us to my second bullet.  I *knew* I should have
made it the first :-/

> Also, "ukabi" just isn't going to fly as a name. It's also not as simple 
> as you seem to think, since a lot of these ABI things are architecture- 
> dependent, which apparently all you guys have totally ignored. 

Looks like you missed the post that started this thread.  It *did*
mention machine-independent and machine-specific user headers.

> I've suggested "include/user/" and "include/asm-xxx/user", which handles 
> architecture-specific parts too. I'm ok with doing it the other way 
> around, ie "include/user/" and "include/user/arch-xxxx".

As I pointed out, `user' is a very bad name.  As you said yourself,
we're talking about the *kernel* ABI.  So what's `user' supposed to
mean?  Was I so successful in my arguments that you now see it as the
userland ABI? :-)

>  (a) it can't break anything (ie the old location still includes the new 
>      one, exactly the same way)

You mean it can't break anything in a kernel build, or it can't break
anything except for userland apps that abused kernel headers and used
to get away with that?

>  (b) there are people who will actually take _advantage_ of that 
>      particular file (ie "just because I think so" doesn't fly).

People who currently get to maintain duplicates of these header
contents will take immediate advantage of these changes, since they
will no longer have to maintain the duplicates.  This is a major step
forward in terms of maintainability for everybody else, at no expense
to the kernel, that now gets to explicitly (as opposed to implicitly)
document what is the ABI it's willing to comply with.  It's a win for
both ends.

-- 
Alexandre Oliva             http://www.ic.unicamp.br/~oliva/
Red Hat Compiler Engineer   aoliva@{redhat.com, gcc.gnu.org}
Free Software Evangelist  oliva@{lsd.ic.unicamp.br, gnu.org}
