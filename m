Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262255AbUKDPds@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262255AbUKDPds (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 10:33:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262269AbUKDPdr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 10:33:47 -0500
Received: from mail01.hpce.nec.com ([193.141.139.228]:61673 "EHLO
	mail01.hpce.nec.com") by vger.kernel.org with ESMTP id S262263AbUKDPbw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 10:31:52 -0500
From: Erich Focht <efocht@hpce.nec.com>
To: Jack Steiner <steiner@sgi.com>
Subject: Re: Externalize SLIT table
Date: Thu, 4 Nov 2004 16:31:42 +0100
User-Agent: KMail/1.6.2
Cc: Takayoshi Kochi <t-kochi@bq.jp.nec.com>, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
References: <20041103205655.GA5084@sgi.com> <20041104.105908.18574694.t-kochi@bq.jp.nec.com> <20041104141337.GA18445@sgi.com>
In-Reply-To: <20041104141337.GA18445@sgi.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200411041631.42627.efocht@hpce.nec.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 04 November 2004 15:13, Jack Steiner wrote:
> I think it would also be useful to have a similar cpu-to-cpu distance
> metric:
>         % cat /sys/devices/system/cpu/cpu0/distance
>         10 20 40 60 
> 
> This gives the same information but is cpu-centric rather than
> node centric.

I don't see the use of that once you have some way to find the logical
CPU to node number mapping. The "node distances" are meant to be
proportional to the memory access latency ratios (20 means 2 times
larger than local (intra-node) access, which is by definition 10). 
If the cpu_to_cpu distance is necessary because there is a hierarchy
in the memory blocks inside one node, then maybe the definition of a
node should be changed...

We currently have (at least in -mm kernels):
       % ls /sys/devices/system/node/node0/cpu*
for finding out which CPUs belong to which nodes. Together with
       /sys/devices/system/node/node0/distances
this should be enough for user space NUMA tools.

Regards,
Erich

