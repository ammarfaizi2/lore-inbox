Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135857AbRDYMoD>; Wed, 25 Apr 2001 08:44:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135860AbRDYMny>; Wed, 25 Apr 2001 08:43:54 -0400
Received: from smtp1.cern.ch ([137.138.128.38]:17933 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S135855AbRDYMnr>;
	Wed, 25 Apr 2001 08:43:47 -0400
Date: Wed, 25 Apr 2001 14:43:38 +0200
From: Jamie Lokier <ln@tantalophile.demon.co.uk>
To: "Dr. Michael Weller" <eowmob@exp-math.uni-essen.de>
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: Re: Dynamic TCP reserved ports allocated in which range?
Message-ID: <20010425144338.B18214@pcep-jamie.cern.ch>
In-Reply-To: <Pine.A32.3.95.1010419104422.13922A-100000@werner.exp-math.uni-essen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.A32.3.95.1010419104422.13922A-100000@werner.exp-math.uni-essen.de>; from eowmob@exp-math.uni-essen.de on Thu, Apr 19, 2001 at 10:52:00AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dr. Michael Weller wrote:
> For a firewall setup I need to know in which range applications like
> rsh, or better yet the rresvport() libc function allocate reserved ports.
> 
> Do I have to expect ports in the whole 1..1024 range (maybe omitting those
> already in use by other servers) or is only a limited range used (like
> 512-1023).

This isn't a kernel question as the allocation is handled entirely by
userspace.  Userspace tries each port in turn until it finds one that
isn't used at the moment.

The non-privileged local port range can be read from and written to
/proc/sys/net/ipv4/ip_local_port_range, but that's not your question.

The man page for rresvport() says:

     The rresvport() function is used to obtain a socket with a
     privileged address bound to it.  This socket is suitable for use by
     rcmd() and several other functions.  Privileged Internet ports are
     those in the range 0 to 1023.  Only the super-user is allowed to
     bind an address of this sort to a socket.

For a firewall, you should probably distinguish these ports from fixed
services ports (like ssh and smtp) by having different rules for
Outgoing and Incoming connections.  This is done by matching on the TCP
SYN and ACK flags (see any firewall tutorial).

enjoy,
-- Jamie
