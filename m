Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264396AbUFKXUL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264396AbUFKXUL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 19:20:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264397AbUFKXUL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 19:20:11 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:27312 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264396AbUFKXUG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 19:20:06 -0400
Date: Fri, 11 Jun 2004 16:18:48 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@osdl.org>
cc: dhowells@redhat.com, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       apw@shadowen.org
Subject: Re: [PATCH] Permit inode & dentry hash tables to be allocated > MAX_ORDER size
Message-ID: <3067490000.1086995928@flay>
In-Reply-To: <20040611161920.0a40e49d.akpm@osdl.org>
References: <20040611034809.41dc9205.akpm@osdl.org><567.1086950642@redhat.com><1056.1086952350@redhat.com><20040611150419.11281555.akpm@osdl.org><3066250000.1086995005@flay> <20040611161920.0a40e49d.akpm@osdl.org>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On Friday, June 11, 2004 16:19:20 -0700 Andrew Morton <akpm@osdl.org> wrote:

> "Martin J. Bligh" <mbligh@aracnet.com> wrote:
>> 
>> We've hit a problem with alignment issues where the start of the zone is
>> aligned to 16MB, for instance, and the max grouping is now 256MB. That
>> generatates a "warning: wrong zone alignment: it will crash" error (or
>> something similar). Andy sent me a patch this morning to throw away
>> the lower section, which is much nicer than crashing ... but I'd prefer
>> not to throw that RAM away unless we have to. 
> 
> Confused.  Why do we have that test in there at all?  We should just toss
> the pages one at a time into the buddy list and let the normal coalescing
> work it out.  That way we'd end up with a single 16MB "page" followed by N
> 256MB "pages".

That's what I thought ... Andy looked at it more than I did, but I think
he's asleep, unfortunately. IIRC, he said the buddy stuff keys off 
zone_start_pfn though. Maybe that's fixable ...

M.

