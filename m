Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932288AbVKWW0Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932288AbVKWW0Z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 17:26:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932588AbVKWW0Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 17:26:24 -0500
Received: from terminus.zytor.com ([192.83.249.54]:57299 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S932288AbVKWW0X
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 17:26:23 -0500
Message-ID: <4384EC68.1060302@zytor.com>
Date: Wed, 23 Nov 2005 14:25:44 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Linus Torvalds <torvalds@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Gerd Knorr <kraxel@suse.de>, Dave Jones <davej@redhat.com>,
       Zachary Amsden <zach@vmware.com>, Pavel Machek <pavel@ucw.cz>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] SMP alternatives
References: <1132764133.7268.51.camel@localhost.localdomain> <20051123163906.GF20775@brahms.suse.de> <1132766489.7268.71.camel@localhost.localdomain> <Pine.LNX.4.64.0511230858180.13959@g5.osdl.org> <4384AECC.1030403@zytor.com> <Pine.LNX.4.64.0511231031350.13959@g5.osdl.org> <1132782245.13095.4.camel@localhost.localdomain> <Pine.LNX.4.64.0511231331040.13959@g5.osdl.org> <20051123214344.GU20775@brahms.suse.de> <Pine.LNX.4.64.0511231413530.13959@g5.osdl.org> <20051123222212.GV20775@brahms.suse.de>
In-Reply-To: <20051123222212.GV20775@brahms.suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> On Wed, Nov 23, 2005 at 02:15:24PM -0800, Linus Torvalds wrote:
> 
>>
>>On Wed, 23 Nov 2005, Andi Kleen wrote:
>>
>>>>THAT is what I'd like to have CPU support for. Not for UP (it's going 
>>>>away), and not for the kernel (it's never single-threaded).
>>>
>>>There is one reasonly interesting special case that will probably stay
>>>around: single CPU guest in a virtualized environment.
>>
>>.. and then the _virtualizer_ should just set the bit. 
> 
> That wouldn't work if it's limited limited to ring 3.
> 
> Also currently at least the Xen the driver interfaces seem to 
> rely on lock, but perhaps that can be changed.
> 

Well, with VTX or Pacifica virtualization is in ring 3.  The fact that 
Xen isn't is a workaround for current hardware, so when we're talking 
about new hardware it's pointless.

What you really want is one bit for kernel mode (cpl 0-2) and one for 
user mode (cpl 3).

	-hpa
