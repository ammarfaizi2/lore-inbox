Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275310AbTHMSNw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 14:13:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275313AbTHMSNv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 14:13:51 -0400
Received: from dsl017-022-215.chi1.dsl.speakeasy.net ([69.17.22.215]:24583
	"EHLO gateway.two14.net") by vger.kernel.org with ESMTP
	id S275310AbTHMSNt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 14:13:49 -0400
Date: Wed, 13 Aug 2003 13:13:30 -0500
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: maney@pobox.com, linux-kernel@vger.kernel.org,
       Stephan von Krawczynski <skraw@ithnet.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.4.22-rc2 ext2 filesystem corruption
Message-ID: <20030813181330.GA1122@furrr.two14.net>
Reply-To: maney@pobox.com
References: <20030812213645.GA1079@furrr.two14.net> <Pine.LNX.4.44.0308131155090.4279-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0308131155090.4279-100000@localhost.localdomain>
User-Agent: Mutt/1.3.28i
From: maney@two14.net (Martin Maney)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 13, 2003 at 11:55:52AM -0300, Marcelo Tosatti wrote:
> Please reback just that change and see if you still get the corruption, 
> please. 
> 
> That way we can be sure. 

At this point the outcome was pretty much a foregone conclusion, but
yep, reverting to ".id" stopped the corruption for this test case.  As
Alan said, it "fixed" it only because that incorrect test happens to
force the driver to use the lower DMA speed.  I had been about to
report on that when your request for the explicit test arrived, but in
short it's that rc1 (and earlier) were disabling the "66" clock speed,
while rc2 was, correctly, finding no reason not to enable it.  The real
bug, be it hardware or software, is that enabling the higher speed
causes the corruption.

I suppose the obvious bandaid would be to add a config option or yet
another /proc/something kluge to let Promise chips be throttled on
purpose, rather than fortuitously.  For my own use, I think I'm just
going to reconfigure to avoid the Promise controller on this machine. 
I would be willing, in principle, to try any proposed fixes, but for a
while longer I would flinch at trying any untested code that I didn't
feel I understood.  Later on this hardware ought to be more available
for testing, at least until it gets repurposed again.

I do have one casual question, if someone should have the answer.  The
driver only talks about a 66MHz high speed; does that mean that the
20265 never gets run at its full speed under Linux, or is it just old
terminology from back when UDMA66 was the top speed?

-- 
An education that does not teach clear, coherent writing
cannot provide our world with thoughtful adults; it gives us instead,
at the best, clever children of all ages.  -- Richard Mitchell

