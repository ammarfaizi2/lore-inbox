Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266486AbUBQTyE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 14:54:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266561AbUBQTyE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 14:54:04 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:55989 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266486AbUBQTxu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 14:53:50 -0500
Date: Tue, 17 Feb 2004 19:53:48 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: Jamie Lokier <jamie@shareable.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Marc <pcg@goof.com>,
       Marc Lehmann <pcg@schmorp.de>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: UTF-8 practically vs. theoretically in the VFS API (was: Re: JFS default behavior)
Message-ID: <20040217195348.GQ8858@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.58.0402161040310.30742@home.osdl.org> <20040216200321.GB17015@schmorp.de> <Pine.LNX.4.58.0402161205120.30742@home.osdl.org> <20040216222618.GF18853@mail.shareable.org> <Pine.LNX.4.58.0402161431260.30742@home.osdl.org> <20040217071448.GA8846@schmorp.de> <Pine.LNX.4.58.0402170739580.2154@home.osdl.org> <20040217163613.GA23499@mail.shareable.org> <20040217175209.GO8858@parcelfarce.linux.theplanet.co.uk> <20040217192917.GA24311@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040217192917.GA24311@mail.shareable.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 17, 2004 at 07:29:18PM +0000, Jamie Lokier wrote:
> What happens is that one program or library checks an incoming path
> for ".." components - that code knows nothing about UTF-8 of course.
> 
> Then it passes the string to another program which assumes the path
> has been subject to appropriate security checks, munges it in UTF-8,
> and eventually does a file operation with it.  The munging generates
> ".." components from non-minimal UTF-8 forms - if it's not obeying the
> Unicode rejection requirement (which wasn't in earlier versions), that is.
 
Why the hell would it _ever_ do such normalization?

> A realistic example is where the second program reads files whose
> paths are mentioned in a text file which is parsed as UTF-8, after the
> first program has done a security check by grepping for ".."
> components.
> 
> Unicode says the second program shouldn't accept malformed UTF-8,
> precisely because in real scenarios (like this one) there's a mix of
> programs and libraries, some aware of UTF-8, some not, and the latter
> are involved in security decisions.
> 
> Here on linux-kernel we're saying that if the second program accepts
> any old byte sequence in a filename, it should preserve the byte
> sequence exactly.  But any program whose parser-tokeniser is scanning
> UTF-8 is very unlikely to do that - it's just too complicated to say
> some bits of a text stream must be remembered as literal bytes, and
> others must be scanned as multibyte characters.

So what you are saying is that conversion of invalid multibyte sequences
into non-error wide chars followed by conversion back into UTF-8 can
lead to trouble?  *DUH*

> The holes only arise because software which is interpreting UTF-8 is
> mixed with software which isn't.  That's one of the most useful
> features of UTF-8, after all - that's why we use it for filenames.

The holes only arise because software which is interpreting UTF-8 doesn't
care to do it properly.  Software that doesn't interpret it (including the
kernel) doesn't enter the picture at all.
