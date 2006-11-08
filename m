Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752892AbWKHBKw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752892AbWKHBKw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 20:10:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753117AbWKHBKw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 20:10:52 -0500
Received: from gw.goop.org ([64.81.55.164]:31921 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1752892AbWKHBKw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 20:10:52 -0500
Message-ID: <45512E9C.9030702@goop.org>
Date: Tue, 07 Nov 2006 17:10:52 -0800
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20061027)
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
CC: Andrew Morton <akpm@osdl.org>, Zachary Amsden <zach@vmware.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix kunmap_atomic's use of kpte_clear_flush()
References: <4551232A.4020203@goop.org> <1162946572.29130.9.camel@localhost.localdomain>
In-Reply-To: <1162946572.29130.9.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:
> On Tue, 2006-11-07 at 16:22 -0800, Jeremy Fitzhardinge wrote:
>   
>> kunmap_atomic() will call kpte_clear_flush with vaddr/ptep arguments
>> which don't correspond if the vaddr is just a normal lowmem address
>> (ie, not in the KMAP area).  This patch makes sure that the pte is
>> only cleared if kmap area was actually used for the mapping.
>>     
>
> Or in other words, if kmap_atomic() does nothing, kunmap_atomic() should
> do nothing.
>   

Sure.  I guess there's no particular reason why kmap_atomic() couldn't 
always map, but I guess avoid the pagetable updates is worthwhile.

    J
