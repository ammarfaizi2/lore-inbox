Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264419AbUASG7u (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 01:59:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264420AbUASG7u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 01:59:50 -0500
Received: from dp.samba.org ([66.70.73.150]:50369 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S264419AbUASG7s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 01:59:48 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: modprobe failed: digest_null 
In-reply-to: Your message of "Thu, 15 Jan 2004 08:30:50 -0800."
             <20040115083050.333bb13d.rddunlap@osdl.org> 
Date: Mon, 19 Jan 2004 15:53:05 +1100
Message-Id: <20040119065944.A1DA02C2A1@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20040115083050.333bb13d.rddunlap@osdl.org> you write:
> On Thu, 15 Jan 2004 09:08:15 +0100 martin f krafft <madduck@madduck.net> wrot
e:
> 
> | also sprach Rusty Russell <rusty@rustcorp.com.au> [2004.01.15.0022 +0100]:
> | > Upgrade module-init-tools to 0.9.14 or one of the 3.0 -pres.
> | 
> | diamond:~# modprobe -V
> | module-init-tools version 3.0-pre5
> 
> Yes, and I'm using 0.9.14 and seeing similar messages.

Yes, as several people have pointed out.  I *did* briefly make the
change so -q always returned "success", but had to revert it because
it caused infinite loops in some legitimate configurations (thanks to
Jamie Lokier for reporting this).

With the change to default to idemptent behavior (modprobe foo when
foo is already installed silently "succeeds" unless --first-time is
specified), the definition of -q can be safely changed to mean "ignore
this if you've never heard of it").

This is done in 3.0-pre6, now available.

BTW, if you had fairly complex modules.conf, you should regenerate
modprobe.conf for the 3.0 releases: some cases have changed.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
