Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751000AbVIAH0f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751000AbVIAH0f (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 03:26:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751020AbVIAH0f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 03:26:35 -0400
Received: from wproxy.gmail.com ([64.233.184.203]:37767 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750992AbVIAH0e convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 03:26:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mh89E+qjR6mUSXhdvpj6xcxedPkQ5Jb2aaKknsjFeIB/pgTJi8nhulWOwVcvfNxM2cZDchnW+uZyI3PClfzdQWQQbknJsAz0zD7lhHHvz1WAz8dxVftnbCNGEvX4KOq86IOzj7ojzZUv2Tj2bpERMZYM6XpOnHcQFVH4NrWBRvs=
Message-ID: <21c563b60509010026ed7265b@mail.gmail.com>
Date: Thu, 1 Sep 2005 15:26:33 +0800
From: zhang yuanyi <zhangyuanyi@gmail.com>
To: Jesper Juhl <jesper.juhl@gmail.com>
Subject: Re: What about adding range support for u32 classifier?
Cc: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, linux-kernel@vger.kernel.org
In-Reply-To: <9a8748490508300514414410b5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <21c563b6050829202372189527@mail.gmail.com>
	 <9a8748490508300514414410b5@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2005/8/30, Jesper Juhl <jesper.juhl@gmail.com>:
> On 8/30/05, zhang yuanyi <zhangyuanyi@gmail.com> wrote:
> > Hello, everyone!
> >
> > The "range support" may be puzzled, but I don't know how to express my
> > problem exactly because of my poor english.
> >
> > Just take an example, I may need all udp packets received on eth0
> > which source port is greater than 53 going into flow 10:1,  and I only
> > wanna to type one tc command like this(In fact, I communicated with
> > kernel directly):
> >
> >     tc filter add dev eth0 parent ffff: protocol ip prio 20 \
> >                                   u32 match udp sport gt 53 0xffff \
> >                                         match ip protocol 17 0xff\
> >                                    flowid 10:1
> >
> > But I found I can't, because u32 classifier doesn't support matching
> > multi-value in one key.So I need to add (65535-53) keys to a u32
> > filter to implement this.
> >
> > I intend to solve this problem by modifying u32 filter to match
> > multi-value in one key, but I am worrying the preformance.
> >
> > Can someone give me some suggestions?
> >
> How is this a kernel problem?
> "tc" is a userspace app. I think you'd be better off talking to Alexey
> Kuznetsov (added to Cc), who wrote tc, about this.
> 
Actually, I communicated with kernel directly in my app and don't use tc at all.

That tc command is used just for expressing my problem conveniently.

My problem is that I need to match udp/tcp packets with different s/d
port(f.e., all udp packets which source port is greater than 53 and
less than 5069) on ingress, but u32 classifier in kernel(not the tc
app) doesn't support matching value in a range.

So I think I may need to modify the kernel to add range support for
u32 classifier. But I am worrying its performance will be down.

Does anyone have a more clever solution?
