Return-Path: <linux-kernel-owner+w=401wt.eu-S1752011AbWLNG0Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752011AbWLNG0Z (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 01:26:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752016AbWLNG0Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 01:26:25 -0500
Received: from sj-iport-6.cisco.com ([171.71.176.117]:27505 "EHLO
	sj-iport-6.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752011AbWLNG0Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 01:26:24 -0500
X-Greylist: delayed 586 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Dec 2006 01:26:24 EST
X-IronPort-AV: i="4.12,165,1165219200"; 
   d="scan'208"; a="90522149:sNHT43342866"
To: Ben Collins <ben.collins@ubuntu.com>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.20-rc1] ib_verbs: Use explicit if-else statements to avoid errors with do-while macros
X-Message-Flag: Warning: May contain useful information
References: <1166065805.6748.135.camel@gullible>
From: Roland Dreier <rdreier@cisco.com>
Date: Wed, 13 Dec 2006 22:16:35 -0800
In-Reply-To: <1166065805.6748.135.camel@gullible> (Ben Collins's message of "Wed, 13 Dec 2006 22:10:05 -0500")
Message-ID: <adatzzzovcs.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.19 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 14 Dec 2006 06:16:36.0255 (UTC) FILETIME=[68AB62F0:01C71F47]
Authentication-Results: sj-dkim-1; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com/sjdkim1002 verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I see Linus already took this, which is fine... blame me for merging
this without fixing my cross-compile testbed.

Anyway:

 >  static inline int ib_dma_mapping_error(struct ib_device *dev, u64 dma_addr)
 >  {
 > -	return dev->dma_ops ?
 > -		dev->dma_ops->mapping_error(dev, dma_addr) :
 > -		dma_mapping_error(dma_addr);
 > +	if (dev->dma_ops)
 > +		return dev->dma_ops->mapping_error(dev, dma_addr);
 > +	return dma_mapping_error(dma_addr);

This stuff wasn't needed, was it?  It's only the wrappers around void
functions that can't use ?: I would think... surely any trivial macro
replacement for a dma API function that returns a value must evaluate
to something like (0) that is safe to use in this context.

 - R.
