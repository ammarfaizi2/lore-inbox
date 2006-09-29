Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751257AbWI2SCc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751257AbWI2SCc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 14:02:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751263AbWI2SCc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 14:02:32 -0400
Received: from mga09.intel.com ([134.134.136.24]:40991 "EHLO mga09.intel.com")
	by vger.kernel.org with ESMTP id S1751261AbWI2SCb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 14:02:31 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,238,1157353200"; 
   d="scan'208"; a="138310899:sNHT2280339404"
Date: Fri, 29 Sep 2006 11:01:10 -0700
From: "Luck, Tony" <tony.luck@intel.com>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Keith Owens <kaos@sgi.com>, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: Re: KDB blindly reads keyboard port
Message-ID: <20060929180110.GA4021@intel.com>
References: <14425.1159496284@kao2.melbourne.sgi.com> <200609291057.41529.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200609291057.41529.bjorn.helgaas@hp.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 29, 2006 at 10:57:41AM -0600, Bjorn Helgaas wrote:
>   acpi_parse_fadt: acpi_kbd_controller_present 0

The logic in the kernel seems backwards here though.  We start
by assuming there is a keyboard, then when parsing the FADT
we reset this assumption if the BAF_8042_KEYBOARD_CONTROLLER
bit isn't set.  Which in turn forced SGI to include some
workaround code for their older PROM (which doesn't provide
the FADT table).

There's also a risk that if some code might get added that
runs before we parse FADT that could be confused into thinking
that the keyboard is present.

Wouldn't it be simpler/better to assume there is no keyboard until
we find positive evidence that there is one?

-Tony
