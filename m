Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261537AbUKWGE2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261537AbUKWGE2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 01:04:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262282AbUKWGDG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 01:03:06 -0500
Received: from web41404.mail.yahoo.com ([66.218.93.70]:25497 "HELO
	web41404.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261537AbUKWGA0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 01:00:26 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=vujULM1DCUgbkzhga71JdgpNL6+Tf2j9gYz08W8tdbqiObAhIXw47vl7fyQnRRV2mwhIw6j/iS0RSdDk8JVC+4eryhPj9xMw0gQJCGYFxhJCTmiwbtDAliL7dAwd55efDNr2/qp7CQqJKccqYyR+j6Zzgv19p7TqYv6yArPLBcc=  ;
Message-ID: <20041123060017.44262.qmail@web41404.mail.yahoo.com>
Date: Mon, 22 Nov 2004 22:00:17 -0800 (PST)
From: cranium2003 <cranium2003@yahoo.com>
Subject: RE: netfilter query
To: stuart@ken-caryl.net
Cc: Henrik Nordstrom <hno@marasystems.com>, kernelnewbies@nl.linux.org,
       netfilter-devel@lists.netfilter.org, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <DHEOJAHAGKDLCDOHPMIECEFNCCAA.stuart@ken-caryl.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello Stuart,
           Thanks for the reply. Which kernel
parameter
for Bridge to be enabled. I have RH9 with 2.4.20-8
kernel installed and i found nearly all kernel
parameters with word bridging enabled. Also i try
brctl command at console prompt but no utility is
present in my linux.
          one more thing how can i see packets to
parse them?

regards,
cranium.
--- Stuart Macdonald <stuart@ken-caryl.net> wrote:

> Just a parallel thought here,
> 
> A different approach is to implement the Netfilter
> Bridge hooks and run a
> box as a bridge. This requires a kernel parameter
> for Bridge to be enabled
> when the kernel is built and then the brctl utility
> to setup the bridge. In
> this manner, your bridge netfilter hooks always
> receive packets starting at
> the MAC headers. You can parse from there to derive
> subsequent protocols:
> IP, IPX, LLC, SNAP, NETBEUI...
> 
> Stuart
> 
> 
> 
> -----Original Message-----
> From: kernelnewbies-bounce@nl.linux.org
> [mailto:kernelnewbies-bounce@nl.linux.org]On Behalf
> Of Henrik Nordstrom
> Sent: Monday, November 22, 2004 5:03 AM
> To: cranium2003
> Cc: kernelnewbies@nl.linux.org; netdev@oss.sgi.com;
> netfilter-devel@lists.netfilter.org;
> linux-kernel@vger.kernel.org
> Subject: Re: netfilter query
> 
> 
> On Sun, 21 Nov 2004, cranium2003 wrote:
> 
> > Also,which headers are added when packet
> > reaches to netfilter hook NF_IP_LOCAL_OUT? I found
> > TCP/UDP/ICMP ,IP. Is that correct?
> 
> Yes.
> 
> netfilter is running at the IP layer and only
> reliably have access to IP
> headers and up. Lower level headers such as Ethernet
> MAC header is
> transport dependent and not always available, and
> certainly not available
> in NF_IP_LOCAL_OUT as it is not yet known the packet
> will be sent to an
> Ethernet.
> 
> In some netfilter hooks it is possible to rewind
> back to the Ethernet MAC
> header but one must be careful to verify that it
> really is an Ethernet
> packet one is looking at when doing this.
> Unfortunately there is no
> perfect solution how to detect this.. For an example
> of how one may try to
> look at the Ethernet MAC header see ipt_mac.c. But
> be warned that it is
> possible for non-Ethernet frames to pass the simple
> checks done there..
> 
> Regards
> Henrik
> 
> --
> Kernelnewbies: Help each other learn about the Linux
> kernel.
> Archive:      
> http://mail.nl.linux.org/kernelnewbies/
> FAQ:           http://kernelnewbies.org/faq/
> 
> 
> 


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
