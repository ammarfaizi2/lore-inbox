Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265891AbUFOTrw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265891AbUFOTrw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 15:47:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265890AbUFOTrU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 15:47:20 -0400
Received: from quechua.inka.de ([193.197.184.2]:34791 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S265892AbUFOTq7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 15:46:59 -0400
Date: Tue, 15 Jun 2004 21:46:57 +0200
From: Bernd Eckenfels <be-mail2004@lina.inka.de>
To: linux-kernel@vger.kernel.org
Cc: Trent Lloyd <lathiat@bur.st>, 253590@bugs.debian.org
Subject: Re: Bug#253590: How to turn off IPV6 (link local)
Message-ID: <20040615194657.GA7474@lina.inka.de>
References: <20040614233215.GA10547@lina.inka.de> <20040615023022.GB24269@thump.bur.st>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040615023022.GB24269@thump.bur.st>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2004 at 10:30:23AM +0800, Trent Lloyd wrote:
> > 
> > net.ipv6.conf.default.autoconf does work for the received prefixes, but does
> > not avoid the link local configuration. (this is btw a documentation error)
> 
> autoconf defines whether it will auto-configure an address if a router
> advertises the IPv6 prefix for the network to it.

Yes, but the configure help tells me otherwise. Especially since there are
two options (autoconfigure and accpet_ra) I dont think the current behavious
is intended:


autoconf - BOOLEAN
        Configure link-local addresses using L2 hardware addresses.

        Default: TRUE

accept_ra - BOOLEAN
        Accept Router Advertisements; autoconfigure using them.

        Functional default: enabled if local forwarding is disabled.
                            disabled if local forwarding is enabled.


So I think autoconf=0 should avoid  adding the 3ff8 link local  address (as
well as lo ::1)

> The issue is not having the link local address, because there is no
> default route and hence the connection should fail.

No, please check the bug report. The problem with netscape is that it _does_
fail and not fall back to ipv4. But I think for performance reasons, no ipv6
application should actually try to contact destinations  which are not in
the scope of the configured address (dont connect to sitelocal/global of only
linklocal prefix is  configured)

> The problem, in the case of thi sbug, is that he has IPv6 configured,
> but it is not working, 2001: is a real IPv6 address

That was the initial problem, but we have solved that by turning autoconf
off. The last email was only with an fe80:: prefix.

> Link-local address start with fe80:: and never have a default route so
> they will not be a problem.

They are the problem, as you see above because the applications still
prefers them over ipv4.

> You can't, but it is not the issue here, you could however not load the
> module.

Yes, if it is a module. But see my comment above, I dont think the sysctl
behaves as documented, and does not behave as expected.

I can prepare a patch for this, if everybody  agrees. In addition to that, I
would like to know how application and resolver can be fixed to not use
incomplete or broken v6 setups (i.e. ignore link local prefix on  non local
targets without trying to connect). 

Greetings
Bernd
-- 
  (OO)      -- Bernd_Eckenfels@Mörscher_Strasse_8.76185Karlsruhe.de --
 ( .. )      ecki@{inka.de,linux.de,debian.org}  http://www.eckes.org/
  o--o     1024D/E383CD7E  eckes@IRCNet  v:+497211603874  f:+497211606754
(O____O)  When cryptography is outlawed, bayl bhgynjf jvyy unir cevinpl!
