Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261799AbUA0Eig (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 23:38:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261812AbUA0Eig
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 23:38:36 -0500
Received: from obsidian.spiritone.com ([216.99.193.137]:46292 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S261799AbUA0Eie (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 23:38:34 -0500
Date: Mon, 26 Jan 2004 20:38:05 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Rusty Russell <rusty@rustcorp.com.au>
cc: Nick Piggin <piggin@cyberone.com.au>, linux-kernel@vger.kernel.org
Subject: Re: New NUMA scheduler and hotplug CPU 
Message-ID: <356230000.1075178284@[10.10.2.4]>
In-Reply-To: <20040127024049.7B90B2C13D@lists.samba.org>
References: <20040127024049.7B90B2C13D@lists.samba.org>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> No, actually, it wouldn't.  Take it from someone who has actually
> looked at the code with an eye to doing this.
> 
> Replacing static structures by dynamic ones for an architecture which
> doesn't yet exist is NOT a good idea.

Trying to force a dynamic infrastructure into the static bitmap arrays
that we have is the bad idea, IMHO. Why on earth would you want offline
CPUs in the scheduler domains? Just to make your coding easier? Sorry,
but that just doesn't cut it for me.
 
> Sure, if they were stupid they'd do it this way.
> 
> If (when) an architecture has hotpluggable CPUs and NUMA
> characteristics, they probably will have fixed CPU *slots*, and number
> CPUs based on what slot they are in.  Since the slots don't move, all
> your fancy dynamic logic will be wasted.
> 
> When someone really has dynamic hotplug CPU capability with variable
> attributes, *they* can code up the dynamic hierarchy.  Because *they*
> can actually test it!

The cpu numbers are now dynamically allocated tags. I don't see why
we should sacrifice that just to get cpu hotplug. Sure, it makes your
coding a little harder, but ....

>> Yup ... but you don't have to enumerate all possible positions that way.
>> See Linus' arguement re dynamic device numbers and ISCSI disks, etc.
>> Same thing applies.
> 
> Crap.  When all the fixed per-cpu arrays have been removed from the
> kernel, come back and talk about instantiation and location of
> arbitrary CPUS.
> 
> You're way overdesigning: have you been sharing food with the AIX guys?

A cheap shot. Please, I'd expect better flaming from you.

Sorry if this makes your coding harder, but it seems clear to me that
it's the right way to go. I guess the final decision is up to Andrew,
but I really don't want to see this kind of stuff. You don't start 
kthreads for every possible cpu, do you?

M.

