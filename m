Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316877AbSE1S3G>; Tue, 28 May 2002 14:29:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316878AbSE1S3F>; Tue, 28 May 2002 14:29:05 -0400
Received: from funnybee.ntlp.com ([198.51.93.4]:49164 "EHLO funnybee.ntlp.com")
	by vger.kernel.org with ESMTP id <S316877AbSE1S3E>;
	Tue, 28 May 2002 14:29:04 -0400
Date: Tue, 28 May 2002 12:28:58 -0600 (MDT)
From: James Yonan <jim@ntlp.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux crypto?
Message-ID: <Pine.LNX.4.44.0205281209440.26292-100000@funnybee.ntlp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, 24 May 2002, Alan Cox wrote:

> > > On Wed, 22 May 2002, Alan Cox wrote:
> > > 
> > > > What of it do you actually need in kernel space - encrypted file 
systems
> > > > certainly ought to be there but are not very well handled in Linux 
proper
> > > > right now - but anything else ?
> > > 
> > > IPsec.
> > 
> > At the moment there doesn't appear to be an IPsec stack we can merge 
however

> what about freeswan - with some cleanups?

I'd like to propose that network crypto can be handled well in user-space.

There are quite a few user-space options now for secure tunneling of IP or 
ethernet.  I am personally a developer on the OpenVPN project, but there 
are quite a few others including VTun, cipe, and tinc.  I know that 
OpenVPN and VTun take advantage of the Universal TUN/TAP driver which has 
been in the official kernel since 2.4.6 or so, which lets user-space 
programs control a virtual point-to-point IP link or virtual ethernet 
adapter.  While not explicitly a crypto-enabler, the TUN/TAP driver nicely 
imposes a modularization on secure tunneling daemons -- the bulk of the 
code including crypto lives in user-space and the kernel component is 
reduced to a small virtual network driver that talks to user-space rather 
than hardware -- and which hopefully is sufficiently generic that it 
doesn't fall into the class of crypto-enabling infrastructure with respect 
to export-control regulations.  Running in userspace confers a number of 
other benefits such as:

1. the daemon is easily portable beyond Linux to any platform that 
supports a tun driver (such as OpenBSD, FreeBSD, Mac OS X, and Solaris).  
IPSec implementations tend to be OS-specific,

2. the daemon can use portable user-space libraries such as OpenSSL to 
handle the crypto, taking advantage of the SSL/TLS protocol and the X509 
PKI,

3. the daemon can tunnel over UDP (IPSec uses IP protocols 50 and 51 which 
are often blocked by broadband ISPs),

4. the daemon can tunnel through NAT gateways (IPSec doesn't like NAT), 
and

5. the daemon can transparently tunnel or bridge non-IP protocols or any 
protocol which can be represented as an ethernet frame.

The downside of course is that a user-space implementation will be slower.  
It's also difficult to achieve IPSec compliance, because user-space 
tunneling daemons want to use an application-level protocol over UDP -- 
user-space is not the right place to implement a protocol stack.

But the upside is that the secure tunneling daemons are available now, 
the better ones are robust, secure, and portable, they don't require 
embedding any crypto or crypto hooks in the kernel, and they work
with most out-of-the-box 2.4 distributions without needing any external
kernel modules.


James Yonan
OpenVPN Developer
http://openvpn.sourceforge.net/

