Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964788AbWHWIoU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964788AbWHWIoU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 04:44:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964782AbWHWIoU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 04:44:20 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:30701 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S964789AbWHWIoT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 04:44:19 -0400
Message-ID: <44EC1563.90206@vmware.com>
Date: Wed, 23 Aug 2006 01:44:19 -0700
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
Cc: Andi Kleen <ak@suse.de>, virtualization@lists.osdl.org,
       Jeremy Fitzhardinge <jeremy@goop.org>, Andrew Morton <akpm@osdl.org>,
       Chris Wright <chrisw@sous-sol.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] paravirt.h
References: <1155202505.18420.5.camel@localhost.localdomain>	 <44DB7596.6010503@goop.org>	 <1156254965.27114.17.camel@localhost.localdomain>	 <200608221544.26989.ak@muc.de> <44EB3BF0.3040805@vmware.com>	 <1156271386.2976.102.camel@laptopd505.fenrus.org>	 <1156275004.27114.34.camel@localhost.localdomain>	 <44EB584A.5070505@vmware.com> <44EB5A76.9060402@vmware.com>	 <p73y7tg7cg7.fsf@verdi.suse.de>  <44EB7F0C.60402@vmware.com> <1156319788.2829.12.camel@laptopd505.fenrus.org>
In-Reply-To: <1156319788.2829.12.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
>> Since this code is so rather, um, custom, I was going to reimplement 
>> stop_machine in the module.
>>     
>
> that sounds like a big mistake. I assume you want your VMI module to be
> part of mainline for one.
>
> And this is the sort of thing that if we want to support it, we better
> support it inside the main kernel, eg provide an api to modules to use
> it, rather than having each module hack their own....
>   

Yes, after discussion with Rusty, it appears that beefing up 
stop_machine_run is the right way to go.  And it has benefits for 
non-paravirt code as well, such as allowing plug-in kprobes or oprofile 
extension modules to be loaded without having to deal with a debug 
exception or NMI during module load/unload.

Thanks,

Zach
