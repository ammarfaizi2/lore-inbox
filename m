Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265166AbUD3SBF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265166AbUD3SBF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 14:01:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265171AbUD3SBF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 14:01:05 -0400
Received: from mtagate1.uk.ibm.com ([195.212.29.134]:24314 "EHLO
	mtagate1.uk.ibm.com") by vger.kernel.org with ESMTP id S265166AbUD3SBA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 14:01:00 -0400
Message-ID: <40929446.2080009@watson.ibm.com>
Date: Fri, 30 Apr 2004 14:00:38 -0400
From: Shailabh <nagar@watson.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Guillaume Thouvenin <guillaume.thouvenin@polymtl.ca>
CC: Christoph Hellwig <hch@infradead.org>, Rik van Riel <riel@redhat.com>,
       Erik Jacobson <erikj@subway.americas.sgi.com>,
       Paul Jackson <pj@sgi.com>, chrisw@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Process Aggregates (PAGG) support for the 2.6 kernel
References: <Pine.SGI.4.53.0404291447220.732952@subway.americas.sgi.com> <Pine.LNX.4.44.0404291719400.9152-100000@chimarrao.boston.redhat.com> <20040430071750.A8515@infradead.org> <1083323300.409233a4459e3@www.imp.polymtl.ca>
In-Reply-To: <1083323300.409233a4459e3@www.imp.polymtl.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Guillaume Thouvenin wrote:
> Selon Christoph Hellwig <hch@infradead.org>:
> 
> 
>>>I suspect there's a rather good chance of merging a common
>>>PAGG/CKRM infrastructure, since they pretty much do the same
>>>thing at the core and they both have different functionality
>>>implemented on top of the core process grouping.
>>
>>Still doesn't make a lot of sense.  CKRM is a huge cludgy beast poking
>>everywhere while PAGG is a really small layer to allow kernel modules
>>keeping per-process state.  If CKRM gets merged at all (and the current
>>looks far to horrible and the gains are rather unclear) it should layer
>>ontop of something like PAGG for the functionality covered by it.
> 
> 
> And what about put the management of containers outside the kernel. We could for
> exemple use a program that will listen file /proc/acct_event and execute a
> programs to handle the event like ACPID does. Of course it will need some kernel
> modifications but those modifications will be small as process aggregation will
> be done outside the kernel. We could also use relayfs to exchange datas between
> user program and the kernel.
> 
> Guillaume


Guillaume,

As mentioned in my response to Christoph, keeping process aggregation 
outside the kernel (or as a module that sits atop process-centric 
patches) will work only for statistics gathering and coarse-grain 
control.

CKRM's crbce controller (will be put up on http://ckrm.sf.net within a 
day...) uses relayfs to send per-process data to a privileged user 
program (will also be included) that can use the data as it pleases, 
including doing aggregation.

We think a class-aware kernel is the right way to go and it can be 
done with sufficiently low impact that one doesn't have to 
unnecessarily limit the flexibility of users in defining process 
groups (=classes) or the time periods over which shares can be enforced.

-- Shailabh
