Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262580AbUKVUhR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262580AbUKVUhR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 15:37:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262357AbUKVUex
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 15:34:53 -0500
Received: from fw.osdl.org ([65.172.181.6]:11164 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262575AbUKVUcR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 15:32:17 -0500
Date: Mon, 22 Nov 2004 12:31:52 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Len Brown <len.brown@intel.com>
cc: Chris Wright <chrisw@osdl.org>, Adrian Bunk <bunk@stusta.de>,
       Bjorn Helgaas <bjorn.helgaas@hp.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.10-rc2 doesn't boot (if no floppy device)
In-Reply-To: <1101155077.20006.110.camel@d845pe>
Message-ID: <Pine.LNX.4.58.0411221226310.20993@ppc970.osdl.org>
References: <20041115152721.U14339@build.pdx.osdl.net>  <1100819685.987.120.camel@d845pe>
 <20041118230948.W2357@build.pdx.osdl.net>  <1100941324.987.238.camel@d845pe>
  <Pine.LNX.4.58.0411200831560.20993@ppc970.osdl.org>  <1101150469.20006.46.camel@d845pe>
  <Pine.LNX.4.58.0411221116480.20993@ppc970.osdl.org> <1101155077.20006.110.camel@d845pe>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 22 Nov 2004, Len Brown wrote:
> > 
> > And not doing it breaks systems.
> 
> I'm not aware (yet) of any systems where disabling all the links (which
> we've been doing since June, BTW)

We have been doing it since June, but we also immediately _re-enabled_ 
them.

And the moment we _didn't_ re-enable them, people started sending in 
bug-reports. So the "since June" is clearly true only in a very limited 
sense.

A more correct way to say it would be that within hours of releasing a
test-kernel (not even a real release) that _really_ disabled the links, we
got people reporting boot failures.

> and clearing the entire ELCR, and then re-enabling them both only as we
> use them causes a failure.

Now, the clearing the entire ELCR thing has been tested by all of three 
people, all of whom saw problems with the non-clearing thing. So not only 
is the base for that claim very thin indeed, the small base was totally 
self-selected, ie statistically completely meaningless even if it had 
been much much larger.

Nobody who didn't actually see the problem in the first place would have 
tested it.

IOW, I'll claim that the only thing that has really gotten testing since 
June is the thing that disables and immediately re-enables the links.

And that's exactly why I think the "minimally disruptive" fix is to not
disable them at all, but just fix up ELCR for anything that was already
enabled. Since that _is_ what "disable + re-enable" ends up actually
doing.

See my argument?

		Linus
