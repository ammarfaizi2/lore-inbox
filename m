Return-Path: <linux-kernel-owner+w=401wt.eu-S964959AbXAGTZg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964959AbXAGTZg (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 14:25:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964960AbXAGTZf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 14:25:35 -0500
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:40350 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S964959AbXAGTZf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 14:25:35 -0500
X-Sasl-enc: W0YTXK48Ge/5x66/kz34zoZIW7LCrJRyadS2GaAVPHML 1168197739
Message-ID: <45A14A2A.9060306@imap.cc>
Date: Sun, 07 Jan 2007 20:29:46 +0100
From: Tilman Schmidt <tilman@imap.cc>
Organization: me - organized??
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; de-AT; rv:1.8.0.9) Gecko/20061211 SeaMonkey/1.0.7 Mnenhy/0.7.4.666
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: David Woodhouse <dwmw2@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: OT: character encodings
References: <Pine.LNX.4.64.0701062216210.3661@woody.osdl.org> <Pine.LNX.4.61.0701071152570.4365@yvahk01.tjqt.qr> <20070107114439.GC21613@flint.arm.linux.org.uk> <45A0F060.9090207@imap.cc> <1168182838.14763.24.camel@shinybook.infradead.org> <20070107153833.GA21133@flint.arm.linux.org.uk> <1168187346.14763.70.camel@shinybook.infradead.org> <20070107170656.GC21133@flint.arm.linux.org.uk>
In-Reply-To: <20070107170656.GC21133@flint.arm.linux.org.uk>
X-Enigmail-Version: 0.94.1.2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am 07.01.2007 18:06 schrieb Russell King:
> 
> $ git log | head -n 1000 | tail -n 200 > o
> $ file -i o
> o: text/plain; charset=us-ascii
> $ git log | head -n 1000 | tail -n 300 > o
> $ file -i o
> o: text/plain; charset=us-ascii
> $ git log | head -n 1000 | tail -n 400 > o
> $ file -i o
> o: text/plain; charset=utf-8
> 
> (and you know what charset the file is thought to have with all 1000
> lines in it.)

What the "file" command thinks is hardly relevant here. "file" just
attempts to guess what the contents of a file might be, by applying
a simple set of heuristics. Your results only highlight the actual
problem: "git" is apparently unable to handle character sets properly
and instead produces a mix of encodings as output.

> All on a system with LANG set to en_GB (iow ISO-8859-1).

For software with proper multilingual support, that should have been
enough to make sure that all its output would be in iso-8859-1, too.
Obviously "git" doesn't fall into that category.

>> Yes. When you stored it on disk, the character set information was lost.
> 
> The same thing actually happens when I look at it via:
> 
>   $ git log | head -n 1000 | less

The loss has happened long before you run that command, when the
data was committed into "git".

> So, I think you'll find that the contents of git _is_ an ad-hoc collection
> of character sets which people happen to have in use on their machines.

Exactly.

>> A mixed charset environment was _already_ a pain in the butt, because
>> almost nobody got labelling right. It's wrong to blame that on UTF-8.
> 
> I'm not talking about a mixed charset environment.  I'm talking about
> non-UTF-8 single charset environments being broken by programs which
> universally think the universe is UTF-8 only.

The problem is not programs thinking the universe is UTF-8 only; it's
people mixing different charsets, in conjunction with programs not
caring about charsets at all.

Specifically, your non-UTF-8 single charset environment was not broken
by git thinking everything was UTF-8, but to the contrary by some data
in the git repository actually being UTF-8 and git *not* thinking that.

And that problem is, I repeat, much older than UTF-8.

HTH
Tilman

-- 
Tilman Schmidt                          E-Mail: tilman@imap.cc
Bonn, Germany
Diese Nachricht besteht zu 100% aus wiederverwerteten Bits.
Ungeöffnet mindestens haltbar bis: (siehe Rückseite)

