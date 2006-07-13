Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751486AbWGMQCw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751486AbWGMQCw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 12:02:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751053AbWGMQCw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 12:02:52 -0400
Received: from sj-iport-5.cisco.com ([171.68.10.87]:31763 "EHLO
	sj-iport-5.cisco.com") by vger.kernel.org with ESMTP
	id S1751491AbWGMQCv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 12:02:51 -0400
X-IronPort-AV: i="4.06,238,1149490800"; 
   d="scan'208"; a="305539482:sNHT25129556"
To: David Miller <davem@davemloft.net>
Cc: ralphc@pathscale.com, rolandd@cisco.com, openib-general@openib.org,
       linux-kernel@vger.kernel.org
Subject: Re: Suggestions for how to remove bus_to_virt()
X-Message-Flag: Warning: May contain useful information
References: <1152746967.4572.263.camel@brick.pathscale.com>
	<adar70quzwx.fsf@cisco.com>
	<20060712.174013.95062313.davem@davemloft.net>
From: Roland Dreier <rdreier@cisco.com>
Date: Thu, 13 Jul 2006 09:02:47 -0700
Message-ID: <adaodvttrvc.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 13 Jul 2006 16:02:49.0869 (UTC) FILETIME=[CA2973D0:01C6A695]
Authentication-Results: sj-dkim-7.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > > A cleaner solution would be to make the dma_ API really use the device
 > > it's passed anyway, and allow drivers to override the standard PCI
 > > stuff nicely.  But that would be major surgery, I guess.

 > Clean but expensive, you should not force the rest of the kernel
 > to eat the cost of something you want to do when it's totally
 > unnecessary for most other users.

OK, fair enough.

 > For example, x86 never needs to do anything other than a direct
 > virt_to_phys translation to produce a DMA address, no matter what
 > bus the device is on.  It's a single simple integer adjustment
 > that can be done inline in about 2 or 3 instructions at most.

<pedantic>Except x86 needs to handle systems with IOMMUs now...</pedantic>

 > If you need device level DMA mapping semantics, create them for your
 > device type.  This is what USB does, btw.

Makes sense -- Ralph, I would suggest looking at USB as a model.

 - R.
