Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964798AbWHRVVP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964798AbWHRVVP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 17:21:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964938AbWHRVVP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 17:21:15 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:40898 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S964798AbWHRVVO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 17:21:14 -0400
Date: Fri, 18 Aug 2006 14:19:45 -0700
From: Paul Jackson <pj@sgi.com>
To: "Chris Friesen" <cfriesen@nortel.com>
Cc: sekharan@us.ibm.com, riel@redhat.com, Linux@sc8-sf-spam2-b.sourceforge.net,
       ckrm-tech@lists.sourceforge.net, haveblue@us.ibm.com,
       linux-kernel@vger.kernel.org, dev@sw.ru, hch@infradead.org, saw@sw.ru,
       alan@lxorguk.ukuu.org.uk, rohitseth@google.com, hugh@veritas.com,
       Christoph@sc8-sf-spam2-b.sourceforge.net, xemul@openvz.org,
       mingo@elte.hu, devel@openvz.org, ak@suse.de
Subject: Re: [ckrm-tech] [PATCH 4/7] UBC: syscalls (user interface)
Message-Id: <20060818141945.bd6b3f5c.pj@sgi.com>
In-Reply-To: <44E61227.9020006@nortel.com>
References: <44E33893.6020700@sw.ru>
	<44E33C3F.3010509@sw.ru>
	<1155752277.22595.70.camel@galaxy.corp.google.com>
	<1155755069.24077.392.camel@localhost.localdomain>
	<1155756170.22595.109.camel@galaxy.corp.google.com>
	<44E45D6A.8000003@sw.ru>
	<20060817084033.f199d4c7.akpm@osdl.org>
	<20060818120809.B11407@castle.nmd.msu.ru>
	<1155912348.9274.83.camel@localhost.localdomain>
	<20060818094248.cdca152d.akpm@osdl.org>
	<1155925065.26155.17.camel@linuxchandra>
	<20060818115624.fd875624.pj@sgi.com>
	<44E61227.9020006@nortel.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris wrote:
> Hypothetically, if you can guarantee that those threads get a specified 
> amount of time, but may possibly get *more* cpu time and thus finish 
> faster, what's the problem?

Each thread is already getting ~100% of one dedicated CPU.  It can't
get any *more* than that ;).  256 active threads, 256 CPUs, *very*
tightly coupled, in this example, on say a 512 CPU system running
unrelated stuff on the other half.

If anything else interferes with the memory bandwidth of even one thread
to its node local memory, or takes any of that node local memory for
unrelated uses, it's a big problem.  A few percent variation in job
runtime, for a two day job, means hours difference in the finish time.
People notice, when that's your 'big money' app.

This is not your fathers PC ;).

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
