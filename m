Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262850AbTEBBVg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 21:21:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262853AbTEBBVg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 21:21:36 -0400
Received: from air-2.osdl.org ([65.172.181.6]:23257 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262850AbTEBBVf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 21:21:35 -0400
Date: Thu, 1 May 2003 18:31:15 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG 2.5.67 (and probably earlier)] /proc/dev/net doesnt show
 all net device
Message-Id: <20030501183115.25bb0774.rddunlap@osdl.org>
In-Reply-To: <200305012018_MC3-1-36FA-118B@compuserve.com>
References: <200305012018_MC3-1-36FA-118B@compuserve.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 May 2003 20:16:00 -0400 Chuck Ebbert <76306.1226@compuserve.com> wrote:

| Randy Dunlap wrote:
| 
| > The reason that I say that is that I can reproduce this problem on
| > 2.5.68, but only in an xterm or similar window, but when I switch back
| > to a console, the entire device list is displayed.
| 
|  There are strange bugs in the console layer and/or the VGA text console.
| Choosing 34-line text mode results in a 30-line screen that the system
| thinks has 34, with four 'hidden' lines at the bottom (on PCI TNT adapter.)
| Maybe a similar thing is happening in X?

I don't think it's quite as deep down as all that.  I built cat.c with
some additional debugging fprintf()s in it.  When I run it from the
text console, it tells me that the variable <outsize> is 4096
(derived from #define ST_BLKSIZE(statbuf)  <about 4 different #defines>.

However, when run from an X terminal window, it tells me that outsize
is 1024.

I don't have time right now to dig into the 4 #defines for ST_BLKSIZE
to see where the problem is.

Anyway, it looks as though the kernel read function for /proc/net/dev
is filling up cat's buffer and just stopping, which seems OK to me.
Looks like a cat bug IMO, but I haven't finished looking at it.


|  And BTW I found a way to get lots of network devices:
| 
|   1. Load the gre tunneling driver (GRE tunnels over IP)
|   2. ip tunnel add gre1 mode gre remote 127.1.1.1 local 127.0.0.1 dev lo
|   3. Repeat for as many as you like... I can't make the kernel
|      send packets through them but they show up on the list.

OK.  Loading dummy driver multiple times is OK for this.

Later,
--
~Randy
