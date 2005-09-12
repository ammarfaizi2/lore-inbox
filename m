Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932282AbVILWBE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932282AbVILWBE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 18:01:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932283AbVILWBD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 18:01:03 -0400
Received: from graphe.net ([209.204.138.32]:47802 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S932282AbVILWBB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 18:01:01 -0400
Date: Mon, 12 Sep 2005 15:00:55 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: Fw: Re: NUMA mempolicy /proc code in mainline shouldn't have
 been merged
In-Reply-To: <20050912140546.3f925d1a.akpm@osdl.org>
Message-ID: <Pine.LNX.4.62.0509121433260.6325@graphe.net>
References: <20050912140546.3f925d1a.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry I am in Europe right now and do not have too much access to email.
But here a response since Andrew asked for it. There is nothing new here 
that was not discussed before.

On Mon, 12 Sep 2005, Andrew Morton wrote:

> > Certainly I can see value in that.  How can a developer test his
> > code without any form of runtime feedback?
> 
> There are already several ways to do that: first the counters output
> by numastat (local_node, other_node, interleave_hit etc.), which tells you 
> exactly how the allocation strategy ended up. And a process can find out
> on which node a specific page is using get_mempolicy()

The local_node etc counters are not process specific. The app developer 
still has to guess how much of that is used by which process. Moreover 
different memory areas of a process may have different allocation 
policies. These numbers will be conflated in the node specific statistics. 
Without the patch one is not able to see how the application 
sets up the memory policies and how pages are actually allocated.

> If you really want to know what's going on you can use performance counters
> of the machine to tell you the amount of cross node traffic
> (e.g. see numamon in the numactl source tree as an example) 

Performance counters to display memory allocation? May be we can get rid
of the node page allocation counters etc too. Just instrument the kernel 
correctly if one needs those number. We may have the final solution 
to our problems with the RSS counters =-)

But seriously how do you propose to use the performance counters to 
get the information on which node a process has allocated memory? Note not 
"cross node traffic". We need to know where the memory for various 
sections were allocated.
 
> I don't think the /proc information gives additional information
> to the programmers. Externally you shouldn't know about the 
> individual addresses anyways.

Addresses are already exposed by /proc/*/maps. There is nothing 
new there.

The /proc information gives the information about where the memory was 
allocated for the various memory sections of the process. This 
information is nowhere else available.

> All it does is to open the flood gates of external mempolicy management, 
> which is wrong.

Allowing the user to see where the application allocated memory is a 
necessary and helpful debugging tool. We are not discussing external 
mempolicy management here.

> > It's easy to parse and it is extensible.  It needs documenting though.
> 
> Extensible yes, but I have my doubts on easy to parse. User processes
> very likely will get it wrong like they traditionally did with anything
> more complicated in /proc. /proc/*/maps has been a similar disaster too.

/proc/*/maps is in wide use, there are tools to parse numa_stats and the 
output of numa_stats (like /proc/*/maps) is useful without parsing. We can 
go to the smaps format if people feel that this is important. But then I 
already said all of that in an earlier email.

