Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752558AbWKAXYq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752558AbWKAXYq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 18:24:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752559AbWKAXYq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 18:24:46 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:5047 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1752558AbWKAXYp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 18:24:45 -0500
Message-ID: <45492CBC.8020501@vmware.com>
Date: Wed, 01 Nov 2006 15:24:44 -0800
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
Cc: Chris Wright <chrisw@sous-sol.org>, akpm@osdl.org, ak@muc.de,
       Rusty Russell <rusty@rustcorp.com.au>,
       Jeremy Fitzhardinge <jeremy@goop.org>, linux-kernel@vger.kernel.org,
       virtualization@lists.osdl.org
Subject: Re: [PATCH 4/7] Allow selected bug checks to be skipped by paravirt
 kernels
References: <20061029024504.760769000@sous-sol.org> <20061029024606.496399000@sous-sol.org> <20061101121753.GA2205@elf.ucw.cz>
In-Reply-To: <20061101121753.GA2205@elf.ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> On Sat 2006-10-28 00:00:04, Chris Wright wrote:
>   
>> Allow selected bug checks to be skipped by paravirt kernels.  The two most
>> important are the F00F workaround (which is either done by the hypervisor,
>> or not required), and the 'hlt' instruction check, which can break under
>> some hypervisors.
>>     
>
> How can hlt check break? It is hlt;hlt;hlt, IIRC, that looks fairly
> innocent to me.
>   

Not if you use tickless timers that don't generate interrupts to unhalt 
you, or if you delay ticks until the next scheduled timeout and you 
haven't yet scheduled any timeout.  Both are likely in a hypervisor.

Zach
