Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265119AbUF1SeU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265119AbUF1SeU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 14:34:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265127AbUF1SeT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 14:34:19 -0400
Received: from mail.enyo.de ([212.9.189.167]:2570 "EHLO mail.enyo.de")
	by vger.kernel.org with ESMTP id S265119AbUF1SeN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 14:34:13 -0400
To: "Miquel van Smoorenburg" <miquels@cistron.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: TCP-RST Vulnerability - Doubt
References: <40DC9B00@webster.usu.edu>
	<20040625150532.1a6d6e60.davem@redhat.com>
	<cbp62t$a38$1@news.cistron.nl>
From: Florian Weimer <fw@deneb.enyo.de>
Date: Mon, 28 Jun 2004 20:34:12 +0200
In-Reply-To: <cbp62t$a38$1@news.cistron.nl> (Miquel van Smoorenburg's
 message of "Mon, 28 Jun 2004 13:22:37 +0000 (UTC)")
Message-ID: <87vfhblefv.fsf@deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Miquel van Smoorenburg:

> MD5 protection on BGP sessions isn't very common yet.

Well, there was quite some technology push recently. 8-)

> MD5 uses CPU, and routers don't usually have much of that. Which
> means that now an MD5 CPU attack is possible instead of a TCP RST
> attack.

Anything that is able to send packets to the CPU which runs the TCP
stack can take down your router.  Core routers with 200 MHz MIPS CPUs
are still common.  It really doesn't matter much if you have to do a
MD5 check or not, the CPU will be easy to overload.  However, the TCP
MD5 option is a nice thing to have because you can enable it and avoid
discussions (just like you do it with antivirus software 8-/).

Part of the beauty of the TTL hack is that it actually works in
linecard CPUs or ASICs on some routing architectures, which takes the
load off the main CPU.  For Linux, you can also drop the packets
before they hit the route cache, which might be become more important
in the future when the route cache is no longer used for forwarding.
