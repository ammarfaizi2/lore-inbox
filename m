Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161029AbWGUKZT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161029AbWGUKZT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jul 2006 06:25:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161021AbWGUKZS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jul 2006 06:25:18 -0400
Received: from in.cluded.net ([195.159.98.120]:37250 "EHLO in.cluded.net")
	by vger.kernel.org with ESMTP id S1161026AbWGUKZR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jul 2006 06:25:17 -0400
Message-ID: <44C0AA9A.6090708@cluded.net>
Date: Fri, 21 Jul 2006 10:21:14 +0000
From: "Daniel K." <daniel@cluded.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9a1) Gecko/20060307 SeaMonkey/1.5a
MIME-Version: 1.0
To: Rolf Eike Beer <eike-kernel@sf-tec.de>
CC: Panagiotis Issaris <takis@lumumba.uhasselt.be>,
       linux-kernel@vger.kernel.org, len.brown@intel.com,
       chas@cmf.nrl.navy.mil, miquel@df.uba.ar, kkeil@suse.de,
       benh@kernel.crashing.org, video4linux-list@redhat.com,
       rmk+mmc@arm.linux.org.uk, Neela.Kolli@engenio.com, jgarzik@pobox.com,
       vandrove@vc.cvut.cz, adaplas@pol.net, thomas@winischhofer.net,
       weissg@vienna.at, philb@gnu.org, linux-pcmcia@lists.infradead.org,
       jkmaline@cc.hut.fi, paulus@samba.org
Subject: Re: [PATCH] drivers: Conversions from kmalloc+memset to k(z|c)alloc.
References: <20060720190529.GC7643@lumumba.uhasselt.be> <200607210850.17878.eike-kernel@sf-tec.de>
In-Reply-To: <200607210850.17878.eike-kernel@sf-tec.de>
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rolf Eike Beer wrote:
> Am Donnerstag, 20. Juli 2006 21:05 schrieb Panagiotis Issaris:
>> @@ -443,12 +442,11 @@ int con_clear_unimap(struct vc_data *vc,
>>  	p = (struct uni_pagedir *)*vc->vc_uni_pagedir_loc;
>>  	if (p && p->readonly) return -EIO;
>>  	if (!p || --p->refcount) {
>> -		q = (struct uni_pagedir *)kmalloc(sizeof(*p), GFP_KERNEL);
>> +		q = kzalloc(sizeof(*p), GFP_KERNEL);
>>  		if (!q) {
>>  			if (p) p->refcount++;
>>  			return -ENOMEM;
>>  		}
>> -		memset(q, 0, sizeof(*q));
>>  		q->refcount=1;
>>  		*vc->vc_uni_pagedir_loc = (unsigned long)q;
>>  	} else {
> 
> This one still changes the way the code works. Before your patch *p will be 
> always zeroed out. Now if p is there before it will keep it's contents.

No, it doesn't, the data at *p is/was not zeroed inside the if { .. } block.
Read carefully, the multiple statements on one line obfuscations might
have thrown you off. 

However, it is slightly confusing that the value assigned to `q' is
kzalloced using sizeof(*p). It is an improvement though, as the old version
kmalloced using sizeof(*p), and memset using sizeof(*q).
That was really strange.


Daniel K.
