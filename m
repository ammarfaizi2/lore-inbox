Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261443AbULICrz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261443AbULICrz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 21:47:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261442AbULICri
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 21:47:38 -0500
Received: from ipx10069.ipxserver.de ([80.190.240.67]:9950 "EHLO codeblau.de")
	by vger.kernel.org with ESMTP id S261441AbULICrX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 21:47:23 -0500
Date: Thu, 9 Dec 2004 03:46:49 +0100
From: felix-linuxkernel@fefe.de
To: linux-kernel@vger.kernel.org
Subject: ipv6 getting more and more broken
Message-ID: <20041209024649.GA26553@codeblau.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ipv6 is broken for me with 2.6.9 (worked great with 2.6.7, less good but
still workable with 2.6.8).  Here are the symptoms:

I have a LAN with two machines.  No IPv6 routers, no radvd.

I have an application that announces itself via IPv6 multicast UDP
packets with a link-local scope.  I start this application on machine A
and then I have a program on machine B that looks for those and then
tcp-connects to the source IP.

In 2.6.7, everything works fine.  It does not matter whether I start
the announcer first or the listener.

In 2.6.8.1, it only works if I start the listener first.  For some
reason, if I start the listener and then start sending the
announcements, the listener won't see them.  Some bug in the IGMP
handling, I guess.

In 2.6.9, the machines don't even get a link-local address when bringing
an interface up!  This is so utterly and completely broken, how can it
be that nobody has noticed this yet?  I have compiled in ipv6
statically, not as a module, but that should not matter, right?

Also, I would like to have a way to do mss clamping for IPv6.  I am
running a Linux based PPPoE router using 6to4, and would like to
route IPv6 to the LAN behind it, but TCP connections keep getting stuck.
I now manually decreased the MTU on the tunnel interface, but that can't
possibly be the right way to do this.  Any suggestions?

I should mention that "worked great in 2.6.7" may be too kind a
statement as well.  Running both the listener and the announcer on the
same machine yields this bizarre bahviour: the listener gets told the
packet arrived on the lo device, not eth0 (via the scope_id), so the
return tcp connection is going to a link-local ethernet address with
scope_id for loopback and fails, of course.  But it does not fail in a
straightforward manner but simply sits there and does not return (the
connect() call, I mean).  That has been this way for ages and I complain
about it every now and then but so far nobody was appalled enough by
this obvious breakage to fix it.

Please do fix IPv6 now.  The BSD people at least fix their stack when I
complain.

Felix
