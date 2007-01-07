Return-Path: <linux-kernel-owner+w=401wt.eu-S964924AbXAGTRn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964924AbXAGTRn (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 14:17:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964939AbXAGTRn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 14:17:43 -0500
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:3066 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964924AbXAGTRm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 14:17:42 -0500
Date: Sun, 7 Jan 2007 19:17:30 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: David Woodhouse <dwmw2@infradead.org>, Tilman Schmidt <tilman@imap.cc>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: OT: character encodings (was: Linux 2.6.20-rc4)
Message-ID: <20070107191730.GD21133@flint.arm.linux.org.uk>
Mail-Followup-To: Alan <alan@lxorguk.ukuu.org.uk>,
	David Woodhouse <dwmw2@infradead.org>,
	Tilman Schmidt <tilman@imap.cc>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.64.0701062216210.3661@woody.osdl.org> <Pine.LNX.4.61.0701071152570.4365@yvahk01.tjqt.qr> <20070107114439.GC21613@flint.arm.linux.org.uk> <45A0F060.9090207@imap.cc> <1168182838.14763.24.camel@shinybook.infradead.org> <20070107153833.GA21133@flint.arm.linux.org.uk> <20070107182151.7cc544f3@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20070107182151.7cc544f3@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 07, 2007 at 06:21:51PM +0000, Alan wrote:
> > So, in short, UTF-8 is all fine and dandy if your _entire_ universe
> > is UTF-8 enabled.  If you're operating in a mixed charset environment
> > it's one bloody big pain in the butt.
> 
> Net ASCII is 7bit and is 1:1 mapped with UTF-8 unicode.

The same is true of ISO-8859-1.

> It's just old broken 8bit encodings that are problematic.
> 
> The kernel maintainers/help/config pretty consistently use UTF8

As I've tried to point out, that's not universally true.  For instance:

commit 24ebead82bbf9785909d4cf205e2df5e9ff7da32
tree 921f686860e918a01c3d3fb6cd106ba82bf4ace6
parent 264166e604a7e14c278e31cadd1afb06a7d51a11
author Rafa³ Bilski <rafalbilski@interia.pl> 1167691774 +0100
committer Dave Jones <davej@redhat.com> 1167799119 -0500

and looking at that "author" closer with od:

0000140 74 68 6f 72 20 52 61 66 61 b3 20 42 69 6c 73 6b
          t   h   o   r       R   a   f   a   ³       B   i   l   s   k

clearly not UTF-8.  I doubt whether any of the commits I do on my
en_GB ISO-8859-1 systems end up being UTF-8 encoded.

And _this_ is the problem when it comes to generating the logs,
irrespective of whether or not Linus loads UTF-8 data into an
ISO-8859-1 message.  For all we know, Linus' system could be using
an ISO-8859 charset rather than UTF-8.

But the point is there is charset damage which has happened _long_ before
Linus' action.  There is no character set defined for the contents of git
repositories, and as such the output of the git tools can not be
interpreted as any one single character set.

All that UTF-8 has done is added to the "which charset is this data"
problem rather than actually solving any proper real life problem.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
