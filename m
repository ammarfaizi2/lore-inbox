Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263510AbTKQKM3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 05:12:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263517AbTKQKM3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 05:12:29 -0500
Received: from mail.fh-wedel.de ([213.39.232.194]:17133 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S263510AbTKQKMZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 05:12:25 -0500
Date: Mon, 17 Nov 2003 11:08:47 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Thomas Habets <thomas@habets.pp.se>, "David S. Miller" <davem@redhat.com>
Cc: Henrik Storner <henrik@hswn.dk>, linux-kernel@vger.kernel.org,
       Holger Kiehl <Holger.Kiehl@dwd.de>, linux-net@vger.kernel.org
Subject: Re: PROBLEM: Memory leak in -test9?
Message-ID: <20031117100847.GB21285@wohnheim.fh-wedel.de>
References: <E1AJahk-00011D-00@reptilian.maxnet.nu> <20031111162734.GA29454@wohnheim.fh-wedel.de> <E1AJcJZ-0008Ts-00@reptilian.maxnet.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <E1AJcJZ-0008Ts-00@reptilian.maxnet.nu>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 November 2003 18:27:12 +0100, Thomas Habets wrote:
> 
> On Tuesday 11 November 2003 17:27, Jörn Engel wrote:
> > Looks familiar.  Can you recreate and send the output from
> > /proc/slabinfo?
> 
> Oh, I didn't notice that file. :-)
> Recreating is just booting and waiting for a week, but the box is still up.
> 
> This is the line that stands out (complete file attached, 137 lines).
> 
> tcp6_sock         111663 111664    960    4    1 : tunables   54   27    0 : 
> slabdata  27916  27916      0
> 
> I seem to remember a changelog mentioning a leak being fixed in ipv6 code, 
> but it looks like there may be another one? The only ipv6 service running is 
> sshd, and the mrtg-sshs that go off every 5 minutes are NOT over ipv6. 
> netstat -na shows nothing interesting. Only the ssh I connect with uses a bit 
> of ipv6 (ffff:1.2.3.4). So, one listening socket, and one established.

Holger Kiehl found a similar leak somewhere in the ipv4 code, possibly
route.c.  We couldn't nail the problem down yet and it could still be
inside a seperate device driver (GPL, outside of kernel tree).

Holger's problem is independent of the one found by the stanford
checker some weeks ago, so there seem to be or have been at least
three memory leaks in the network code.  Could be a single developer
that is simply not careful enough wrt. resource leaks.

David, can you think of an easy way to find all of those leaks?
Easier than waiting for bug reports and hunting them one by one?

Jörn

-- 
Fantasy is more important than knowlegde. Knowlegde is limited,
while fantasy embraces the whole world.
-- Albert Einstein
