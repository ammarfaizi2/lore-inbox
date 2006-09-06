Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965256AbWIFBhU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965256AbWIFBhU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 21:37:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932237AbWIFBhU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 21:37:20 -0400
Received: from mga06.intel.com ([134.134.136.21]:35428 "EHLO
	orsmga101.jf.intel.com") by vger.kernel.org with ESMTP
	id S932210AbWIFBhS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 21:37:18 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.08,217,1154934000"; 
   d="scan'208"; a="121461303:sNHT118961101"
Subject: Re: pci error recovery procedure
From: "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>
To: Linas Vepstas <linas@austin.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@ozlabs.org,
       linux-pci maillist <linux-pci@atrey.karlin.mff.cuni.cz>,
       Yanmin Zhang <yanmin.zhang@intel.com>,
       LKML <linux-kernel@vger.kernel.org>,
       Rajesh Shah <rajesh.shah@intel.com>
In-Reply-To: <20060905185020.GD7139@austin.ibm.com>
References: <1157008212.20092.36.camel@ymzhang-perf.sh.intel.com>
	 <20060831175001.GE8704@austin.ibm.com>
	 <1157081629.20092.167.camel@ymzhang-perf.sh.intel.com>
	 <20060901212548.GS8704@austin.ibm.com>
	 <1157348850.20092.304.camel@ymzhang-perf.sh.intel.com>
	 <1157360592.22705.46.camel@localhost.localdomain>
	 <20060905185020.GD7139@austin.ibm.com>
Content-Type: text/plain
Message-Id: <1157506521.20092.395.camel@ymzhang-perf.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Wed, 06 Sep 2006 09:35:21 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-09-06 at 02:50, Linas Vepstas wrote:
> On Mon, Sep 04, 2006 at 07:03:12PM +1000, Benjamin Herrenschmidt wrote:
> > 
> > > As you know, all functions of a device share the same bus number and 5 bit dev number.
> > > They just have different 3 bit function number. We could deduce if functions are in the same
> > > device (slot).
> > 
> > Until you have a P2P bridge ...
> 
> And this is not theoretical: for example, the matrox graphics cards:
> 
> 0000:c8:01.0 PCI bridge: Hint Corp HB6 Universal PCI-PCI bridge (non-transparent mode) (rev 13)
> 0000:c9:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP (rev 85)
> 
> Now, I could have sworn there was another device behind this bridge, 
> some serial or joystick controller or something, although this
> particular card doesn't seem to have it.
Thanks. My comments above in this email is just to try to find a method
to judge if 2 or more functions belongs to the same device. If it's
not right, it still doesn't hurt the new API pci_error_handlers.

> 
> ------
> It's not clear to me what hardware may show up in the future. 
> For example, someone may build a 32x PCI-E card that will act 
> as a bridge to a drawer with half-a-dozen ordinary PCI-X slots 
> in it. This is perhaps a bit hypothetical, but changing the API 
> will make it harder to implement eror recovery for such a system.
I agree that it's difficult to predict the future. At least the new API
could process the example.

> FWIW, there is at least one pSeries system in the lab which has
> several hundred PCI slots attached to it, although I've never 
> done testing on it. Hmm. Maybe its time I did ... 
> 
> --linas
