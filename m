Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2993129AbWJURlS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993129AbWJURlS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 13:41:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993125AbWJURlS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 13:41:18 -0400
Received: from pm-mx5.mgn.net ([195.46.220.209]:41915 "EHLO pm-mx5.mgn.net")
	by vger.kernel.org with ESMTP id S2993124AbWJURlR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 13:41:17 -0400
From: Damien Wyart <damien.wyart@free.fr>
To: Auke Kok <auke-jan.h.kok@intel.com>
Cc: Daniel Walker <dwalker@mvista.com>, Andrew Morton <akpm@osdl.org>,
       Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org,
       Jesse Brandeburg <jesse.brandeburg@intel.com>,
       NetDev <netdev@vger.kernel.org>
Subject: Re: [PATCH] e100_shutdown: netif_poll_disable hang
References: <20061020182820.978932000@mvista.com> <453936E0.1010204@intel.com>
	<45393B0B.8090301@intel.com>
Date: Sat, 21 Oct 2006 19:41:15 +0200
In-Reply-To: <45393B0B.8090301@intel.com> (Auke Kok's message of "Fri\, 20 Oct
	2006 14\:09\:31 -0700")
Message-ID: <87slhh1s90.fsf@brouette.noos.fr>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.0.50
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > My machine annoyingly hangs while rebooting. I tracked it down to
> > > e100-fix-reboot-f-with-netconsole-enabled.patch in 2.6.18-rc2-mm2
> > > I review the changes and it seemed to be calling
> > > netif_poll_disable one too many time. Once in e100_down(), and
> > > again in e100_shutdown().
> > > The second one in e100_shutdown() caused the hang. So this patch
> > > removes it.

* Auke Kok <auke-jan.h.kok@intel.com> [061020 23:09]:
> it doesn't even do harm to netif_poll_disable() twice as far as I can
> see, as it merely calls test_and_set_bit(), which will instantly
> succeed on the first attempt if the bit was already set.

> did this change actually fix it for you? I'm wondering if the
> netif_carrier_off might not be the culprit here...

I can confirm the proposed original change of D. Walker fixed the
problem for me. I did not test the change you proposed as a followup.

-- 
Damien Wyart
