Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964892AbWF3BAw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964892AbWF3BAw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 21:00:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964895AbWF3BAv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 21:00:51 -0400
Received: from mtagate5.uk.ibm.com ([195.212.29.138]:13555 "EHLO
	mtagate5.uk.ibm.com") by vger.kernel.org with ESMTP id S964892AbWF3BAs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 21:00:48 -0400
Message-ID: <44A477BE.6000208@watson.ibm.com>
Date: Thu, 29 Jun 2006 21:00:46 -0400
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paul Jackson <pj@sgi.com>
CC: akpm@osdl.org, Valdis.Kletnieks@vt.edu, jlan@engr.sgi.com,
       balbir@in.ibm.com, csturtiv@sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [Patch][RFC] Disabling per-tgid stats on task exit in taskstats
References: <44892610.6040001@watson.ibm.com>	<20060623141926.b28a5fc0.akpm@osdl.org>	<449C6620.1020203@engr.sgi.com>	<20060623164743.c894c314.akpm@osdl.org>	<449CAA78.4080902@watson.ibm.com>	<20060623213912.96056b02.akpm@osdl.org>	<449CD4B3.8020300@watson.ibm.com>	<44A01A50.1050403@sgi.com>	<20060626105548.edef4c64.akpm@osdl.org>	<44A020CD.30903@watson.ibm.com>	<20060626111249.7aece36e.akpm@osdl.org>	<44A026ED.8080903@sgi.com>	<20060626113959.839d72bc.akpm@osdl.org>	<44A2F50D.8030306@engr.sgi.com>	<20060628145341.529a61ab.akpm@osdl.org>	<44A2FC72.9090407@engr.sgi.com>	<20060629014050.d3bf0be4.pj@sgi.com>	<200606291230.k5TCUg45030710@turing-police.cc.vt.edu>	<20060629094408.360ac157.pj@sgi.com>	<20060629110107.2e56310b.akpm@osdl.org>	<20060629112642.66f35dd5.pj@sgi.com>	<44A426DC.9090009@watson.ibm.com>	<20060629124148.48d4c9ad.pj@sgi.com>	<44A4492E.6090307@watson.ibm.com>	<20060629152319.cfffe0d6.pj@sgi.com>	<44A46D3B.6060703@watson.ibm.com> <20060629174036.2e592a5b.pj@sgi.!
 com>
In-Reply-To: <20060629174036.2e592a5b.pj@sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson wrote:

>Shailabh wrote:
>  
>
>>Nope...as long as there are users who are using cpusets ONLY as a means 
>>of reducing sockets to listen to, timestamps will be needed.
>>    
>>
>
>Could you take one more stab at explaining this.
>
>It made no sense to me this time around.  Sorry.
>
>  
>

In the current taskstats interface, there is only a single stream of 
taskstats structures coming out
from the kernel. There is some ordering there. Lets say this ordering 
info is of some relevance to a
consumer of taskstats (very big and possibly faulty assumption there !)

Now we move to a design where the kernel is sending the same data out in 
multiple streams.
If the consumer wants to reconstruct the ordering she would have got 
under the current scheme (even
approximately),  she would need to know how to merge sort these streams 
and for that she would
need timestamp data on each of the taskstats structs.

Assumption is a bit of a stretch admittedly. But since timestamping 
costs so little, might as well put one
in (will also help CSA do one less thing)

--Shailabh


