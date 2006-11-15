Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030804AbWKOSR2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030804AbWKOSR2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 13:17:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030803AbWKOSR2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 13:17:28 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:3724 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030793AbWKOSR1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 13:17:27 -0500
Message-ID: <455B5990.7080808@us.ibm.com>
Date: Wed, 15 Nov 2006 10:16:48 -0800
From: Badari Pulavarty <pbadari@us.ibm.com>
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-mm <linux-mm@kvack.org>, ext4 <linux-ext4@vger.kernel.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: pagefault in generic_file_buffered_write() causing deadlock
References: <1163606265.7662.8.camel@dyn9047017100.beaverton.ibm.com> <20061115090005.c9ec6db5.akpm@osdl.org>
In-Reply-To: <20061115090005.c9ec6db5.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Wed, 15 Nov 2006 07:57:45 -0800
> Badari Pulavarty <pbadari@us.ibm.com> wrote:
>
>   
>> We are looking at a customer situation (on 2.6.16-based distro) - where
>> system becomes almost useless while running some java & stress tests.
>>
>> Root cause seems to be taking a pagefault in generic_file_buffered_write
>> () after calling prepare_write. I am wondering 
>>
>> 1) Why & How this can happen - since we made sure to fault the user
>> buffer before prepare write.
>>     
>
> When using writev() we only fault in the first segment of the iovec.  If
> the second or succesive segment isn't mapped into pagetables we're
> vulnerable to the deadlock.
>   

Yes. I remember this change. Thank you.
>   
>> 2) If this is already fixed in current mainline (I can't see how).
>>     
>
> It was fixed in 2.6.17.
>
> You'll need 6527c2bdf1f833cc18e8f42bd97973d583e4aa83 and
> 81b0c8713385ce1b1b9058e916edcf9561ad76d6
>   
I will try to get this change into customer :(

Thanks,
Badari

