Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266331AbUAOFYy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 00:24:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266334AbUAOFYy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 00:24:54 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:42294 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S266331AbUAOFYw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 00:24:52 -0500
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Intel Alder IOAPIC fix
References: <1073876117.2549.65.camel@mulgrave>
	<Pine.LNX.4.58.0401121152070.1901@evo.osdl.org>
	<1073948641.4178.76.camel@mulgrave>
	<Pine.LNX.4.58.0401121452340.2031@evo.osdl.org>
	<1073954751.4178.98.camel@mulgrave>
	<Pine.LNX.4.58.0401121621220.14305@evo.osdl.org>
	<1074012755.2173.135.camel@mulgrave>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 14 Jan 2004 22:18:49 -0700
In-Reply-To: <1074012755.2173.135.camel@mulgrave>
Message-ID: <m1smihg56u.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley <James.Bottomley@steeleye.com> writes:

> On Mon, 2004-01-12 at 19:25, Linus Torvalds wrote:
> > I think BARs 1-5 don't exist at all. Being set to all ones is common for
> > "unused" (it ends up being a normal result of a lazy probe - you set all 
> > bits to 1 to check for the size of the region, and if you decide not to 
> > map it and leave it there, you'll get the above behaviour).
> > 
> > I suspect only BAR0 is actually real.
> 
> OK, I cleaned up the patch to forcibly insert BAR0 and clear BARs 1-5
> (it still requires changes to insert_resource to work, though).

When I looked at the ia64 code that uses insert_resource (and I admit I am
reading between the lines a little) it seems to come along after potentially
allocating some resources behind some kind of bridge and then realize a bridge
is there.

Which is totally something different from this case where we just want
to ignore the BIOS, because we know better.  I have seen a number of
boxes that reserver the area where apics or ioapics live.  So I think
we need an IORESOURCE_TENTATIVE thing.  This is the third flavor of
thing that has shown up, lately.

Want me to code up a patch?

Eric
