Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262007AbUCIQdH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 11:33:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262045AbUCIQdH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 11:33:07 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:59148
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262007AbUCIQdE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 11:33:04 -0500
Date: Tue, 9 Mar 2004 17:33:45 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Arjan van de Ven <arjanv@redhat.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: objrmap-core-1 (rmap removal for file mappings to avoid 4:4 in <=16G machines)
Message-ID: <20040309163345.GK8193@dualathlon.random>
References: <20040308202433.GA12612@dualathlon.random> <1078781318.4678.9.camel@laptop.fenrus.com> <20040308230845.GD12612@dualathlon.random> <20040309074747.GA8021@elte.hu> <20040309152121.GD8193@dualathlon.random> <20040309153620.GA9012@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040309153620.GA9012@elte.hu>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 09, 2004 at 04:36:20PM +0100, Ingo Molnar wrote:
> 
> * Andrea Arcangeli <andrea@suse.de> wrote:
> 
> > http://www.oracle.com/apps_benchmark/html/index.html?0325B_Report1.html
> 
> OASB is special and pushes the DB less than e.g. TPC-C does. How big was
> the SGA? I bet the setup didnt have use_indirect_data_buffers=true. 

I don't know the answer of this, but it was the usual top configuration
with very large memory model, I'm not aware of a superior config on x86
and this triggered bugs for the first time ever which could mean we were
the first ever pushing the db that far.

> (OASB is not a full-disclosure benchmark so i have no way to check
> this.) All you have proven is that workloads with a limited number of
> per-inode vmas can perform well. Which completely ignores my point.

what is your point, that OASB is a worthless workload and the only thing
that matters is TPC-C? Maybe you should discuss your point with Oracle
not with me, since I don't know what the two benchmarks are doing
differently. TCP-C was tested too of course, but maybe not in 32G boxes,
frankly I thought OASB was harder than TCP-C, as I think Martin
mentioned too two days ago.

about the limited number of vmas per inode, that's not the case, there
were tons of vmas allocated at least a 512m SGA window per 7.5k tasks,
infact without the vma-file-merging there's no way to make that work.
But the number of vmas isn't relevant with 2.6 and remap_file_pages, so
whatever your point is, I don't see it.
