Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751451AbWFUJvS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751451AbWFUJvS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 05:51:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751454AbWFUJvS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 05:51:18 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:15753 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751451AbWFUJvR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 05:51:17 -0400
Message-ID: <4499167D.1040308@sgi.com>
Date: Wed, 21 Jun 2006 11:50:53 +0200
From: Jes Sorensen <jes@sgi.com>
User-Agent: Thunderbird 1.5 (X11/20060317)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Robin Holt <holt@sgi.com>, linux-kernel@vger.kernel.org,
       Nick Piggin <nickpiggin@yahoo.com.au>, Hugh Dickins <hugh@veritas.com>,
       Carsten Otte <cotte@de.ibm.com>, bjorn_helgaas@hp.com
Subject: Re: [patch] do_no_pfn
References: <yq0psh5zenq.fsf@jaguar.mkp.net> <200606201048.10545.ak@suse.de> <4497BBFE.6000703@sgi.com> <200606201135.53824.ak@suse.de>
In-Reply-To: <200606201135.53824.ak@suse.de>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
>> One struct page for a random single page here, another for a single
>> random page there. And the risk that someone will start walking the
>> pages and dereference and cause data corruption. As explained before,
>> it's a bad idea.
> 
> Note sure what your point is. Why should they cause memory corruption?
> 
> Allowing struct page less VM is worse. If you add that then people
> will use it for other stuff, and eventually we got a two class
> VM. All not very good.

Special treatment of the pages are required. In particular they *must*
be referenced in uncached mode. If something derefences the struct page
in cached mode and the official user of the page does it correctly in
uncached mode one risks memory corruption. It's worse than that in fact
it has to be a full granule of pages that isn't touched like this.

But as Robin pointed out, there just is no real benefit to having a
struct page behind it.

Cheers,
Jes
