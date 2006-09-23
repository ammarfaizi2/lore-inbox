Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751142AbWIWN1j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751142AbWIWN1j (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 09:27:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751139AbWIWN1j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 09:27:39 -0400
Received: from ironport-c10.fh-zwickau.de ([141.32.72.200]:51613 "EHLO
	ironport-c10.fh-zwickau.de") by vger.kernel.org with ESMTP
	id S1751106AbWIWN1i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 09:27:38 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AQAAAHbSFEWLcAIN
X-IronPort-AV: i="4.09,207,1157320800"; 
   d="scan'208"; a="3401967:sNHT34433464"
Date: Sat, 23 Sep 2006 15:27:36 +0200
From: Joerg Roedel <joro-lkml@zlug.org>
To: jamal <hadi@cyberus.ca>
Cc: Jan-Benedict Glaw <jbglaw@lug-owl.de>, Patrick McHardy <kaber@trash.net>,
       davem@davemloft.net, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: [PATCH 00/03][RESUBMIT] net: EtherIP tunnel driver
Message-ID: <20060923132736.GA345@zlug.org>
References: <20060923120704.GA32284@zlug.org> <20060923121327.GH30245@lug-owl.de> <1159015118.5301.19.camel@jzny2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1159015118.5301.19.camel@jzny2>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 23, 2006 at 08:38:37AM -0400, jamal wrote:

Hello Jamal,

> You just need to use GRE tunnel instead of what you describe above.

The main intention for this driver was not only to provide Ethernet over
IPv4 tunneling. This is also possible in userspace using a tap interface
(as Jan-Benedict Glaw mentioned). Another main intention for this driver
was to provide tunneling of Ethernet packets using the EtherIP protocol.

> While i feel bad that Joerg (and Lennert and others before) have put the
> effort to do the work, i too question the need for this driver. I dont
> think even the authors of the original RFC feel this provides anything
> that GRE cant (according to some posting on netdev that one of the
> authors made).

You are right. I completly agree with this. But this is also true for
the IPIP and the SIT driver. You can do both with GRE. And there are
reasons to keep both in the Kernel.

> My understanding is also that the only other OS that implemented this
> got it wrong - hence you will have to interop with them and provide
> quirks checks.

At the moment I know at least that at least OpenBSD, NetBSD and FreeBSD
support the EtherIP protocol. The first of them was OpenBSD, thats
right. I don't think OpenBSD made a wrong implementation at this point
(I assume you are speaking of the position of the 3 in the header). The
RFC is not clear at this point. It defines that the first 4 bits in the
16 bit Ethernet header MUST be 0011. But it don't defines the
byteorder of that 16 bit word nor if the least or most significant bit
comes first. This was the reason (to keep interoperability with the
existing implementations) I implemented it the same way as OpenBSD and
my driver does not check the incoming EtherIP header.
 
> I am actually curious if anyone uses it instead of GRE in openbsd?

When I searched Google for EtherIP I found some entries in BSD forums
discussing questions concering EtherIP usage. This, and the fact I know
a BSD user that uses EtherIP too, makes be believe there are numerous
users of EtherIP in the BSD world. And at least the BSD user I know
wants interoperability of his NetBSD implemenation with Linux. This
request was the starting point for this driver.

> You could argue that including this driver would allow Linux to have
> another bulb in the christmas tree; the other (more pragmatic way) to
> look at this is it allows spreading a bad idea and needs to be censored.

I am not a friend of censorship. I think the users should have the
freedom to decide what they want to use. There are reasons to have more
than one way to tunnel Ethernet packets in the Kernel (the reason for
EtherIP is the interoperability with the BSD implementations). I don't
know if the GRE driver in mainline already support Ethernet tunneling.
But if not, my driver is already the second way to do it (after the tap
devices).

> I prefer the later - and hope this doesnt discourage Joerg from
> contributing in the future.

Surely not. I intend to further contribute even if this driver would be
finally rejected :)

Regards,
    Joerg Roedel
