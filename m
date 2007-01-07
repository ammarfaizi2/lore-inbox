Return-Path: <linux-kernel-owner+w=401wt.eu-S932590AbXAGPim@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932590AbXAGPim (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 10:38:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932588AbXAGPim
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 10:38:42 -0500
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:4370 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932590AbXAGPim (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 10:38:42 -0500
Date: Sun, 7 Jan 2007 15:38:33 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Tilman Schmidt <tilman@imap.cc>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: OT: character encodings (was: Linux 2.6.20-rc4)
Message-ID: <20070107153833.GA21133@flint.arm.linux.org.uk>
Mail-Followup-To: David Woodhouse <dwmw2@infradead.org>,
	Tilman Schmidt <tilman@imap.cc>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.64.0701062216210.3661@woody.osdl.org> <Pine.LNX.4.61.0701071152570.4365@yvahk01.tjqt.qr> <20070107114439.GC21613@flint.arm.linux.org.uk> <45A0F060.9090207@imap.cc> <1168182838.14763.24.camel@shinybook.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1168182838.14763.24.camel@shinybook.infradead.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 07, 2007 at 11:13:57PM +0800, David Woodhouse wrote:
> On Sun, 2007-01-07 at 14:06 +0100, Tilman Schmidt wrote:
> > Russell King schrieb:
> > > Welcome to the mess which the UTF-8 charset creates.
> 
> Utter bollocks.

Wrong.  The problem is partly caused by not everything understanding
multi-byte character encodings, and text files containing absolutely
_no_ information about their character encodings.

When a text file is stored on disk, there's no way to tell what
character set the characters in that file belong to.  As a result,
ISO-8859-1 folk assume that all text files are ISO-8859-1 encoded.
UTF-8 folk assume all text files are UTF-8 encoded.  This leads to
utter confusion.

To see what I mean, try the following:

$ git log | head -n 1000 > o
$ file -i o
o: text/x-c; charset=iso-8859-1

According to that, the charset of the 'git log' output (which on that
test included Leonard's entry) is iso-8859-1, and by that Linus' mailer
was right to include it as ISO-8859-1.

In reality, the output from git log contains an ad-hoc collection of
character sets making its interpretation under any one character set
incorrect.

> > The problem of different character encodings coexisting on the same
> > platform, and the resulting occasional messing-up, far predates Unicode.
> > I distinctly remember one case of being bitten by this myself in 1977
> > when Unicode wasn't even on the horizon yet, and I don't think that was
> > the first time.
> 
> Indeed. If you take arbitrary content and send it out to the world
> labelled as ISO8859-1, of _course_ you're likely to be corrupting it.
> 
> Far from being the cause of the problem, UTF-8 actually offers the
> chance of a _solution_. Because once the Luddites catch up, it'll
> largely eliminate the need for using the multitude of legacy character
> sets and converting between them -- and the problem of mislabelling will
> fairly much go away.

In other words, the UTF-8 luddites require the entire Internet to
upgrade to UTF-8 for UTF-8 to work properly.

I _regularly_ struggle with idiotic programs that assume that the world
is UTF-8 and nothing else.  UTF-8 does _not_ solve these inter-operability
problems - it only makes the entire situation worse by introducing yet
another different charset.  (Yes, it's also true that there are programs
which assume the world is only another, different, character set.)

Rather than having these problems fixed properly (by looking at the LANG
environment variable) many of these programs now assume that the world
is UTF-8.  It isn't.

elinks is one such program.  It now assumes UTF-8 _only_ displays.
That's no better than programs which assume ISO-8859-1 only or US-ASCII
only.

So, in short, UTF-8 is all fine and dandy if your _entire_ universe
is UTF-8 enabled.  If you're operating in a mixed charset environment
it's one bloody big pain in the butt.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
