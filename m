Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750825AbWBFJKo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750825AbWBFJKo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 04:10:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750826AbWBFJKn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 04:10:43 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:38296 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750825AbWBFJKm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 04:10:42 -0500
Date: Mon, 6 Feb 2006 10:09:27 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Paul Jackson <pj@sgi.com>
Cc: akpm@osdl.org, dgc@sgi.com, steiner@sgi.com, Simon.Derr@bull.net,
       ak@suse.de, linux-kernel@vger.kernel.org, clameter@sgi.com
Subject: Re: [PATCH 1/5] cpuset memory spread basic implementation
Message-ID: <20060206090927.GA11933@elte.hu>
References: <20060205203358.1fdcea43.akpm@osdl.org> <20060205215052.c5ab1651.pj@sgi.com> <20060205220204.194ba477.akpm@osdl.org> <20060206061743.GA14679@elte.hu> <20060205232253.ddbf02d7.pj@sgi.com> <20060206074334.GA28035@elte.hu> <20060206001959.394b33bc.pj@sgi.com> <20060206082258.GA1991@elte.hu> <20060206084001.GA5600@elte.hu> <20060206010304.e79ca2e5.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060206010304.e79ca2e5.pj@sgi.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.2
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.2 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.6 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Paul Jackson <pj@sgi.com> wrote:

> It's job specific, and cache specific.
> 
> If the job has a number of threads hitting the same data set and:
>  1) the data set is faulted in non-uniformly (perhaps some
>     job init task reads it in), and
>  2) the data set is accessed with little thread locality
>     (one thread is as likely as the next to read or write
>     a particular page),
> then for that job spreading makes sense.
> 
> If the cache is one that goes with a data set, such as file system 
> buffers (page cache) and inode and dentry slab caches, then for that 
> cache spreading makes sense.  (Yes Andrew, your xfs query is still in 
> my queue.)
> 
> But for many (most?) other jobs and other caches, the default 
> node-local policy is better.

what type of objects need to be spread (currently)? It seems that your 
current focus is on filesystem related objects: pagecache, inodes, 
dentries - correct? Is there anything else that needs to be spread? In 
particular, does any userspace mapped memory need to be spread - or is 
it handled with other mechanisms?

	Ingo
