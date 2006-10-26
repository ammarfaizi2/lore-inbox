Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423719AbWJZSnk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423719AbWJZSnk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 14:43:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423720AbWJZSnk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 14:43:40 -0400
Received: from gateway.argo.co.il ([194.90.79.130]:15630 "EHLO
	argo2k.argo.co.il") by vger.kernel.org with ESMTP id S1423719AbWJZSnk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 14:43:40 -0400
Message-ID: <454101D6.9050004@argo.co.il>
Date: Thu, 26 Oct 2006 20:43:34 +0200
From: Avi Kivity <avi@argo.co.il>
User-Agent: Thunderbird 1.5.0.7 (X11/20061008)
MIME-Version: 1.0
To: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
CC: lkml@pengaru.com, linux-kernel@vger.kernel.org
Subject: Re: rename() contention (BUG?)
References: <20061025205634.GB9100@shells.gnugeneration.com> <20061025211341.GB7128@filer.fsl.cs.sunysb.edu>
In-Reply-To: <20061025211341.GB7128@filer.fsl.cs.sunysb.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 26 Oct 2006 18:43:37.0710 (UTC) FILETIME=[A618E8E0:01C6F92E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Josef Sipek wrote:
> On Wed, Oct 25, 2006 at 03:56:34PM -0500, lkml@pengaru.com wrote:
>   
>> Hello,
>>
>> I have seen some scalability problems with Maildir-based mail systems running on
>> Linux (debian sarge, 2.6.8), and after much investigation I found a large part
>> of the problem was rename() contention.
>>     
>  
> Just FYI, around 2.6.15 the i_sem was replace with i_mutex which is much
> better/faster. (And I would strongly suggest you upgrade.) I would actually
> like to know how much the lock contention decresed for your case.
>   

The changes make the mutex more efficient, but won't decrease the 
contention.  It seems that all renames in one filesystem are serialized, 
and if the renames require I/O (which is certainly the case with nfs), 
rename throughput is severely limited.


-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.

