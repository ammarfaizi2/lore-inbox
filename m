Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753265AbWKGWcg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753265AbWKGWcg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 17:32:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753129AbWKGWcg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 17:32:36 -0500
Received: from mga01.intel.com ([192.55.52.88]:20413 "EHLO mga01.intel.com")
	by vger.kernel.org with ESMTP id S1753265AbWKGWcf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 17:32:35 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,398,1157353200"; 
   d="scan'208"; a="12915346:sNHT19044675"
Message-ID: <45510980.2040808@intel.com>
Date: Tue, 07 Nov 2006 14:32:32 -0800
From: Auke Kok <auke-jan.h.kok@intel.com>
User-Agent: Mail/News 1.5.0.7 (X11/20060918)
MIME-Version: 1.0
To: "Robin H. Johnson" <robbat2@gentoo.org>
CC: Auke Kok <auke-jan.h.kok@intel.com>, Pavel Machek <pavel@ucw.cz>,
       linux-kernel@vger.kernel.org
Subject: Re: e1000/ICH8LAN weirdness - no ethtool link until initially forced
 up
References: <20061106013153.GN15897@curie-int.orbis-terrarum.net> <20061107071449.GB21655@elf.ucw.cz> <4550AB7A.10508@intel.com> <20061107213138.GA16523@curie-int.orbis-terrarum.net>
In-Reply-To: <20061107213138.GA16523@curie-int.orbis-terrarum.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Nov 2006 22:32:34.0285 (UTC) FILETIME=[9EB0E9D0:01C702BC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robin H. Johnson wrote:
> On Tue, Nov 07, 2006 at 07:51:22AM -0800, Auke Kok wrote:
>>> I think you should cc e1000 maintainers, and perhaps provide a patch....
>> I've read it and not come up with an answer due to some other issues at 
>> hand. E1000 hardware works differently and this has been asked before, but 
>> the cards itself are in low power state when down. Changing this to bring 
>> up the link would make the card start to consume lots more power, which 
>> would automatically suck enormously for anyone using a laptop.
>>
>> Unfortunately, we have no way to distinguish directly between mobile and 
>> non-mobile adapters, since they are usually the same.
>>
>> Your application should really `ifconfig up` the device before checking for 
>> link.
> Actually pushing the link up in userspace doesn't specifically help my
> applications, as I care about actual link status (as reported by
> ethtool).

technically the link is already up if the cable is inserted and connected. doing an 
`ifconfig up` doesn't change that. If the link is down then this powers up the PHY so we 
can read the link status.

> Is there no way to keep the link status correct (within 0.5 seconds),
> without bringing the card to full power? Maybe a timer that fires a
> proper check (with the power implications).

no, not that I know of.

> Would a patch that adds a modparam (not enabled by default) running the
> behavior I'm after, be acceptable, so the e1000 driver can act identical
> to all of the other drivers?

I bet that all drivers work fine if you `ifconfig up` them. What happens if other NIC 
drivers implement similar powersaving methods and start working the same?

Cheers,

Auke

