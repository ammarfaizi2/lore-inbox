Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262224AbUK3R7f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262224AbUK3R7f (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 12:59:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262233AbUK3R7f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 12:59:35 -0500
Received: from canuck.infradead.org ([205.233.218.70]:56071 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S262224AbUK3Rwv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 12:52:51 -0500
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
From: David Woodhouse <dwmw2@infradead.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Alexandre Oliva <aoliva@redhat.com>, Paul Mackerras <paulus@samba.org>,
       Greg KH <greg@kroah.com>, Matthew Wilcox <matthew@wil.cx>,
       David Howells <dhowells@redhat.com>, hch@infradead.org,
       linux-kernel@vger.kernel.org, libc-hacker@sources.redhat.com
In-Reply-To: <Pine.LNX.4.58.0411300846190.22796@ppc970.osdl.org>
References: <19865.1101395592@redhat.com>
	 <20041125165433.GA2849@parcelfarce.linux.theplanet.co.uk>
	 <1101406661.8191.9390.camel@hades.cambridge.redhat.com>
	 <20041127032403.GB10536@kroah.com>
	 <16810.24893.747522.656073@cargo.ozlabs.ibm.com>
	 <Pine.LNX.4.58.0411281710490.22796@ppc970.osdl.org>
	 <ord5xwvay2.fsf@livre.redhat.lsd.ic.unicamp.br>
	 <Pine.LNX.4.58.0411290926160.22796@ppc970.osdl.org>
	 <1101828924.26071.172.camel@hades.cambridge.redhat.com>
	 <Pine.LNX.4.58.0411300751570.22796@ppc970.osdl.org>
	 <1101832116.26071.236.camel@hades.cambridge.redhat.com>
	 <Pine.LNX.4.58.0411300846190.22796@ppc970.osdl.org>
Content-Type: text/plain
Message-Id: <1101837135.26071.380.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Tue, 30 Nov 2004 17:52:15 +0000
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-11-30 at 08:53 -0800, Linus Torvalds wrote:
> I've said this at least three times: if you can point to a _specific_ 
> thing you want to move, go wild. I think the big waste in this discussion 
> has been that there have _not_ been specific suggestions, just total 
> sound-bites like "wouldn't it be great to move things to 'include/kapi'".

I've already done some -- see the contents of include/mtd/ for example,
which contain only the parts which userspace should see, while
include/linux/mtd/ is now entirely kernel-private stuff.

We were trying to reach a consensus on where new header files can be put
and indeed whether they should be split at all. We can all disappear for
a week or two and come back with a completely sanitised set of header
files with the userspace stuff in a separate directory and _then_ and be
told "no, we don't like that; do it differently".

A bunch of us have even made a start on such things to prove the
concept. Presenting it as a fait accompli just to have it rejected isn't
much fun though -- the idea was to get some form of agreement in
principle beforehand, then collaborate on actually doing it.

> Note that even _if_ you have a specific thing in mind, I want to see that 
> somebody would say "yes, we'd use that organization". I would not be 
> surprised at all if glibc people said that they can't really use any 
> re-organization anyway, since they need to support old kernel setups too.

The idea in the proposal which David posted, which seemed perfectly
specific enough to me, was to move all the user-visible parts to
separate header files in a separate directory. Those same header files
would also be included by the kernel-private headers. This would be done
in such a way that it's a drop-in replacement for the existing sanitised
glibc-kernheaders package. Of _course_ it needs to be usable without
pain by the glibc people.

We can just go ahead and _do_ that if necessary, but it seemed like a
sane plan to agree on how to do it beforehand.

-- 
dwmw2

