Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265290AbUEUBaH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265290AbUEUBaH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 May 2004 21:30:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265286AbUEUBaH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 May 2004 21:30:07 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:44019 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S265328AbUEUBaD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 May 2004 21:30:03 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: brettspamacct@fastclick.com
Subject: Re: How can I optimize a process on a NUMA architecture(x86-64 specifically)?
Date: Thu, 20 May 2004 21:29:59 -0400
User-Agent: KMail/1.6.2
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
References: <40AD52A4.3060607@fastclick.com>
In-Reply-To: <40AD52A4.3060607@fastclick.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200405202129.59704.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, May 20, 2004 8:51 pm, Brett E. wrote:
> Say you have a bunch of single-threaded processes on a NUMA machine.
> Does the kernel make sure to prefer allocations using a certain CPU's
> memory, preferring to run a given process on the CPU which contains its
> memory?  

Well, it'll allocate memory from the node containing the CPU that the process 
is running on, so if you've pinned your process (e.g. with schedutils) you'll 
be ok unless you're short on memory.  If it's not pinned, you'll run the risk 
of having your process refer to memory on a remote node.  Depending on what 
type of system you're running on, this could be a very small performance 
issue or a large one.

> Or should I use the NUMA API(libnuma) to spell this out to the 
> kernel? Does the kernel do the right thing in this case?

The kernel, by default, will allocate memory on the node where the process is 
running, and fall back to other nodes based on distance.  That said, it's not 
a bad idea to pin your process to a CPU and use libnuma to explicitly set 
it's memory affinity.

Jesse
