Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261654AbTIVSGY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 14:06:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261683AbTIVSGY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 14:06:24 -0400
Received: from dns.toxicfilms.tv ([150.254.37.24]:19908 "EHLO
	dns.toxicfilms.tv") by vger.kernel.org with ESMTP id S261654AbTIVSGX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 14:06:23 -0400
Date: Mon, 22 Sep 2003 20:06:20 +0200 (CEST)
From: Maciej Soltysiak <solt@dns.toxicfilms.tv>
To: "Hassan M. Jafri" <hjafri@ncsa.uiuc.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: TCP connections dropped
In-Reply-To: <5.1.0.14.2.20030922124433.0748c478@mail.ncsa.uiuc.edu>
Message-ID: <Pine.LNX.4.51.0309221955410.1638@dns.toxicfilms.tv>
References: <5.1.0.14.2.20030922124433.0748c478@mail.ncsa.uiuc.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Sep 2003, Hassan M. Jafri wrote:

> I am running a parallel program on 170 nodes, with 2 processes on each
> nodes. so 340 total processes. Each process has a TCP connection
> established with every other process. So each process has 339 sockets in
> ESTABLISHED state. The problem occurs when I try to write() on these
> socket. The TCP connection gets dropped for some of the sockets of a few
> processes as soon as they try to write to those socket. This problem,
> however, does not occur, if I reduce the number of processes to less than
> 306 (305 TCP sockets/connections for each process).
>
> Any ideas why connections are getting dropped?
I guess your hosts run out of memory for storing open sockets.
It's propably like synflooding yourself to death.
When I was once doing synfloods tests, I could store only about 170
connections before having the same effect as you: packet drops.
So:
1. Try enabling syncookies (in the kernel _and_ in
   /proc/sys/net/ipv4/tcp_syncookies)
2. Try increasing
   /proc/sys/net/ipv4/tcp_max_syn/backlog
3. Try reading about other memory related knobs.
   /usr/src/linux/Documentation/network/ip-sysctl.txt
4. When reading about syncookies in ip-sysctl, read also:
   http://cr.yp.to/syncookies.html
   especially the last section called: SYN cookie monsters.

   Both of these documents are in contradiction about 'protocol
   violation', etc. I wonder, has this been sorted out among Kuznetsov,
   Akkerman, Metzger and Bernstein?
   Anyway I feel safe with D. J. Bernsteins notes about it.

Regards,
Maciej

