Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264388AbUFKXQq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264388AbUFKXQq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 19:16:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264391AbUFKXQq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 19:16:46 -0400
Received: from fw.osdl.org ([65.172.181.6]:43736 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264388AbUFKXQp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 19:16:45 -0400
Date: Fri, 11 Jun 2004 16:19:20 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: dhowells@redhat.com, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       apw@shadowen.org
Subject: Re: [PATCH] Permit inode & dentry hash tables to be allocated >
 MAX_ORDER size
Message-Id: <20040611161920.0a40e49d.akpm@osdl.org>
In-Reply-To: <3066250000.1086995005@flay>
References: <20040611034809.41dc9205.akpm@osdl.org>
	<567.1086950642@redhat.com>
	<1056.1086952350@redhat.com>
	<20040611150419.11281555.akpm@osdl.org>
	<3066250000.1086995005@flay>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <mbligh@aracnet.com> wrote:
>
> We've hit a problem with alignment issues where the start of the zone is
> aligned to 16MB, for instance, and the max grouping is now 256MB. That
> generatates a "warning: wrong zone alignment: it will crash" error (or
> something similar). Andy sent me a patch this morning to throw away
> the lower section, which is much nicer than crashing ... but I'd prefer
> not to throw that RAM away unless we have to. 

Confused.  Why do we have that test in there at all?  We should just toss
the pages one at a time into the buddy list and let the normal coalescing
work it out.  That way we'd end up with a single 16MB "page" followed by N
256MB "pages".

> Allocating the big-assed hashes out of bootmem seems much cleaner to me,
> at least ...

Maybe.  That code seems fragile and I have premonitions of unhappy arch
maintainers.
