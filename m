Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422785AbWHXXzE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422785AbWHXXzE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 19:55:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422787AbWHXXzE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 19:55:04 -0400
Received: from smtpout.mac.com ([17.250.248.175]:58612 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1422785AbWHXXzD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 19:55:03 -0400
In-Reply-To: <1156463308.19702.40.camel@linuxchandra>
References: <44E33893.6020700@sw.ru> <1155929992.26155.60.camel@linuxchandra> <44E9B3F5.3010000@sw.ru> <1156196721.6479.67.camel@linuxchandra> <1156211128.11127.37.camel@galaxy.corp.google.com> <1156272902.6479.110.camel@linuxchandra> <1156383881.8324.51.camel@galaxy.corp.google.com> <1156385072.7154.59.camel@linuxchandra> <1156417808.3007.78.camel@localhost.localdomain> <1156463308.19702.40.camel@linuxchandra>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <FFE6D792-4D6C-4F19-A939-CBA5F0654FBA@mac.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, rohitseth@google.com,
       Rik van Riel <riel@redhat.com>, ckrm-tech@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>, Christoph Hellwig <hch@infradead.org>,
       Andrey Savochkin <saw@sw.ru>, devel@openvz.org, hugh@veritas.com,
       Ingo Molnar <mingo@elte.hu>, Kirill Korotaev <dev@sw.ru>,
       Pavel Emelianov <xemul@openvz.org>
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [ckrm-tech] [RFC][PATCH] UBC: user resource beancounters
Date: Thu, 24 Aug 2006 19:55:11 -0400
To: sekharan@us.ibm.com
X-Mailer: Apple Mail (2.752.2)
X-Brightmail-Tracker: AAAAAQAAA+k=
X-Language-Identified: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 24, 2006, at 19:48:28, Chandra Seetharaman wrote:
> On Thu, 2006-08-24 at 12:10 +0100, Alan Cox wrote:
>> All you need is
>>
>> struct wombat_controller
>> {
>> 	struct user_beancounter counter;
>> 	void (*wombat_pest_control)(struct wombat *w);
>> 	atomic_t wombat_population;
>> 	int (*wombat_destructor)(struct wombat *w);
>> };
>
> This may not solve the problem, as
>  - we won't be able get the controller data structure given the  
> beancounter data structure.

Of course you can!  This is what we do for linked lists too.  Here's  
an example of how to get a pointer to your wombat_controller given  
the user_beancounter pointer:
struct wombat_controller *wombat = containerof 
(ptr_to_user_beancounter, struct wombat_controller, counter);

The containerof(PTR, TYPE, MEMBER) returns a pointer to the parent  
object of type "TYPE" whose member "MEMBER" has address "PTR".

Cheers,
Kyle Moffett



