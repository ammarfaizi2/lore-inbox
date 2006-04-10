Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751021AbWDJRQC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751021AbWDJRQC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 13:16:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751223AbWDJRQC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 13:16:02 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:24463 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751021AbWDJRQA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 13:16:00 -0400
Message-ID: <443A929A.9040102@engr.sgi.com>
Date: Mon, 10 Apr 2006 10:15:06 -0700
From: Jay Lan <jlan@engr.sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040906
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Shailabh Nagar <nagar@watson.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, balbir@in.ibm.com, greg@kroah.com,
       arjan@infradead.org, hadi@cyberus.ca, ak@suse.de,
       linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net,
       erikj@sgi.com, lserinol@gmail.com, guillaume.thouvenin@bull.net,
       Dipankar Sarma <dipankar@in.ibm.com>,
       Peter Chubb <peterc@gelato.unsw.edu.au>, Jes Sorensen <jes@sgi.com>
Subject: Re: [Patch 0/8] per-task delay accounting
References: <442B271D.10208@watson.ibm.com>	<20060329210314.3db53aaa.akpm@osdl.org>	<20060330062357.GB18387@in.ibm.com> <20060329224737.071b9567.akpm@osdl.org> <442CCF54.3000501@watson.ibm.com> <442D8E39.8080606@engr.sgi.com> <442DED81.5060009@engr.sgi.com>
In-Reply-To: <442DED81.5060009@engr.sgi.com>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I made two feedback on 3/31 only to see them bounced
back over the weekend. :(

Here was my first feedback:

Shailabh Nagar wrote:
 >>
 >>Following Andrew's suggestion, here's my quick overview
 >>of the various other accounting packages that have been
 >>proposed on lse-tech with a focus on whether they can
 >>utilize the netlink-based taskstats interface being proposed
 >>by the delay accounting patches.
 >>
 >>Please note that unification of statistics *collection* is not
 >>being discussed since that kind of merger can be done as these
 >>patches get accepted, if at all, into the kernel. To try and
 >>unify right away would hold every patch (esp. delay accounting !)
 >>hostage to the problems in every other patch unnecessarily. As
 >>long as the interface can be unified, the merger of the
 >>collection bits can always happen without affecting user space.
 >>
 >>Stakeholders of each of these patches, on cc, are requested to
 >>please correct any misunderstandings of what their patches do.
 >
 >To me, data collection and formation before sending down to
 >userspace is very important part.  What this taskstats netlink
 >interface does is  just to provide an interface to send "already
 >formatted" data to userspace. In other words, it will replace
 >"writing accounting records to an accounting file" step currently
 >performed in BSD accouting and in CSA. If i understand it correctly,
 >you have delayacct.c sitting on top of taskstats interface, and
 >all other accounting methods should build their own layer on top
 >of taskstats as well. For example, potentially BSD acct.c can replace
 >fput() (and other statements dealing with acctounting file) with
 >this interface. Same for CSA.
 >
 >This approach sounds right to me. Actually i am very glad that you
 >made effort to provide a common ground here. Yet, this is only
 >one step. I will apply your patchset on top of 2.6.16-mm to see
 >what i get and give more feedback later.

And, here is the second one:

> 
> 
> This taskstats thing is much more complicated than what Guillaume
> used to have when he put up a prototype of doing ELSA over netlink.
> One confusing point is the struct taskstats. If it is to be used
> as the big data struct to contain all accounting data everybody
> needs (as Shailabh suggested on his CSA analysis section), then
> if at do_exit() every accounting methods are to be invoked to
> handle their netlink transmission (as currently implemented in
> delayed accounting), would it be a lot of overhead sending "grand
> data" too many times? Maybe each layer should just format data of
> their interest when invoked from do_exit, and then we do one call
> to genetlink to deliver formated struct taskstats data?
> 
> Also, as you pointed out, CSA only retrieve data at end of task
> but delayed accounting needs to retrieve data during the process.
> So, i think we need more than one record types, not just the
> struct taskstats, so that the user space delayed accounting 
> application can specify to get only delayed accounting record.
> 
> Honestly, this taskstats.c layer looks more like something
> extracted from delayed accounting than a carefully designed 
> common ground to me. Patch 8/8 is about documentation of delayed
> accounting than the common ground for various accounting methods.
> Can you please present us a documentation of design concept of
> such a common layer? That would help me. I guess i also need to 
> catch up on genetlink to better understand taskstats code.
> 
> Regards.
>  - jay
> 

Regards,
  - jay

