Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750713AbVJSNnx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750713AbVJSNnx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 09:43:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750777AbVJSNnx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 09:43:53 -0400
Received: from [194.90.79.130] ([194.90.79.130]:46855 "EHLO argo2k.argo.co.il")
	by vger.kernel.org with ESMTP id S1750713AbVJSNnw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 09:43:52 -0400
Message-ID: <43564D8F.3000809@argo.co.il>
Date: Wed, 19 Oct 2005 15:43:43 +0200
From: Avi Kivity <avi@argo.co.il>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: 7eggert@gmx.de
CC: Badari Pulavarty <pbadari@gmail.com>, Guido Fiala <gfiala@s.netic.de>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: large files unnecessary trashing filesystem cache?
References: <4Z5WG-1iM-19@gated-at.bofh.it> <4Z6zs-27l-39@gated-at.bofh.it> <E1ERzTq-0001IA-Ba@be1.lrz>
In-Reply-To: <E1ERzTq-0001IA-Ba@be1.lrz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 Oct 2005 13:43:48.0809 (UTC) FILETIME=[22357390:01C5D4B3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bodo Eggert wrote:

>I guess the solution would be using random cache eviction rather than
>a FIFO. I never took a look the cache mechanism, so I may very well be
>wrong here.
>  
>
Instead of random cache eviction, you can make pages that were read in 
contiguously age faster than pages that were read in singly.

The motivation is that the cost of reading 64K vs 4K is almost the same 
(most of the cost is the seek), while the benefit for evicting 64K is 16 
times that of evicting 4K. Over time, the kernel would favor expensive 
random-access pages over cheap streaming pages.

In a way, this is already implemented for inodes, which are aged more 
slowly than data pages.


