Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269636AbUHZU7K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269636AbUHZU7K (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 16:59:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269631AbUHZU4L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 16:56:11 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:60838 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S269567AbUHZUtE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 16:49:04 -0400
Message-ID: <412E4C27.1010805@engr.sgi.com>
Date: Thu, 26 Aug 2004 13:46:31 -0700
From: Jay Lan <jlan@engr.sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tim Schmielau <tim@physik3.uni-rostock.de>
CC: Arthur Corliss <corliss@digitalmages.com>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>, erikj@dbear.engr.sgi.com,
       limin@engr.sgi.com, lse-tech@lists.sourceforge.net,
       =?windows-1252?Q?=3F?= <kernel@ragnark.vestdata.no>,
       Yoshitaka ISHIKAWA <y.ishikawa@soft.fujitsu.com>,
       Guillaume Thouvenin <guillaume.thouvenin@bull.net>
Subject: Re: [PATCH] new CSA patchset for 2.6.8
References: <412D2E10.8010406@engr.sgi.com> <20040825221842.72dd83a4.akpm@osdl.org> <Pine.LNX.4.53.0408261821090.14826@gockel.physik3.uni-rostock.de> <Pine.LNX.4.58.0408261111520.22750@bifrost.nevaeh-linux.org> <Pine.LNX.4.53.0408262133190.8515@broiler.physik3.uni-rostock.de>
In-Reply-To: <Pine.LNX.4.53.0408262133190.8515@broiler.physik3.uni-rostock.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I do like to see a common data collection method in the kernl. Kernel
does not need to decide how the data to be presented to the
user space. An accounting loadable module such as CSA or ELSA will
take care of how the data to be presented to meet the needs of
different users.

Sounds reasonable?

Regards,
  - jay


Tim Schmielau wrote:
> On Thu, 26 Aug 2004, Arthur Corliss wrote:
> 
> 
>>I would be very interested in a CSA implementation similar to what I have on
>>IRIX.  I will also plead guilty to not having downloaded the updated patches
>>for either the kernel or the tools.  I'm continuing to use my poor hack until
>>a permanent solution gets accepted into the kernel, at which point I'll
>>adopt that.
> 
> 
> That's ok, we carefully discussed the changes to make sure no new tools
> are required ;-)
> 
> 
>>And if it counters the impression at all, I'm not a kernel developer, I
>>proposed my hack out of need as a user of the tools.  I also try to stay away
>>from modified kernels, so I'm running Marcelos' 2.4 stable branch with only
>>the 32bit u/gid_t hack applied.  That's why I haven't had any feedback on the
>>-mm branch.
> 
> 
> I haven't even tried to get a patch into 2.4, since Marcelo is (rightly)
> quite resilent to new features.
> 
>>In short, for my use BSD accounting is sufficient, but I'd love to see CSA in
>>Linux as well.  Linux hasn't moved too far into roles where it's a necessity
>>(for what I'm doing, anyway), but I see CSA as something that would certainly
>>help it assume those roles.
> 
> 
> Does this mean you would want to have both in the same kernel, potentially
> turning on both at the same time?
> 
> 
> Ok, let me summarize what I learned until now:
> 
> It should be easy to combine the data collection enhancements from
> CSA and ELSA to provide a common superset of information.
> 
> Output file formats vary, but might be unified if projects don't insist
> too much.
> Main difference between CSA and ELSA on the one hand and BSD acct on the
> other is that the latter writes one record per process, while the former
> write one per job.
> With the new BSD acct v3 format, it should be possible to do per job
> accounting entirely from userspace, using pid and ppid information to
> reconstruct the process tree and some userland database for the
> pid -> job mapping. It would, however, be greatly simplified if the
> accounting records provided some kind of job id, and some indicator
> whether or not this process was the last of a job (group).
> 
> CSA and ELSA might even be more lightweight since fewer accounting records
> are actually written.
> 
> Sounds like it should be possible to fulfill the different needs by
> having loadable modules for the different output formats, or by a /proc
> entry that controls some aspects like whether records are written per
> job or per process.
> 
> Comments?

