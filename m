Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261661AbUEQPhj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261661AbUEQPhj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 11:37:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261638AbUEQPhj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 11:37:39 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:26342 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261661AbUEQPhi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 11:37:38 -0400
Date: Mon, 17 May 2004 16:37:36 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Linus Torvalds <torvalds@osdl.org>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Wayne Scott <wscott@bitmover.com>,
       akpm@osdl.org, elenstev@mesatop.com, lm@bitmover.com,
       wli@holomorphy.com, hugh@veritas.com, adi@bitmover.com, scole@lanl.gov,
       support@bitmover.com, linux-kernel@vger.kernel.org
Subject: Re: 1352 NUL bytes at the end of a page?
Message-ID: <20040517153736.GT17014@parcelfarce.linux.theplanet.co.uk>
References: <200405162136.24441.elenstev@mesatop.com> <Pine.LNX.4.58.0405162152290.25502@ppc970.osdl.org> <20040516231120.405a0d14.akpm@osdl.org> <20040517.085640.30175416.wscott@bitmover.com> <20040517151738.GA4730@thunk.org> <Pine.LNX.4.58.0405170820560.25502@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0405170820560.25502@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 17, 2004 at 08:22:10AM -0700, Linus Torvalds wrote:
> 
> 
> On Mon, 17 May 2004, Theodore Ts'o wrote:
> > 
> > Note though that the stdio library uses a writeable mmap to implement
> > fwrite.
> 
> It does? Whee. Then I'll have to agree with Andrew - if there is a path 
> that is more likely to have bugs, it's trying to do writes with mmap and 
> ftruncate.
> 
> Who came up with that braindead idea? Is it some crazed Mach developer 
> that infiltrated the glibc development group?

IIRC, that idiocy had been disabled by default (note that it's inherently
broken, since truncate() between your mmap() and memcpy() will lead to
a coredump, which is not something fwrite() is allowed to do in such
situation).

strace should show if there such mmap calls are made, anyway.  Did they
show up in the traces?
