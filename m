Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424048AbWKIPYr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424048AbWKIPYr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 10:24:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424031AbWKIPYr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 10:24:47 -0500
Received: from mail.gmx.net ([213.165.64.20]:33666 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1424048AbWKIPYq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 10:24:46 -0500
X-Authenticated: #14349625
Subject: Re: 2.6.19-rc5 breaks klogd 1.4.1
From: Mike Galbraith <efault@gmx.de>
To: Andrew Morton <akpm@osdl.org>
Cc: John Wendel <jwendel10@comcast.net>, linux-kernel@vger.kernel.org
In-Reply-To: <1163067064.6145.4.camel@Homer.simpson.net>
References: <4552BB55.9090400@comcast.net>
	 <20061108224153.4ed2e581.akpm@osdl.org> <4552D4B4.5020505@comcast.net>
	 <20061108233517.7cc1db12.akpm@osdl.org>
	 <1163067064.6145.4.camel@Homer.simpson.net>
Content-Type: text/plain
Date: Thu, 09 Nov 2006 16:25:26 +0100
Message-Id: <1163085926.6087.17.camel@Homer.simpson.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-11-09 at 11:11 +0100, Mike Galbraith wrote:
> On Wed, 2006-11-08 at 23:35 -0800, Andrew Morton wrote:
> 
> > And, predictably, reads from /proc/kmsg aren't blocking.
> > 
> > I can't see what might have caused that.  Are you sure that 2.6.19-rc4 was
> > OK?  And are you sure that nothing else has changed on that system?
> 
> Here, both rc4 and rc5 do the same if printk is configured out.

Well duh, of course it does.  Testing and _then_ looking at the source
was not the correct order in this case :)

> Why do we have a /proc/ksmg when nothing can get to it?

The sensible thing seemed to be to whack it, but when I did that, klogd
just switched interfaces, and proceeded to eat 100% cpu doing
syslog(0x2, 0xb7fc0008, 0x1ffff) instead.  Leaving it in place, but
making it block to simulate an empty buffer works fine, but seems kinda
cheezy.

Whacking /proc/kmsg, and making sys_syslog() block on read to simulate
the empty buffer seemed much better, but SuSE's boot scripts hang when
they try to create /var/log/boot.msg ala /sbin/klogd -s -o -n
-f /var/log/boot.msg.  That seems to work now only because there is
always something there to grab.

The correct answer seems to be "fix klogd, or don't disable printk".

	-Mike

