Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261917AbTHTMuJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 08:50:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261918AbTHTMuJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 08:50:09 -0400
Received: from ns.indranet.co.nz ([210.54.239.210]:60873 "EHLO
	mail.acheron.indranet.co.nz") by vger.kernel.org with ESMTP
	id S261917AbTHTMuE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 08:50:04 -0400
Date: Thu, 21 Aug 2003 00:49:52 +1200
From: Andrew McGregor <andrew@indranet.co.nz>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [OT] Connection tracking for IPSec
Message-ID: <23600000.1061383792@ijir>
In-Reply-To: <1061378568.668.9.camel@teapot.felipe-alfaro.com>
References: <1061378568.668.9.camel@teapot.felipe-alfaro.com>
X-Mailer: Mulberry/3.1.0b4 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--On Wednesday, August 20, 2003 01:22:49 PM +0200 Felipe Alfaro Solana 
<felipe_alfaro@linuxmail.org> wrote:

> Hi all!
>
> I'm starting with IPSec right now. To make it work, I must open up
> protocols 50 and 51 to pass across my Linux firewalls, but I want to use
> connection tracking much like I do when not using IPSec.
>
> For example,
>
> iptables -A INPUT -m state --state RELATED,ESTABLISHED

Hmm.  You can't do this if the end host does the ESP (AH is another 
matter).  Ever.  If the ESP is working, the router can't tell what is 
inside the packet; this is the whole point of IPSEC.  If you want this 
functionality, you can only provide it on the end host, or else do the 
IPSEC on the router.

> When using IPSec, if I open up protocols 50 and 51, all IPSec-protected
> traffic passes through the firewall, but it's not checked against the
> connection tracking module. How can I configure iptables so an
> IPSec-protected packet, after being classified as IP protocol 50 or 51,
> loop back one more time to pass through the connection tracking module?

You can't, by design of IPSEC.  However, you do have a couple of options:

1) let through IPSEC only for hosts you trust
2) for hosts you must firewall at the router, do the IPSEC there too, and 
do not allow those hosts to use IPSEC.

These aren't exclusive.

>
> I don't want to set up IPSec to get addititional protection by using AH
> and ESP and then let any machine talking IPSec pass entirely through my
> firewall ignoring the rest of rules.
>
> Thanks!

You're welcome.

Andrew



