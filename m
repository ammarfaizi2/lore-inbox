Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261159AbVBVULs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261159AbVBVULs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 15:11:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261221AbVBVULs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 15:11:48 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:42175 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261159AbVBVULo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 15:11:44 -0500
Message-ID: <421B9205.7060704@sgi.com>
Date: Tue, 22 Feb 2005 12:11:49 -0800
From: Jay Lan <jlan@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: zh-tw, en-us, en, zh-cn, zh-hk
MIME-Version: 1.0
To: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
CC: Andrew Morton <akpm@osdl.org>, LSE-Tech <lse-tech@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>,
       Tim Schmielau <tim@physik3.uni-rostock.de>,
       Jesse Barnes <jbarnes@sgi.com>
Subject: Re: [Lse-tech] Re: A common layer for Accounting packages
References: <42168D9E.1010900@sgi.com>	 <20050218171610.757ba9c9.akpm@osdl.org> <1108968681.8398.44.camel@frecb000711.frec.bull.fr>
In-Reply-To: <1108968681.8398.44.camel@frecb000711.frec.bull.fr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Guillaume Thouvenin wrote:
> On Fri, 2005-02-18 at 17:16 -0800, Andrew Morton wrote:
> 
>>Jay Lan <jlan@sgi.com> wrote:
>>
>>>Since the need of Linux system accounting has gone beyond what BSD
>>>accounting provides, i think it is a good idea to create a thin layer
>>>of common code for various accounting packages, such as BSD accounting,
>>>CSA, ELSA, etc. The hook to do_exit() at exit.c was changed to invoke
>>>a routine in the common code which would then invoke those accounting
>>>packages that register to the acct_common to handle do_exit situation.
>>
>>This all seems to be heading in the wrong direction.  Do we really want to
>>have lots of different system accounting packages all hooking into a
>>generic we-cant-decide-what-to-do-so-we-added-some-pointless-overhead
>>framework?
>>
>>Can't we get _one_ accounting system in there, get it right, avoid the
>>framework?
> 
> 
>   Is it possible to just merge the BSD accounting and the CSA accounting
> by adding in the current BSD per-process accounting structure some
> missing fields like the mm integral provided by the CSA patch?

Hi Guillaume,

All raw data CSA needs already stored in task_struct of the process.

> 
> ELSA is just a user of the accounting data. We need a hook in the
> do_fork() routine to manage group of processes, not to do accounting.

I see at least three layers of functions in doing system accounting:
data collection, handling of the raw data, and presentation of the
data to users.

We have merged the data collection part. :)

Handling of the raw data seems done in ELSA by user spaced daemon
and you are proposing to add a hook at fork time. I am interested
in learning your approach. How ELSA adds per process accounting data
to your grouping (banks) when a process exit? How do you save
accounting data you need in task_struct before it is disposed? BSD
handles that through acct_process() hook at do_exit(). CSA also
depends on a hook at do_exit() to merge per-process data to per-job
data. How does ELSA handle this without a need of a do_exit() hook?

Thanks,
  - jay

> 
> Guillaume
> 
> 
> 
> -------------------------------------------------------
> SF email is sponsored by - The IT Product Guide
> Read honest & candid reviews on hundreds of IT Products from real users.
> Discover which products truly live up to the hype. Start reading now.
> http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
> _______________________________________________
> Lse-tech mailing list
> Lse-tech@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/lse-tech

