Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964804AbWHWKDj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964804AbWHWKDj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 06:03:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964803AbWHWKDj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 06:03:39 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:57500 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S964802AbWHWKDi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 06:03:38 -0400
Message-ID: <44EC27DF.2010204@vmware.com>
Date: Wed, 23 Aug 2006 03:03:11 -0700
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
Cc: Arjan van de Ven <arjan@infradead.org>, virtualization@lists.osdl.org,
       Jeremy Fitzhardinge <jeremy@goop.org>, Andrew Morton <akpm@osdl.org>,
       Chris Wright <chrisw@sous-sol.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] paravirt.h
References: <1155202505.18420.5.camel@localhost.localdomain> <200608231141.37284.ak@suse.de> <44EC2450.3060706@vmware.com> <200608231150.17650.ak@suse.de>
In-Reply-To: <200608231150.17650.ak@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
>> And the functions they call?
>>     
>
> Yes. But you only really need it for the actual callback, not the bulk
> of stop_machine_run() (which calls scheduler and lots of other stuff)
> The actual callback should be pretty limited already so it shouldn't
> be a big limitation.
>
> -Andi
>   

Hmm.  Seems dangerous to rely on this, because functions could change 
from inline to out of line without people noticing that it affects this 
very corner case for kprobes + paravirt + stop_machine.  Is there a way 
to cascade the __kprobes declaration to all called functions, perhaps 
with a static checker, like sparse?

Zach
