Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262066AbVAYTCK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262066AbVAYTCK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 14:02:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262064AbVAYTAy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 14:00:54 -0500
Received: from smtp-102-tuesday.noc.nerim.net ([62.4.17.102]:37380 "EHLO
	mallaury.noc.nerim.net") by vger.kernel.org with ESMTP
	id S262065AbVAYS7O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 13:59:14 -0500
Date: Tue, 25 Jan 2005 19:59:18 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Greg KH <greg@kroah.com>
Cc: Christoph Hellwig <hch@infradead.org>, Adrian Bunk <bunk@stusta.de>,
       Andrew Morton <akpm@osdl.org>, Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.11-rc2-mm1: SuperIO scx200 breakage
Message-Id: <20050125195918.460f2b10.khali@linux-fr.org>
In-Reply-To: <20050125060256.GB2061@kroah.com>
References: <20050124021516.5d1ee686.akpm@osdl.org>
	<20050124175449.GK3515@stusta.de>
	<20050124213442.GC18933@kroah.com>
	<20050124214751.GA6396@infradead.org>
	<20050125060256.GB2061@kroah.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

> As previously mentioned, these patches have had that, on the sensors
> mailing list.  Lots of review and comments went into them there, and
> the code was reworked quite a lot based on it.

That's right, I did actually review Evgeniy's code some times ago, as
can be seen here:
http://archives.andrew.net.au/lm-sensors/msg27817.html

I might however add the following:

1* This was 5 months ago. I'd expect Evgeniy's code to have
significantly evolved since, so an additional review now would certainly
be welcome.

2* I only reviewed the superio code. The acb part is completely new so I
obviously couldn't comment on it back then, and I skipped the gpio part
because I admittedly have no particular interest in this part.

3* Some of my objections have been ignored by Evgeniy. Among others, the
choice of "sc" as a prefix for the superio stuff is definitely poor and
has to be changed.

http://archives.andrew.net.au/lm-sensors/msg27847.html

I don't think that getting the whole stuff (superio, acb and gpio)
merged at once is a good idea. Preferably we would merge superio alone
first, then update the drivers that are already in the kernel and could
make use of it (it87, w83627hf, pc87360 and smsc47m1, all of i2c/sensors
fame, come to mind). This would help ensure that Evgeniy's interface
choices were correct, and would additionally be a very good example of
how this interface must be used. Then, and only then IMVHO, should the
gpio and acb stuff be merged.

Before all this happens, I really would like Evgeniy to present an
overall plan of his current superio implementation. Last time we
discussed about this, we obviously had different views on the interface
level that should be proposed by the superio core, as well as how
chip-specific values should be handled (or, according to me, mostly not
handled). 

Please note that I am certainly not the most qualified of us all to
review this code. What I can do is check whether I will be able to use
the new superio interface in the sensor chip drivers I mentioned above,
and that's about it. I am not familiar enough with kernel core
architectures to decide whether Evgeniy's approach is correct or not. I
am willing to help, but I can do so only within my own current skills.

Thanks,
-- 
Jean Delvare
http://khali.linux-fr.org/
