Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270391AbTHBVt1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Aug 2003 17:49:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270435AbTHBVt0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Aug 2003 17:49:26 -0400
Received: from almesberger.net ([63.105.73.239]:49677 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S270391AbTHBVtQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Aug 2003 17:49:16 -0400
Date: Sat, 2 Aug 2003 18:49:01 -0300
From: Werner Almesberger <werner@almesberger.net>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Nivedita Singhvi <niv@us.ibm.com>, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: TOE brain dump
Message-ID: <20030802184901.G5798@almesberger.net>
References: <20030802140444.E5798@almesberger.net> <3F2BF5C7.90400@us.ibm.com> <3F2C0C44.6020002@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F2C0C44.6020002@pobox.com>; from jgarzik@pobox.com on Sat, Aug 02, 2003 at 03:08:52PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> jabbering at the same time.  TCP is a "one size fits all" solution, but 
> it doesn't work well for everyone.

But then, ten "optimized xxPs" that work well in two different
scenarios each, but not so good in the 98 others, wouldn't be
much fun either.

It's been tried a number of times. Usually, real life sneaks
in at one point or another, leaving behind a complex mess.
When they've sorted out these problems, regular TCP has caught
up with the great optimized transport protocols. At that point,
they return to their niche, sometimes tail between legs and
muttering curses, sometimes shaking their fist and boldly
proclaiming how badly they'll rub TCP in the dirt in the next
round. Maybe they shed off some of the complexity, and trade it
for even more aggressive optimization, which puts them into
their niche even more firmly. Eventually, they fade away.

There are cases where TCP doesn't work well, like a path of
badly mismatched link layers, but such paths don't treat any
protocol following the end-to-end principle kindly.

Another problem of TCP is that it has grown a bit too many
knobs you need to turn before it works over your really fast
really long pipe. (In one of the OLS after dinner speeches,
this was quite appropriately called the "wizard gap".)

> It's obviously not over a WAN...

That's why NFS turned off UDP checksums ;-) As soon as you put
it on IP, it will crawl to distances you didn't imagine in your
wildest dreams. It always does.

> So, fix the other end of the pipeline too, otherwise this fast network 
> stuff is flashly but pointless.  If you want to serve up data from disk, 
> then start creating PCI cards that have both Serial ATA and ethernet 
> connectors on them :)  Cut out the middleman of the host CPU and host 
> memory bus instead of offloading portions of TCP that do not need to be 
> offloaded.

That's a good point. A hierarchical memory structure can help
here. Moving one end closer to the hardware, and letting it
know (e.g. through sendfile) that also the other end is close
(or can be reached more directly that through some hopelessly
crowded main bus) may help too.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina     werner@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
