Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268070AbUJHGlN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268070AbUJHGlN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 02:41:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268088AbUJHGlN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 02:41:13 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:56337 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S268070AbUJHGlL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 02:41:11 -0400
Date: Fri, 8 Oct 2004 08:41:04 +0200
From: Willy Tarreau <willy@w.ods.org>
To: "David S. Miller" <davem@davemloft.net>
Cc: Olivier Galibert <galibert@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: UDP recvmsg blocks after select(), 2.6 bug?
Message-ID: <20041008064104.GF19761@alpha.home.local>
References: <20041006193053.GC4523@pclin040.win.tue.nl> <003301c4abdc$c043f350$b83147ab@amer.cisco.com> <20041006200608.GA29180@dspnet.fr.eu.org> <20041006163521.2ae12e6d.davem@davemloft.net> <20041007001937.GA48516@dspnet.fr.eu.org> <20041006172959.47c25e3d.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041006172959.47c25e3d.davem@davemloft.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On Wed, Oct 06, 2004 at 05:29:59PM -0700, David S. Miller wrote:
> It absolutely does help the programs not using select(), using
> blocking sockets, and not expecting -EAGAIN.

As I asked in a previous mail in this overly long thread, why not returning
zero bytes at all. It is perfectly valid to receive an UDP packet with 0
data bytes, and any application should be able to support this case anyway.
In case of TCP, this would be a problem because the app would think it
indicates the last byte has been received. But in case of UDP, there is no
problem.

BTW, could we enumerate the known cases where select() might report an FD
as readable while finally not ? If there are only very few cases which can
all be worked around at nearly no cost, it might be worth doing it, or at
least documenting them. From this thread, I gathered :

   1) multi-threaded apps -> broken design anyway, and should be obvious.
      at most, the case can be documented
   2) bad UDP checksums -> this is currently the object of this thread
   3) packet dropped because of buffer size, load, etc... (not confirmed)
   4) others ? any TCP/unix socket/pipe known case ? 

Regards,
Willy

