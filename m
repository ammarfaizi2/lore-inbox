Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264392AbUBRLxS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 06:53:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264286AbUBRLxS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 06:53:18 -0500
Received: from mail1.webmaster.com ([216.152.64.168]:51218 "EHLO
	mail1.webmaster.com") by vger.kernel.org with ESMTP id S264455AbUBRLxQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 06:53:16 -0500
From: "David Schwartz" <davids@webmaster.com>
To: <hasso@estpak.ee>
Cc: "Linux Kernel" <linux-kernel@vger.kernel.org>
Subject: RE: raw sockets and blocking
Date: Wed, 18 Feb 2004 03:42:07 -0800
Message-ID: <MDEHLPKNGKAHNMBLJOLKMENGKHAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <200402180842.19288.hasso@estpak.ee>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2055
X-Authenticated-Sender: joelkatz@webmaster.com
X-Spam-Processed: mail1.webmaster.com, Wed, 18 Feb 2004 03:20:54 -0800
	(not processed: message from valid local sender)
X-MDRemoteIP: 206.171.168.138
X-Return-Path: davids@webmaster.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: davids@webmaster.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> David Schwartz wrote:

> > > we havnt yet tested if it becomes writeable again if we put cable
> > > back in, however if we detect absence of IFF_RUNNING and hence
> > > manually avoid constructing packets to be sent via link-down
> > > interfaces, we avoid this problem. However, this leaves us with a
> > > race.

> > 	I'm not sure I understand what the problem is. If the network
> > cable is disconnected, you couldn't usefully send anything if the
> > socket was ready anyway.

> One raw socket is used to send packets to several interfaces. If only
> one of them is down, socket will be blocked as well.

	Then the kernel is broken. It must not block an operation indefinitely when
that operation can complete without blocking.

	It is, however, perfectly legal to say an operation can complete without
blocking (say, through 'select' or 'poll') and later return EWOULDBLOCK. (So
long as some operation could have completed, not necessarily the one you
tried.) Just as a 'poll may return that write is okay for a TCP connection
but a 64Kb write will definitely block.

	DS


