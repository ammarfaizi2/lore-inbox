Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261502AbVAMEtP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261502AbVAMEtP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 23:49:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261509AbVAMEtP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 23:49:15 -0500
Received: from fw.osdl.org ([65.172.181.6]:23229 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261502AbVAMEtJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 23:49:09 -0500
Date: Wed, 12 Jan 2005 20:48:57 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Dave Jones <davej@redhat.com>
cc: Andrew Morton <akpm@osdl.org>, marcelo.tosatti@cyclades.com,
       Greg KH <greg@kroah.com>, chrisw@osdl.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: thoughts on kernel security issues
In-Reply-To: <20050113033542.GC1212@redhat.com>
Message-ID: <Pine.LNX.4.58.0501122025140.2310@ppc970.osdl.org>
References: <20050112094807.K24171@build.pdx.osdl.net>
 <Pine.LNX.4.58.0501121002200.2310@ppc970.osdl.org> <20050112185133.GA10687@kroah.com>
 <Pine.LNX.4.58.0501121058120.2310@ppc970.osdl.org> <20050112161227.GF32024@logos.cnet>
 <Pine.LNX.4.58.0501121148240.2310@ppc970.osdl.org> <20050112205350.GM24518@redhat.com>
 <Pine.LNX.4.58.0501121750470.2310@ppc970.osdl.org> <20050112182838.2aa7eec2.akpm@osdl.org>
 <20050113033542.GC1212@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 12 Jan 2005, Dave Jones wrote:
> 
> For us thankfully, exec-shield has trapped quite a few remotely
> exploitable holes, preventing the above.

One thing worth considering, but may be abit _too_ draconian, is a
capability that says "can execute ELF binaries that you can write to".

Without that capability set, you can only execute binaries that you cannot
write to, and that you cannot _get_ write permission to (ie you can't be
the owner of them either - possibly only binaries where the owner is
root).

Sure, that's clearly not viable for a developer or even somebody who
maintains his own machine, but it _is_ probably viable for pretty much any
user that is afraid of compiling stuff him/herself and just gets signed
rpm's that install as root anyway. And it should certainly be viable for
somebody like "nobody" or "ftp" or "apache".

And I suspect there is almost zero overlap between the "developer
workstation" kind of setup (where the above is just not workable) and
"server or end-user desktop" setup where it might work.

A lot of the local root exploits depend on being able to run code that
doesn't come pre-installed on the system. A hole in a user-level server
may get you local shell access, but you generally need another stage to
get elevated privileges and _really_ mess with the machine.

Quite frankly, nobody should ever depend on the kernel having zero holes.  
We do our best, but if you want real security, you should have other
shields in place. exec-shield is one. So is using a compiler that puts
guard values on the stack frame (immunix, I think). But so is saying "you
can't just compile or download your own binaries, nyaah, nyaah, nyaah".

As I've already made clear, I don't believe one whit in the "secrecy"  
approach to security. I believe that "security through obscurity" can
actually be one valid level of security (after all, in the extreme case,
that's all a password ever really is).

So I believe that in the case of hiding vulnerabilities, any "security
gain" from the obscurity is more than made up for by all the security you
lose though delaying action and not giving people information about the
problem. 

I realize people disagree with me, which is also why I don't in any way
take vendor-sec as a personal affront or anything like that: I just think
it's a mistake, and am very happy to be vocal about it, but hey, the
fundamental strength of open source is exactly the fact that people don't
have to agree about everything.

			Linus
