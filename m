Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262726AbUKERNp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262726AbUKERNp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 12:13:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262717AbUKERNp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 12:13:45 -0500
Received: from mail01.hpce.nec.com ([193.141.139.228]:53144 "EHLO
	mail01.hpce.nec.com") by vger.kernel.org with ESMTP id S262693AbUKERNc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 12:13:32 -0500
From: Erich Focht <efocht@hpce.nec.com>
To: Jack Steiner <steiner@sgi.com>
Subject: Re: Externalize SLIT table
Date: Fri, 5 Nov 2004 18:13:24 +0100
User-Agent: KMail/1.6.2
Cc: Takayoshi Kochi <t-kochi@bq.jp.nec.com>, ak@suse.de,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20041103205655.GA5084@sgi.com> <20041104.135721.08317994.t-kochi@bq.jp.nec.com> <20041105160808.GA26719@sgi.com>
In-Reply-To: <20041105160808.GA26719@sgi.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200411051813.24231.efocht@hpce.nec.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jack,

the patch looks fine, of course.
> 	# cat ./node/node0/distance
> 	10 20 64 42 42 22
Great!

But:
> 	# cat ./cpu/cpu8/distance
> 	42 42 64 64 22 22 42 42 10 10 20 20
...

what exactly do you mean by cpu_to_cpu distance? In analogy with the
node distance I'd say it is the time (latency) for moving data from
the register of one CPU into the register of another CPU:
        cpu*/distance :   cpu -> memory -> cpu
                         node1   node?    node2

On most architectures this means flushing a cacheline to memory on one
side and reading it on another side. What you actually implement is
the latency from memory (one node) to a particular cpu (on some
node). 
                       memory ->  cpu
                       node1     node2

That's only half of the story and actually misleading. I don't
think the complexity hiding is good in this place. Questions coming to
my mind are: Where is the memory? Is the SLIT matrix really symmetric
(cpu_to_cpu distance only makes sense for symmetric matrices)? I
remember talking to IBM people about hardware where the node distance
matrix was asymmetric.

Why do you want this distance anyway? libnuma offers you _node_ masks
for allocating memory from a particular node. And when you want to
arrange a complex MPI process structure you'll have to think about
latency for moving data from one processes buffer to the other
processes buffer. The buffers live on nodes, not on cpus.

Regards,
Erich

