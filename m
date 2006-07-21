Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932548AbWGUG6o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932548AbWGUG6o (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jul 2006 02:58:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932523AbWGUG6n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jul 2006 02:58:43 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:29668 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932587AbWGUG6n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jul 2006 02:58:43 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=er0nP3a9wQZbA13vo0+BQ8a5mXwOfehGv/O6w+YJUiG7h1Vd4/fw2fRDQvDK3GZDSc2QCJQIFQpYiSZjPCpd2FLsawcHw9a38zUwfyC98bRdK1ZWJVwauB1n42kdah7oIYmpv3U0izAyN41jC9xVn/V11Fx03dXVvXl29xx20no=
Message-ID: <84144f020607202358u4bdc5e7egd4096386751d70f7@mail.gmail.com>
Date: Fri, 21 Jul 2006 09:58:41 +0300
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Rolf Eike Beer" <eike-kernel@sf-tec.de>
Subject: Re: [PATCH] drivers: Conversions from kmalloc+memset to k(z|c)alloc.
Cc: "Panagiotis Issaris" <takis@lumumba.uhasselt.be>,
       linux-kernel@vger.kernel.org, len.brown@intel.com,
       chas@cmf.nrl.navy.mil, miquel@df.uba.ar, kkeil@suse.de,
       benh@kernel.crashing.org, video4linux-list@redhat.com,
       rmk+mmc@arm.linux.org.uk, Neela.Kolli@engenio.com, jgarzik@pobox.com,
       vandrove@vc.cvut.cz, adaplas@pol.net, thomas@winischhofer.net,
       weissg@vienna.at, philb@gnu.org, linux-pcmcia@lists.infradead.org,
       jkmaline@cc.hut.fi, paulus@samba.org
In-Reply-To: <200607210850.17878.eike-kernel@sf-tec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060720190529.GC7643@lumumba.uhasselt.be>
	 <200607210850.17878.eike-kernel@sf-tec.de>
X-Google-Sender-Auth: 4eb4eb7a6533ae2f
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/21/06, Rolf Eike Beer <eike-kernel@sf-tec.de> wrote:
> > -     if (!(handle = kmalloc(sizeof(struct input_handle), GFP_KERNEL)))
> > +     handle = kzalloc(sizeof(struct input_handle), GFP_KERNEL);
> > +     if (!handle)
> >               return NULL;
>
> sizeof(*handle)?

In general, yes. However, some maintainers don't like that, so I would
recommend to keep them as-is unless you get a clear ack from the
maintainer to change it.
