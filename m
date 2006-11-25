Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966646AbWKYQFu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966646AbWKYQFu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Nov 2006 11:05:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757940AbWKYQFt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Nov 2006 11:05:49 -0500
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:45740 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S1757938AbWKYQFt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Nov 2006 11:05:49 -0500
Date: Sat, 25 Nov 2006 17:02:20 +0100
From: Francois Romieu <romieu@fr.zoreil.com>
To: Martin Michlmayr <tbm@cyrius.com>
Cc: Lennert Buytenhek <buytenh@wantstofly.org>,
       Riku Voipio <riku.voipio@iki.fi>, linux-kernel@vger.kernel.org
Subject: Re: r8169 on n2100 (was Re: r8169 mac address change (was Re: [0/3] 2.6.19-rc2: known regressions))
Message-ID: <20061125160220.GA13480@electric-eye.fr.zoreil.com>
References: <20061107115940.GA23954@unjust.cyrius.com> <20061108203546.GA32247@kos.to> <20061109221338.GA17722@electric-eye.fr.zoreil.com> <20061109231408.GB6611@xi.wantstofly.org> <20061110185937.GA9665@electric-eye.fr.zoreil.com> <20061121102458.GA7846@deprecation.cyrius.com> <20061121204527.GA13549@electric-eye.fr.zoreil.com> <20061122231656.GA9991@electric-eye.fr.zoreil.com> <20061125145226.GA526@deprecation.cyrius.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061125145226.GA526@deprecation.cyrius.com>
User-Agent: Mutt/1.4.2.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Michlmayr <tbm@cyrius.com> :
[...]
> Do you think there'll be a better fix in the future ?

It's the best trade-off that I can figure but there are surely more
knowledgeable people than me. The patch does not completely disable
the reporting of serious PCI errors. If the user knows that it is
otherwise safe, he can disable it: the error will then be reported
only once. I must confess that the history of the 8169 PCI errors is
not crystal clear.

> Do you believe that the boot loader on the N2100 doesn't
> initialize Ethernet properly or that this is a generic problem on iop
> or with this particular RTL chip?  We have fairly good contacts with
> the company producing the N2100 so if it's the former it could
> probably be fixed. (Altough I'm not sure this is the case given that
> Realtek's driver works).

Yes, switching from MM register accesses has been reported to fix/hide
the issue but it's a sledgehammer which does not tell what is going on
(side note: Realtek's driver does not enable the SYSErr irq).

So far I can only tell that 1) the 8169 reports a data parity error on
almost each received packet when it is not silenced 2) the error can
be ignored. If there really is an error and the chipset automatically
retries the transaction, one should expect some loss of efficiency but
it will not necessarily be easy to notice through software.

If I had unlimited resources/time/$$$, I would plug a PCI bus analyzer
and check what is going on. :o)

-- 
Ueimor
