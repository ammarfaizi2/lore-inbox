Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262284AbVERQEN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262284AbVERQEN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 12:04:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262315AbVERQD2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 12:03:28 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:22203 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S262322AbVERPvC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 11:51:02 -0400
Message-ID: <428B6463.3000604@freenet.de>
Date: Wed, 18 May 2005 17:50:59 +0200
From: Carsten Otte <cotte@freenet.de>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       schwidefsky@de.ibm.com, akpm@osdl.org
Subject: Re: [RFC/PATCH 2/5] mm/fs: execute in place (V2)
References: <1116422644.2202.1.camel@cotte.boeblingen.de.ibm.com> <1116424413.2202.17.camel@cotte.boeblingen.de.ibm.com> <20050518142707.GA23162@infradead.org> <428B57AA.2030006@freenet.de> <20050518150053.GA24389@infradead.org> <428B5FC1.3090704@freenet.de> <20050518153650.GA25322@infradead.org>
In-Reply-To: <20050518153650.GA25322@infradead.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:

>On Wed, May 18, 2005 at 05:31:13PM +0200, Carsten Otte wrote:
>  
>
>>- generic_file_read           => xip_file_read
>>    
>>
>
>no need to have that one if you implement aio_read -> use do_sync_read
>
>  
>
>>- generic_file_aio_read    => xip_file_aio_read
>>- __generic_file_aio_read => __xip_file_aio_read
>>    
>>
>
>readv and aio_read are just wrappers around this one.
>
>  
>
>>- generic_file_sendfile     => xip_file_sendfile
>>    
>>
>
>pretty trivial
>
>  
>
>>- generic file_readv          => xip_file_readv
>>- generic_file_write          => xip_file_write
>>    
>>
>
>just use do_sync_write
>
>  
>
>>- generic_file_aio_write_nolock => xip_file_write_nolock
>>- __generic_file_write_nolock => __xip_file_write_nolock
>>- generic_file_write_nolock => xip_file_write_nolock
>>- generic_file_aio_write => xip_file_aio_write
>>    
>>
>
>you don't need all these.  Just writev and aio_write as wrappers around a common one
>
>  
>
>>- generic_file_mmap => xip_file_mmap
>>    
>>
>
>this one doesn't share code anyway
>
>  
>
>>- generic_file_readonly_mmap => xip_file_readonly_mmap
>>    
>>
>
>unless you want to implement a readonly filesystem with xip support you
>don't need this one.
>
>  
>
I agree that sync/async is not too much of a difference when you do a memcpy
behind, so you can just have wrappers. I am still not convinced that it
will stay
reasonably small with all that duplicated stuff, but since it's easy to
do I just
gonna give it a try to see how it'll look alike. Bet the patch size will
double.
