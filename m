Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265988AbUAEWkI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 17:40:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265987AbUAEWi4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 17:38:56 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:40628 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265849AbUAEWh0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 17:37:26 -0500
Message-ID: <3FF9E5DB.6020604@us.ibm.com>
Date: Mon, 05 Jan 2004 14:31:55 -0800
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
Organization: IBM LTC
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jesse Barnes <jbarnes@sgi.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       mbligh@aracnet.com
Subject: Re: [PATCH] Simplify node/zone field in page->flags
References: <3FE74B43.7010407@us.ibm.com> <20031222131126.66bef9a2.akpm@osdl.org> <3FF9D5B1.3080609@us.ibm.com> <20040105213736.GA19859@sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse Barnes wrote:
> On Mon, Jan 05, 2004 at 01:22:57PM -0800, Matthew Dobson wrote:
> 
>>Jesse had acked the patch in an earlier itteration.  The only thing 
>>that's changed is some line offsets whilst porting the patch forward.
>>
>>Jesse (or anyone else?), any objections to this patch as a superset of 
>>yours?
> 
> 
> No objections here.  Of course, you'll have to rediff against the
> current tree since that stuff has been merged for awhile now.  On a
> somewhat related note, Martin mentioned that he'd like to get rid of
> memblks.  I'm all for that too; they just seem to get in the way.
> 
> Jesse

Here's an updated version against 2.6.1-rc1.  Small comment fix (there 
are actually up to (MAX_NUMNODES * MAX_NR_ZONES) possible zones total, 
not log2(MAX_NUMNODES * MAX_NR_ZONES) as your comment stated.  That is 
the number of bits necessary to index every possible zone.

After this goes in, we (I) can convert a number of places that are doing 
several pointer dereferences/arithmetic and other things to determine 
which node/zone a page belongs to simply calling 
page_nodenum()/page_zonenum().

Cheers!

-Matt

