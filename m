Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261314AbUKBRF6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261314AbUKBRF6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 12:05:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261347AbUKBRBo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 12:01:44 -0500
Received: from jade.aracnet.com ([216.99.193.136]:6601 "EHLO
	jade.spiritone.com") by vger.kernel.org with ESMTP id S261293AbUKBQz2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 11:55:28 -0500
Date: Tue, 02 Nov 2004 08:55:15 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andi Kleen <ak@suse.de>
cc: Brent Casavant <bcasavan@sgi.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, hugh@veritas.com
Subject: Re: [PATCH] Use MPOL_INTERLEAVE for tmpfs files
Message-ID: <40740000.1099414515@[10.10.2.4]>
In-Reply-To: <20041102155507.GA323@wotan.suse.de>
References: <Pine.SGI.4.58.0411011901540.77038@kzerza.americas.sgi.com> <14340000.1099410418@[10.10.2.4]> <20041102155507.GA323@wotan.suse.de>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Andi Kleen <ak@suse.de> wrote (on Tuesday, November 02, 2004 16:55:07 +0100):

> On Tue, Nov 02, 2004 at 07:46:59AM -0800, Martin J. Bligh wrote:
>> > This patch causes memory allocation for tmpfs files to be distributed
>> > evenly across NUMA machines.  In most circumstances today, tmpfs files
>> > will be allocated on the same node as the task writing to the file.
>> > In many cases, particularly when large files are created, or a large
>> > number of files are created by a single task, this leads to a severe
>> > imbalance in free memory amongst nodes.  This patch corrects that
>> > situation.
>> 
>> Yeah, but it also ruins your locality of reference (in a NUMA sense). 
>> Not convinced that's a good idea. You're guaranteeing universally consistent
>> worse-case performance for everyone. And you're only looking at a situation
>> where there's one allocator on the system, and that's imbalanced.
>> 
>> You WANT your data to be local. That's the whole idea.
> 
> I think it depends on how you use tmpfs. When you use it for read/write
> it's a good idea because you likely don't care about a bit of additional
> latency and it's better to not fill up your local nodes with temporary
> files.
> 
> If you use it with mmap then you likely want local policy.
> 
> But that's a big ugly to distingush, that is why I suggested the sysctl.

As long as it defaults to off, I guess I don't really care. Though I'm still
wholly unconvinced it makes much sense. I think we're just papering over the
underlying problem - that we don't do good balancing between nodes under
mem pressure.

M.

