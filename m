Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262227AbUKDOTi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262227AbUKDOTi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 09:19:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262231AbUKDOTh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 09:19:37 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:9687 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S262229AbUKDONs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 09:13:48 -0500
Date: Thu, 4 Nov 2004 08:13:37 -0600
From: Jack Steiner <steiner@sgi.com>
To: Takayoshi Kochi <t-kochi@bq.jp.nec.com>
Cc: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Externalize SLIT table
Message-ID: <20041104141337.GA18445@sgi.com>
References: <20041103205655.GA5084@sgi.com> <20041104.105908.18574694.t-kochi@bq.jp.nec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041104.105908.18574694.t-kochi@bq.jp.nec.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 04, 2004 at 10:59:08AM +0900, Takayoshi Kochi wrote:
> Hi,
> 
> For wider audience, added LKML.
> 
> From: Jack Steiner <steiner@sgi.com>
> Subject: Externalize SLIT table
> Date: Wed, 3 Nov 2004 14:56:56 -0600
> 
> > The SLIT table provides useful information on internode
> > distances. Has anyone considered externalizing this
> > table via /proc or some equivalent mechanism.
> > 
> > For example, something like the following would be useful:
> > 
> > 	# cat /proc/acpi/slit
> > 	010 066 046 066
> > 	066 010 066 046
> > 	046 066 010 020
> > 	066 046 020 010
> > 
> > If this looks ok (or something equivalent), I'll generate a patch....
> 
> For user space to manipulate scheduling domains, pinning processes
> to some cpu groups etc, that kind of information is very useful!
> Without this, users have no notion about how far between two nodes.
> 
> But ACPI SLIT table is too arch specific (ia64 and x86 only) and
> user-visible logical number and ACPI proximity domain number is
> not always identical.
> 
> Why not export node_distance() under sysfs?
> I like (1).
> 
> (1) obey one-value-per-file sysfs principle
> 
> % cat /sys/devices/system/node/node0/distance0
> 10
> % cat /sys/devices/system/node/node0/distance1
> 66

I'm not familar with the internals of sysfs. For example, on a 256 node
system, there will be 65536 instances of
	 /sys/devices/system/node/node<M>/distance<N>

Does this require any significant amount of kernel resources to
maintain this amount of information.




> 
> (2) one distance for each line
> 
> % cat /sys/devices/system/node/node0/distance
> 0:10
> 1:66
> 2:46
> 3:66
> 
> (3) all distances in one line like /proc/<PID>/stat
> 
> % cat /sys/devices/system/node/node0/distance
> 10 66 46 66
> 


I like (3) the best.

I think it would also be useful to have a similar cpu-to-cpu distance
metric:
	% cat /sys/devices/system/cpu/cpu0/distance
	10 20 40 60 

This gives the same information but is cpu-centric rather than
node centric.



-- 
Thanks

Jack Steiner (steiner@sgi.com)          651-683-5302
Principal Engineer                      SGI - Silicon Graphics, Inc.


