Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268234AbUIXMmw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268234AbUIXMmw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 08:42:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268717AbUIXMmw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 08:42:52 -0400
Received: from mail1.kontent.de ([81.88.34.36]:46297 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S268234AbUIXMmr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 08:42:47 -0400
From: Oliver Neukum <oliver@neukum.org>
To: "Li, Shaohua" <shaohua.li@intel.com>
Subject: Re: suspend/resume support for driver requires an external firmware
Date: Fri, 24 Sep 2004 14:42:03 +0200
User-Agent: KMail/1.6.2
Cc: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
       "Patrick Mochel" <mochel@digitalimplant.org>,
       "Zhu, Yi" <yi.zhu@intel.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
References: <16A54BF5D6E14E4D916CE26C9AD3057534510B@pdsmsx402.ccr.corp.intel.com>
In-Reply-To: <16A54BF5D6E14E4D916CE26C9AD3057534510B@pdsmsx402.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200409241442.03078.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 24. September 2004 13:52 schrieb Li, Shaohua:
> I somewhat think choice 2 is better. The pre-load can be invoked in any
> order instead of in the device tree hierarchy order. And currently only
> few devices need it, is it worth adding it in the device core?

If order doesn't matter, the device tree order is as good as any
other order.

> In addition, the notifiers have better flexibility. We can easily add
> more notifier types if needed, such as adding a callback between the
> sysdev resume and regular devices resume. To tell the truth, we actually
> have the case. An ACPI link device must resume before regular devices
> but must be with IRQ enabled. I'm considering add a call back between
> sysdev and regular devices resume for the issue. I guess the MTRR driver
> in SMP has the same requirement. Anyway, notifier solution sounds like
> easier to extend, but we can't extend device core casually.

If you add this stuff to anything but the device core, you have to teach
the drivers about the various notifier chains. Why would adding methods
to the device core be harder than adding notifier chains? If drivers do
not need the method they don't need to implement it. If they do need
it, using a notifier chain isn't easier.

	Regards
		Oliver

