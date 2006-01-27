Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751233AbWA0AHU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751233AbWA0AHU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 19:07:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751296AbWA0AHU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 19:07:20 -0500
Received: from kanga.kvack.org ([66.96.29.28]:27303 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S1751233AbWA0AHT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 19:07:19 -0500
Date: Thu, 26 Jan 2006 19:03:04 -0500
From: Benjamin LaHaise <bcrl@kvack.org>
To: Matthew Dobson <colpatch@us.ibm.com>
Cc: Christoph Lameter <clameter@engr.sgi.com>, linux-kernel@vger.kernel.org,
       sri@us.ibm.com, andrea@suse.de, pavel@suse.cz, linux-mm@kvack.org
Subject: Re: [patch 0/9] Critical Mempools
Message-ID: <20060127000304.GG10409@kvack.org>
References: <1138217992.2092.0.camel@localhost.localdomain> <Pine.LNX.4.62.0601260954540.15128@schroedinger.engr.sgi.com> <43D954D8.2050305@us.ibm.com> <Pine.LNX.4.62.0601261516160.18716@schroedinger.engr.sgi.com> <43D95BFE.4010705@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43D95BFE.4010705@us.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2006 at 03:32:14PM -0800, Matthew Dobson wrote:
> > I thought the earlier __GFP_CRITICAL was a good idea.
> 
> Well, I certainly could have used that feedback a month ago! ;)  The
> general response to that patchset was overwhelmingly negative.  Yours is
> the first vote in favor of that approach, that I'm aware of.

Personally, I'm more in favour of a proper reservation system.  mempools 
are pretty inefficient.  Reservations have useful properties, too -- one 
could reserve memory for a critical process to use, but allow the system 
to use that memory for easy to reclaim caches or to help with memory 
defragmentation (more free pages really helps the buddy allocator).

> > Gfp flag? Better memory reclaim functionality?
> 
> Well, I've got patches that implement the GFP flag approach, but as I
> mentioned above, that was poorly received.  Better memory reclaim is a
> broad and general approach that I agree is useful, but will not necessarily
> solve the same set of problems (though it would likely lessen the severity
> somewhat).

Which areas are the priorities for getting this functionality into?  
Networking over particular sockets?  A GFP_ flag would plug into the current 
network stack trivially, as sockets already have a field to store the memory 
allocation flags.

		-ben
-- 
"Ladies and gentlemen, I'm sorry to interrupt, but the police are here 
and they've asked us to stop the party."  Don't Email: <dont@kvack.org>.
