Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261521AbSI2RVb>; Sun, 29 Sep 2002 13:21:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261536AbSI2RVb>; Sun, 29 Sep 2002 13:21:31 -0400
Received: from mail.scram.de ([195.226.127.117]:50377 "EHLO mail.scram.de")
	by vger.kernel.org with ESMTP id <S261521AbSI2RV3>;
	Sun, 29 Sep 2002 13:21:29 -0400
Date: Sun, 29 Sep 2002 19:26:37 +0200 (CEST)
From: Jochen Friedrich <jochen@scram.de>
X-X-Sender: jochen@alpha.bocc.de
To: Andi Kleen <ak@muc.de>
cc: jbradford@dial.pipex.com, <linux-kernel@vger.kernel.org>,
       <debian-ipv6@debian.org>
Subject: Re: v2.6 vs v3.0
In-Reply-To: <m3k7l47qsv.fsf@averell.firstfloor.org>
Message-ID: <Pine.LNX.4.44.0209291914220.18326-100000@alpha.bocc.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andi,

> Actually current IPv6 is stable and has been for a long time, it's just not
> completely standards compliant (but still quite usable for a lot of people)

For end systems (no router) with static IPv6 definitions this seems to be
true. However, for machines which use autoconfiguration (stateless as
there isn't a usable IPv6 capable DHCP server AFAIK) or act as routers,
the current state of the implementation of the default route can best be
described as buggy. (Autoconfigured machines seem to loose their default
route after some time, e.g.).

Also, there could be a better communication between the kernel and the
resolver to check if if IPv6 is available, at all. Currently, on IPv4 only
kernels, we often see dialogs like this:

ssh -v mail.scram.de
OpenSSH_3.4p1 Debian 1:3.4p1-2.1, SSH protocols 1.5/2.0, OpenSSL
0x0090607f
debug1: Reading configuration data /etc/ssh/ssh_config
debug1: Rhosts Authentication disabled, originating port will not be
trusted.
debug1: ssh_connect: needpriv 0
debug1: Connecting to mail.scram.de [3ffe:400:470:1::1:1] port 22.
socket: Address family not supported by protocol
debug1: Connecting to mail.scram.de [195.226.127.117] port 22.
debug1: Connection established.

So IPv6 is returned by the resolver even though IPv6 isn't available in
the kernel. The default of the resolver options should be dependent
on the presence or absence of IPv6 in the currently running kernel IMHO.

Finally, IPv6 sockets which also communicate over IPv4 using mapped
addresses are considered bad nowadays ;-)

Cheers,
--jochen

