Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261636AbVBSFvy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261636AbVBSFvy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Feb 2005 00:51:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261637AbVBSFvy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Feb 2005 00:51:54 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:34466 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261636AbVBSFvw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Feb 2005 00:51:52 -0500
Subject: Re: [RFC][PATCH] Dynamically allocated pageflags.
From: Dave Hansen <haveblue@us.ibm.com>
To: ncunningham@cyclades.com
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@ucw.cz>
In-Reply-To: <1108784122.4077.123.camel@desktop.cunningham.myip.net.au>
References: <1108780994.4077.63.camel@desktop.cunningham.myip.net.au>
	 <1108782127.19253.4.camel@localhost>
	 <1108784122.4077.123.camel@desktop.cunningham.myip.net.au>
Content-Type: text/plain
Date: Fri, 18 Feb 2005 21:51:43 -0800
Message-Id: <1108792304.19253.12.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-02-19 at 14:35 +1100, Nigel Cunningham wrote:
> On Sat, 2005-02-19 at 14:02, Dave Hansen wrote:
> > One issue is that it doesn't work with DISCONTIGMEM (or the upcoming
> > sparsemem).  max_mapnr doesn't exist on those systems, and on the really
> > discontiguous ones, you might be allocating very large areas with very
> > sparse maps.
> 
> :> Am I right in thinking that just requires something similar, done
> per-zone? If that's the case, I'll happily modify the code to suit. I
> should support discontig anyway in suspend.

The mem_maps are per-pgdat or per-node with discontig, but I have a
patch in the pipeline to take them out of there and make one for every
128MB or 256MB, etc... area of memory (for memory hotplug).  So, hanging
them off the pgdat or zone won't even work in that case, because even
the struct zone can have pretty sparse memory inside of it.  I *think*
the table is the only way to go.  But, that can wait until Monday. :)

-- Dave

