Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262014AbVEKRsE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262014AbVEKRsE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 13:48:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262012AbVEKRsE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 13:48:04 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:28881 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S262020AbVEKRre
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 13:47:34 -0400
Message-ID: <42824532.9040002@freenet.de>
Date: Wed, 11 May 2005 19:47:30 +0200
From: Carsten Otte <cotte@freenet.de>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
CC: Badari Pulavarty <pbadari@us.ibm.com>,
       Christoph Hellwig <hch@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>, schwidefsky@de.ibm.com,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC/PATCH 2/5] mm/fs: add execute in place support
References: <428216F7.30303@de.ibm.com> <1115826428.26913.1069.camel@dyn318077bld.beaverton.ibm.com> <4282307D.8060307@freenet.de> <200505111931.11799.arnd@arndb.de>
In-Reply-To: <200505111931.11799.arnd@arndb.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann wrote:

>On Middeweken 11 Mai 2005 18:19, Carsten Otte wrote:
>  
>
>>Badari Pulavarty wrote:
>>    
>>
>>>you may want to look into some how eliminating few
>>>function pointer de-refs and checks for those who don't care.
>>>(#ifdef, unlikely(), or some arch & config magic).
>>> 
>>>
>>>      
>>>
>>I do agree that addidional pointer derefs would be a nightmare
>>from the performance perspective. But afaics the patch does not
>>add such, and for checks I did already add likeleyness for the non-xip
>>case. Could you be more precise and specify which code path(es) you
>>mean?
>>    
>>
>
>I guess what Badari means is that you could add a function like
>
>#ifdef CONFIG_FS_XIP
>static inline int mapping_has_xip(struct address_space *mapping)
>{
>	return __unlikely(mapping->a_ops->get_xip_page != NULL);
>}
>#else
>#define mapping_has_xip(x) (0)
>#endif
>
>Using this in the hot path should result identical binary code to the
>current version as long as XIP is not enabled, while otherwise you
>need to access four data cache lines every time.
>
>I wouldn't expect much benefit from this since all these cache lines
>should be pretty hot and the branch gets predicted correctly anyway,
>but it surely doesn't hurt to do the abstraction.
>
>	Arnd <><
>  
>
Agreed. Will be changed in next version, thanks for clarification.
