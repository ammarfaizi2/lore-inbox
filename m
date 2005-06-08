Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261189AbVFHNSm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261189AbVFHNSm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 09:18:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261202AbVFHNSm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 09:18:42 -0400
Received: from mx1.suse.de ([195.135.220.2]:12492 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261189AbVFHNSk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 09:18:40 -0400
Date: Wed, 8 Jun 2005 15:18:39 +0200
From: Andi Kleen <ak@suse.de>
To: christoph <christoph@scalex86.org>
Cc: ak@suse.de, linux-kernel@vger.kernel.org, shai@scalex86.org
Subject: Re: [PATCH] Move some variables into the "most_readonly" section??
Message-ID: <20050608131839.GP23831@wotan.suse.de>
References: <Pine.LNX.4.62.0506071253020.2850@ScMPusgw>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0506071253020.2850@ScMPusgw>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 07, 2005 at 12:58:38PM -0700, christoph wrote:
> These variables cause false sharing in some circumstances. However, they 
> are just small pointers and 4 byte ints. So this patch would result in 
> some wastage of memory since each of those pointers then would occupy a 
> whole cache line.
> 
> Do we have any provisions for this situation? Or do we need a new section 
> for mostly_readonly?


You lost me  - when the variable is in the mostly readonly section then
there should not be any false sharing because all the data on these
cache lines should be always in SHARED state. And there is no wasted
memory because the variables can be packed tightly there.

However this means __cacheline_aligned_mostly_readonly doesnt make much
sense since there is no need for alignment in read only. How about
replacing it with a __mostly_readonly that doesnt align and remove
__cacheline_aligned_mostly_readonly? 

-Andi
