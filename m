Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264389AbUFKXEy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264389AbUFKXEy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 19:04:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264391AbUFKXEy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 19:04:54 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:25748 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264389AbUFKXEw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 19:04:52 -0400
Date: Fri, 11 Jun 2004 16:03:25 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@osdl.org>, David Howells <dhowells@redhat.com>
cc: torvalds@osdl.org, linux-kernel@vger.kernel.org,
       Andy Whitcroft <apw@shadowen.org>
Subject: Re: [PATCH] Permit inode & dentry hash tables to be allocated > MAX_ORDER size
Message-ID: <3066250000.1086995005@flay>
In-Reply-To: <20040611150419.11281555.akpm@osdl.org>
References: <20040611034809.41dc9205.akpm@osdl.org><567.1086950642@redhat.com><1056.1086952350@redhat.com> <20040611150419.11281555.akpm@osdl.org>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>  (2) Changing MAX_ORDER appears to have a number of effects beyond just
>>      limiting the maximum size that can be allocated in one go.
> 
> Several architectures implement CONFIG_FORCE_MAX_ZONEORDER and I haven't
> heard of larger MAX_ORDERs causing problems.
> 
> Certainly, increasing MAX_ORDER is the simplest solution to the problems
> which you identify so we need to substantiate these "number of effects"
> much more than this please.

We've hit a problem with alignment issues where the start of the zone is
aligned to 16MB, for instance, and the max grouping is now 256MB. That
generatates a "warning: wrong zone alignment: it will crash" error (or
something similar). Andy sent me a patch this morning to throw away
the lower section, which is much nicer than crashing ... but I'd prefer
not to throw that RAM away unless we have to. 

Allocating the big-assed hashes out of bootmem seems much cleaner to me,
at least ...

M.

