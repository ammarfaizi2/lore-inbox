Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265366AbUATCcR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 21:32:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264540AbUATC2z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 21:28:55 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:36560 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id S265338AbUATCZ3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 21:25:29 -0500
Date: Mon, 19 Jan 2004 18:24:52 -0800
To: Jack Steiner <steiner@sgi.com>
Cc: mbligh@aracnet.com, jes@trained-monkey.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] increse MAX_NR_MEMBLKS to same as MAX_NUMNODES on NUMA
Message-ID: <20040120022452.GA27294@sgi.com>
Mail-Followup-To: Jack Steiner <steiner@sgi.com>, mbligh@aracnet.com,
	jes@trained-monkey.org, linux-kernel@vger.kernel.org
References: <E1AiZ5h-00043I-00@jaguar.mkp.net> <4990000.1074542883@[10.10.2.4]> <20040119224535.GA12728@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040119224535.GA12728@sgi.com>
User-Agent: Mutt/1.5.4i
From: jbarnes@sgi.com (Jesse Barnes)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 19, 2004 at 04:45:35PM -0600, Jack Steiner wrote:
> On Mon, Jan 19, 2004 at 12:08:04PM -0800, Martin J. Bligh wrote:
> > > Since we now support # of CPUs > BITS_PER_LONG with cpumask_t it would
> > > be nice to be able to support more than BITS_PER_LONG memory blocks.
> > 
> > Nothing uses them. We're probably better off just removing them altogether.
> 
> I dont understand.
> node_memblk[] is used on IA64 in arch/ia64/mm/discontig.c (& other places too).

I think Martin is referring to the memblk_*line() functions and the fact
that memblks are exported via sysfs to userspace.  That API hasn't
proven very useful so far since it's really waiting for memory hot
add/remove.  Of course, we'll still need structures to support that for
the low level arch specific discontig code, so any patch that killed
memblks in sysfs and elsewhere would have to take that into account...
(In particular, node_memblk[] is filled out by the ACPI SRAT parsing
code and use for discontig init and physical->node id conversion.)

Jesse
