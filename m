Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282232AbRKWU2n>; Fri, 23 Nov 2001 15:28:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282231AbRKWU2d>; Fri, 23 Nov 2001 15:28:33 -0500
Received: from ktk.bidmc.harvard.edu ([134.174.237.112]:13841 "EHLO
	ktk.bidmc.harvard.edu") by vger.kernel.org with ESMTP
	id <S282226AbRKWU20>; Fri, 23 Nov 2001 15:28:26 -0500
Message-ID: <3BFEB169.3E4952A8@bigfoot.com>
Date: Fri, 23 Nov 2001 15:28:25 -0500
From: "Kristofer T. Karas" <ktk@bigfoot.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en-GB, en
MIME-Version: 1.0
To: rpjday <rpjday@mindspring.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: is 2.4.15 really available at www.kernel.org?
In-Reply-To: <Pine.LNX.4.33.0111230437180.7283-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

rpjday wrote:

> [...]www.kernel.org/pub/linux/kernel/v2.4/linux-2.4.15.tar.bz2, and it
> completed after downloading *exactly* 155312 bytes, just as before.
>
> getting it via ftp works fine -- it's http that's giving me this
> weird problem.   is it just me?

You probably have a proxy server in your path that doesn't re-request partially-sent
files.  I have your problem too, using squid-cache as the proxy.  Here's what
happens:

The http server (kernel.org) sends the file to the proxy, which sends it to you.  But
because the net connection from kernel.org to the proxy is faster than it is from
proxy to you, the tcp window between proxy and kernel.org goes to zero.  When it
opens up again, kernel.org closes the connection even though the file is only
partially received.  The proxy, failing to detect that the file is smaller than the
Content-Length header said it would be, simply sends the truncated contents  your
way.

I "fixed" this bug by using 'wget' to retrieve the files for me.  It has the same
problem, obtaining a truncated file; but it is smart enough to re-request missing
byte-ranges of the file, ultimately obtaining the entire thing.

Kris

