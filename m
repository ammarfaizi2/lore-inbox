Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261230AbULBJ3P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261230AbULBJ3P (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 04:29:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261578AbULBJ3P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 04:29:15 -0500
Received: from wproxy.gmail.com ([64.233.184.197]:29050 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261230AbULBJ3J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 04:29:09 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=aleZnl1w5uJ3HRamuymrmrvr1uoVC5Uf4/o0qU+kDbtlQJW6oZAlha+MQ8eanqB9FAiVG0gG+bnRXzmxd6X+xAMbSRIxTfqWB5UYXQ/Bw3mbODfzl2fpPbyHn5K5GsDHCKCLtvok52iZ1l+z//2GUjgUfydMksHD298+P+Q4Vns=
Message-ID: <84144f020412020129e5d0566@mail.gmail.com>
Date: Thu, 2 Dec 2004 11:29:08 +0200
From: Pekka Enberg <penberg@gmail.com>
Reply-To: Pekka Enberg <penberg@gmail.com>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
Cc: Alexandre Oliva <aoliva@redhat.com>, Paul Mackerras <paulus@samba.org>,
       Greg KH <greg@kroah.com>, David Woodhouse <dwmw2@infradead.org>,
       Matthew Wilcox <matthew@wil.cx>, David Howells <dhowells@redhat.com>,
       hch@infradead.org, linux-kernel@vger.kernel.org,
       libc-hacker@sources.redhat.com, penberg@cs.helsinki.fi
In-Reply-To: <Pine.LNX.4.58.0412011948450.22796@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <19865.1101395592@redhat.com>
	 <Pine.LNX.4.58.0411290926160.22796@ppc970.osdl.org>
	 <oract0thnj.fsf@livre.redhat.lsd.ic.unicamp.br>
	 <Pine.LNX.4.58.0411291458040.22796@ppc970.osdl.org>
	 <oris7nrq0h.fsf@livre.redhat.lsd.ic.unicamp.br>
	 <Pine.LNX.4.58.0411301413260.22796@ppc970.osdl.org>
	 <or4qj7rllv.fsf@livre.redhat.lsd.ic.unicamp.br>
	 <Pine.LNX.4.58.0411301505580.22796@ppc970.osdl.org>
	 <orvfbllsbe.fsf@livre.redhat.lsd.ic.unicamp.br>
	 <Pine.LNX.4.58.0412011948450.22796@ppc970.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

[I am getting off-topic but...]

On Wed, 1 Dec 2004, Alexandre Oliva wrote:
> > Most of that is covered by the software engineering term `contract'.

On Wed, Linus Torvalds wrote:
> I think you're making that up. Maybe there's some sw cult that swears by
> "contract programming", the same way there are the "extreme programming"
> cults etc.  For example, I find this "Design by Contract" cult for object-
> oriented programming, but it has _zero_ to do with external API's, and is
> all about the interfaces for object-oriented components.

How is a class interface different from an external API? Sure, you
don't want to change a _published_ API too often but I fail to see how
internal and external APIs are fundamentally different.

I think Alexandre's definition has in fact originated from the "Design
by Contract" cult. And it's all pretty simple stuff:

  - You need to call a function in a certain way (precondition). The
caller fills this part
    of the contract. Now the caller can _expect_ something from the
function (see below).
  - The function does what it has promised to do and optionally
returns some values
    (postcondition). The callee fills this part of the contract.
  - The function expects some parts of the system state to remain stable during
    execution (invariants). In the kernel, you use BUG_ON for these btw.

So there's nothing new here really. However, if your _tools_ support
Design by Contract, you can be explicit about this and enforce the
'contract' during compile-time or run-time.

And I think you're already doing this with your "require spinlock to
be taken" sparse thingy...

On Wed, Linus Torvalds wrote:
> IOW, I don't find your arguments or your language usage in the least
> convincing. But hey, I did all my CS stuff outside of the US, whatever.

I don't think it's an US thing. At the university you did your CS
stuff, we (well at least I) use the term 'contract' pretty much the
same way Alexandre does...

                              Pekka
