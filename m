Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751196AbWGUVQb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751196AbWGUVQb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jul 2006 17:16:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751192AbWGUVQb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jul 2006 17:16:31 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:4314 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751196AbWGUVQa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jul 2006 17:16:30 -0400
Message-ID: <44C14426.9000300@pobox.com>
Date: Fri, 21 Jul 2006 17:16:22 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Jesper Juhl <jesper.juhl@gmail.com>
CC: Stefan Richter <stefanr@s5r6.in-berlin.de>,
       Pekka Enberg <penberg@cs.helsinki.fi>,
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
References: <20060720190529.GC7643@lumumba.uhasselt.be>	 <200607210850.17878.eike-kernel@sf-tec.de>	 <84144f020607202358u4bdc5e7egd4096386751d70f7@mail.gmail.com>	 <44C07CB2.1040303@pobox.com> <44C099D2.5030300@s5r6.in-berlin.de> <9a8748490607210320l16896cfcg2dc12c9cf4c45887@mail.gmail.com>
In-Reply-To: <9a8748490607210320l16896cfcg2dc12c9cf4c45887@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl wrote:
> On 21/07/06, Stefan Richter <stefanr@s5r6.in-berlin.de> wrote:
>> Jeff Garzik wrote:
>> > Pekka Enberg wrote:
>> >> On 7/21/06, Rolf Eike Beer <eike-kernel@sf-tec.de> wrote:
>> >>> > -     if (!(handle = kmalloc(sizeof(struct input_handle), 
>> GFP_KERNEL)))
>> >>> > +     handle = kzalloc(sizeof(struct input_handle), GFP_KERNEL);
>> >>> > +     if (!handle)
>> >>> >               return NULL;
>> >>>
>> >>> sizeof(*handle)?
>> >>
>> >> In general, yes. However, some maintainers don't like that, so I would
>> >> recommend to keep them as-is unless you get a clear ack from the
>> >> maintainer to change it.
>>
>> I suggest:
>>  - check if "sizeof(type)"->"sizeof(*ptr)" is correct
>>  - if yes, change it
> [snip]
>>  - better style of the size argument where correct,
> 
> Who says it's "better style" ?
> You can argue that   sizeof(type) is more readable.
> When reading the code you don't have to go lookup the type of ptr in
> sizeof(*ptr)  before you know what type the code is working with.

All the more reason that such changes -- unrelated to kzalloc/kcalloc 
conversion -- should be in a separate patch.

	Jeff



