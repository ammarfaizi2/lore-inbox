Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751178AbWGUVQB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751178AbWGUVQB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jul 2006 17:16:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751192AbWGUVQB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jul 2006 17:16:01 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:63705 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751178AbWGUVQA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jul 2006 17:16:00 -0400
Message-ID: <44C143FA.9030808@pobox.com>
Date: Fri, 21 Jul 2006 17:15:38 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
CC: Pekka Enberg <penberg@cs.helsinki.fi>,
       Rolf Eike Beer <eike-kernel@sf-tec.de>,
       Panagiotis Issaris <takis@lumumba.uhasselt.be>,
       linux-kernel@vger.kernel.org, len.brown@intel.com,
       chas@cmf.nrl.navy.mil, miquel@df.uba.ar, kkeil@suse.de,
       benh@kernel.crashing.org, video4linux-list@redhat.com,
       rmk+mmc@arm.linux.org.uk, Neela.Kolli@engenio.com, vandrove@vc.cvut.cz,
       adaplas@pol.net, thomas@winischhofer.net, weissg@vienna.at,
       philb@gnu.org, linux-pcmcia@lists.infradead.org, jkmaline@cc.hut.fi,
       paulus@samba.org
Subject: Re: [PATCH] drivers: Conversions from kmalloc+memset to k(z|c)alloc.
References: <20060720190529.GC7643@lumumba.uhasselt.be>	 <200607210850.17878.eike-kernel@sf-tec.de> <84144f020607202358u4bdc5e7egd4096386751d70f7@mail.gmail.com> <44C07CB2.1040303@pobox.com> <44C099D2.5030300@s5r6.in-berlin.de>
In-Reply-To: <44C099D2.5030300@s5r6.in-berlin.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stefan Richter wrote:
> Jeff Garzik wrote:
>> Pekka Enberg wrote:
>>> On 7/21/06, Rolf Eike Beer <eike-kernel@sf-tec.de> wrote:
>>>>> -     if (!(handle = kmalloc(sizeof(struct input_handle), GFP_KERNEL)))
>>>>> +     handle = kzalloc(sizeof(struct input_handle), GFP_KERNEL);
>>>>> +     if (!handle)
>>>>>               return NULL;
>>>> sizeof(*handle)?
>>> In general, yes. However, some maintainers don't like that, so I would
>>> recommend to keep them as-is unless you get a clear ack from the
>>> maintainer to change it.
> 
> I suggest:
>  - check if "sizeof(type)"->"sizeof(*ptr)" is correct
>  - if yes, change it
>  - do this for all kmalloc + kzalloc in a file you touched, or
>    better yet for all kmalloc + kzalloc in a driver or subsystem you
>    touched

This breaks the rules of standard Linux patches.

The patch should contain ONE logical change.  Any cleanups such as 
sizeof(type) -> sizeof(*ptr) should be in a SEPARATE PATCH.

	Jeff


