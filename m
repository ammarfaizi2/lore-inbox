Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263129AbTFPALG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 20:11:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263131AbTFPALG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 20:11:06 -0400
Received: from dp.samba.org ([66.70.73.150]:27837 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S263129AbTFPALB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 20:11:01 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: module-init-tools and chained aliases 
In-reply-to: Your message of "Sun, 15 Jun 2003 13:52:36 +0400."
             <200306151352.36226.arvidjaar@mail.ru> 
Date: Mon, 16 Jun 2003 10:04:55 +1000
Message-Id: <20030616002453.99E172C07D@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <200306151352.36226.arvidjaar@mail.ru> you write:
> Apparently modprobe from module-init-tools 0.9.11a does not support chained 
> aliases like modutils did, i.e.
> 
> alias foo bar
> alias bar baz
> 
> will result in error doing "modprobe foo" instead of loading "baz".

Yes, as per the documentation.

> This is a real problem when converting modules.devfs, because customary
> 
> alias /dev/tts* /dev/tts
> alias /dev/tts serial

generate-modutils.conf will do the right thing here, and unroll the
aliases.  And the README in module-init-tools says:

	4) If you are using devfs, copy modprobe.devfs to /etc

And modprobe.devfs gets it right.

> Is the behaviour intentional? Fixing it is just a one line patch and
> I fail to see why current state would be preferred.

Your patch only works for forwards references, not backwards
references.

There may be convincing arguments to adding support for recursive
aliases, but this isn't it.

Sorry,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
