Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751319AbWEIQ15@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751319AbWEIQ15 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 12:27:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751321AbWEIQ15
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 12:27:57 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:65444 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751319AbWEIQ14
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 12:27:56 -0400
Subject: Re: [PATCH] SPARSEMEM + NUMA can't handle unaligned memory regions?
From: Dave Hansen <haveblue@us.ibm.com>
To: Andy Whitcroft <apw@shadowen.org>
Cc: Michael Ellerman <michael@ellerman.id.au>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, kravetz@us.ibm.com
In-Reply-To: <4460A6F3.5060303@shadowen.org>
References: <20060509070343.57853679F2@ozlabs.org>
	 <44609A7B.7010103@shadowen.org>  <4460A6F3.5060303@shadowen.org>
Content-Type: text/plain
Date: Tue, 09 May 2006 09:26:46 -0700
Message-Id: <1147192006.23893.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-05-09 at 15:28 +0100, Andy Whitcroft wrote:		
> +/*
> + * During early boot we need to record the nid from which we will
> + * later allocate the section mem_map.  Encode this into the section
> + * pointer.  Overload the section_mem_map with this information.
> + */ 

Andy, this all looks pretty good.  Although, it might be nice to
document this a bit more. 

First, can you update the mem_section definition comment?  It has a nice
explanation of how we use section_mem_map, and it would be a shame to
miss this use.

Also, your comment says when we _record_ the nid information, but not
that it is only _used_ during early boot.  I think this is what Mike K.
missed, and it might be good to clarify.

How about something like this:

/*
 * During early boot, before section_mem_map is used for an actual
 * mem_map, we use section_mem_map to store the section's NUMA
 * node.  This keeps us from having to use another data structure.  The
 * node information is cleared just before we store the real mem_map.
 */

-- Dave

