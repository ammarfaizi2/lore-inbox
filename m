Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265160AbUD3Rx4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265160AbUD3Rx4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 13:53:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265164AbUD3Rx4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 13:53:56 -0400
Received: from mtagate1.uk.ibm.com ([195.212.29.134]:52725 "EHLO
	mtagate1.uk.ibm.com") by vger.kernel.org with ESMTP id S265160AbUD3Rxy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 13:53:54 -0400
Message-ID: <40929297.2030903@watson.ibm.com>
Date: Fri, 30 Apr 2004 13:53:27 -0400
From: Shailabh <nagar@watson.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: Rik van Riel <riel@redhat.com>,
       Erik Jacobson <erikj@subway.americas.sgi.com>,
       Paul Jackson <pj@sgi.com>, chrisw@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Process Aggregates (PAGG) support for the 2.6 kernel
References: <20040430071750.A8515@infradead.org> <Pine.LNX.4.44.0404300853230.6976-100000@chimarrao.boston.redhat.com> <20040430140611.A11636@infradead.org>
In-Reply-To: <20040430140611.A11636@infradead.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> On Fri, Apr 30, 2004 at 08:54:08AM -0400, Rik van Riel wrote:
> 
>>What was the last time you looked at the CKRM source?
> 
> 
> the day before yesterday (the patch in SuSE's tree because there
> doesn't seem to be any official patch on their website)
> 
> 
>>Sure it's a bit bigger than PAGG, but that's also because
>>it includes the functionality to change the group a process
>>belongs to and other things that don't seem to be included
>>in the PAGG patch.
> 
> 
> Again, pagg doesn't even play in that league.  It's really just a tiny
> meachnism to allow a kernel module keep per-process data.  

Speaking of per-process data, one of the classification engines of 
CKRM called crbce, implemented as a module, allows per-process data to 
be  sent to userland.  crbce in particular, exports data on the delays 
   seen by processes in a) waiting for cpu time after being runnable 
b) page fault service time c) io service time etc. (getting the data 
requires another kernel patch)....so per-process data needs can be met 
through CKRM, though that is not the intent or main objective of the 
project.


> Policies
> like process-groups can be implemented ontop of that.

This is true if one is only interested in data gathering or 
coarse-grain control. One could monitor per-process stats and fiddle 
with each process' rlimits (assuming all the ones needed are 
available) and achieve coarse-grain group control.

But if processes leave and join process groups  rapidly, you need the 
schedulers and the core kernel to be aware of the groupings and 
schedule resources accordingly.

In CKRM, the premise is that the privileged user defines the way 
processes get grouped and could do so in a way that leads to rapid 
changes in group membership. So having group control/monitoring 
policies implemented as an externally loaded module (not talking of 
scheduler modifications as modules, which is a no-no)  is not a 
palatable option.


-- Shailabh
