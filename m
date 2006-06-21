Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751501AbWFUWcd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751501AbWFUWcd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 18:32:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751498AbWFUWcd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 18:32:33 -0400
Received: from mx1.suse.de ([195.135.220.2]:27338 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751501AbWFUWcc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 18:32:32 -0400
From: Andi Kleen <ak@suse.de>
To: Rajesh Shah <rajesh.shah@intel.com>
Subject: Re: [RFC] PCI extended conf space when MMCONFIG disabled because of e820
Date: Thu, 22 Jun 2006 00:32:19 +0200
User-Agent: KMail/1.9.3
Cc: Arjan van de Ven <arjan@linux.intel.com>, Brice Goglin <brice@myri.com>,
       LKML <linux-kernel@vger.kernel.org>
References: <44907A8E.1080308@myri.com> <4491029D.4060002@linux.intel.com> <20060621151942.A17228@unix-os.sc.intel.com>
In-Reply-To: <20060621151942.A17228@unix-os.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606220032.19388.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 22 June 2006 00:19, Rajesh Shah wrote:
> On Wed, Jun 14, 2006 at 11:47:57PM -0700, Arjan van de Ven wrote:
> > 
> > > We need to improve this "mmconfig disabled" anyhow. Having the extended
> > > config space unavailable on lots of machines is also far from a viable
> > > solution :)
> > 
> > it's unlikely to be many machines though.
> > 
> I just noticed today - this check killed PCI Express on 3 of the 4
> machines I normally use for testing.

What do you mean with killed PCI Express? PCI Express should
work even without extended config space, except error handling.

Error handling seems to be still a quite obscure feature,
not used by many people - so booting is more important than
supporting it. Still would be good to support it of course.

You're saying that you have lots of machines where the mmconfig
aperture is not fully reserved in e820?

Is it partially reserved (not for all busses) or not at all?


> Sure enough, the ACPI namespace for the "broken" machines lists
> the MMCFG resources as indicated above, and PCI Express works fine
> otherwise. I haven't looked yet whether it's possible to add this
> check in the code, have you looked into that option? I understand
> the PCI firmware spec is not necessarily the final authority on
> this, but a _lot_ of BIOS developers read that to figure out what
> to do...

If someone does a patch to double check it against the ACPI name space
I'm not opposed to let it overrule the e820 heuristic.

The point of this code is to pragmatically detect BIOS with obviously 
broken setups. It's not about standards lawyering.

-Andi
 
