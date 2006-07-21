Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161023AbWGUKUu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161023AbWGUKUu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jul 2006 06:20:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161026AbWGUKUu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jul 2006 06:20:50 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:59181 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1161023AbWGUKUt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jul 2006 06:20:49 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CoKYQVeyH4lSnctM0ajk3mVffuejLefOUTo6/QQ5cpztUcw42Sv/kVemvh0L8PM2nNeVxlrz29tTcHOD6eNPd3HYQDRUsLORxpGsw8JL3PIh9TZMMjF7SXHv2pczTH6+CyeWyM/Ybhbfmt32nvabOgZMRXDNSTY9ZRlFu/NPE6g=
Message-ID: <9a8748490607210320l16896cfcg2dc12c9cf4c45887@mail.gmail.com>
Date: Fri, 21 Jul 2006 12:20:48 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Stefan Richter" <stefanr@s5r6.in-berlin.de>
Subject: Re: [PATCH] drivers: Conversions from kmalloc+memset to k(z|c)alloc.
Cc: "Jeff Garzik" <jgarzik@pobox.com>, "Pekka Enberg" <penberg@cs.helsinki.fi>,
       "Rolf Eike Beer" <eike-kernel@sf-tec.de>,
       "Panagiotis Issaris" <takis@lumumba.uhasselt.be>,
       linux-kernel@vger.kernel.org, len.brown@intel.com,
       chas@cmf.nrl.navy.mil, miquel@df.uba.ar, kkeil@suse.de,
       benh@kernel.crashing.org, video4linux-list@redhat.com,
       rmk+mmc@arm.linux.org.uk, Neela.Kolli@engenio.com, vandrove@vc.cvut.cz,
       adaplas@pol.net, thomas@winischhofer.net, weissg@vienna.at,
       philb@gnu.org, linux-pcmcia@lists.infradead.org, jkmaline@cc.hut.fi,
       paulus@samba.org
In-Reply-To: <44C099D2.5030300@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060720190529.GC7643@lumumba.uhasselt.be>
	 <200607210850.17878.eike-kernel@sf-tec.de>
	 <84144f020607202358u4bdc5e7egd4096386751d70f7@mail.gmail.com>
	 <44C07CB2.1040303@pobox.com> <44C099D2.5030300@s5r6.in-berlin.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/07/06, Stefan Richter <stefanr@s5r6.in-berlin.de> wrote:
> Jeff Garzik wrote:
> > Pekka Enberg wrote:
> >> On 7/21/06, Rolf Eike Beer <eike-kernel@sf-tec.de> wrote:
> >>> > -     if (!(handle = kmalloc(sizeof(struct input_handle), GFP_KERNEL)))
> >>> > +     handle = kzalloc(sizeof(struct input_handle), GFP_KERNEL);
> >>> > +     if (!handle)
> >>> >               return NULL;
> >>>
> >>> sizeof(*handle)?
> >>
> >> In general, yes. However, some maintainers don't like that, so I would
> >> recommend to keep them as-is unless you get a clear ack from the
> >> maintainer to change it.
>
> I suggest:
>  - check if "sizeof(type)"->"sizeof(*ptr)" is correct
>  - if yes, change it
[snip]
>  - better style of the size argument where correct,

Who says it's "better style" ?
You can argue that   sizeof(type) is more readable.
When reading the code you don't have to go lookup the type of ptr in
sizeof(*ptr)  before you know what type the code is working with.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
