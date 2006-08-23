Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751510AbWHWJtZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751510AbWHWJtZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 05:49:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751514AbWHWJtZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 05:49:25 -0400
Received: from nz-out-0102.google.com ([64.233.162.202]:61519 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751505AbWHWJtX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 05:49:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gIBtN3yyM4OGMINDl8qEzX8xCscFGcsHBy3+ywWBtahWLGb3unu1AB2G/4oWaQFFQkJtQp5Z2yhDdbX+KzqENvnlq9oFBQBvl2OOeZoK0E7dRaOpm0XILdb/wZ0wWx567WX1EpK0WzwR7KWXW6C3J6NaBHuSpi9N9u/gcHHUWxo=
Message-ID: <b3f268590608230249q653e1dfh1d77c07f6f4e82ce@mail.gmail.com>
Date: Wed, 23 Aug 2006 11:49:22 +0200
From: "Jari Sundell" <sundell.software@gmail.com>
To: "Evgeniy Polyakov" <johnpol@2ka.mipt.ru>
Subject: Re: [take12 0/3] kevent: Generic event handling mechanism.
Cc: "David Miller" <davem@davemloft.net>, kuznet@ms2.inr.ac.ru,
       nmiell@comcast.net, linux-kernel@vger.kernel.org, drepper@redhat.com,
       akpm@osdl.org, netdev@vger.kernel.org, zach.brown@oracle.com,
       hch@infradead.org
In-Reply-To: <20060823083859.GA8936@2ka.mipt.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <b3f268590608221551q5e6a1057hd1474ee8b9811f10@mail.gmail.com>
	 <20060822231129.GA18296@ms2.inr.ac.ru>
	 <b3f268590608221728r6cffd03i2f2dd12421b9f37@mail.gmail.com>
	 <20060822.173200.126578369.davem@davemloft.net>
	 <b3f268590608221743o493080d0t41349bc4336bdd0b@mail.gmail.com>
	 <20060823065659.GC24787@2ka.mipt.ru>
	 <b3f268590608230122k60e3c7c7y939d5559d97107f@mail.gmail.com>
	 <20060823083859.GA8936@2ka.mipt.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/23/06, Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
> On Wed, Aug 23, 2006 at 10:22:06AM +0200, Jari Sundell (sundell.software@gmail.com) wrote:
> > On 8/23/06, Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
> > >void * in structure exported to userspace is forbidden.
> >
> > Only void * I'm seeing belongs to the user, (udata) perhaps you are
> > talking of something different?
>
> Yes, exactly about it.
>
> I put union {
>         u32 a[2];
>         void *b;
> }
> epcially to eliminate that problem.

It's just random data of a known maximum size appended to the struct,
I'm sure you can find a clean way to handle it. If you mangle the
first variable name in your union, you'll end up with something that
should be usable instead of udata.

> And I'm not that sure aboit stuff like uptr_t or how they call pointers
> in userspace and kernelspace.

Well, I can't find any use of pointers in your struct ukevent, nor in
any of the kqueue events in my man page. So if this is a deficit it
applies to both, I guess?

> ukevent is aligned to 8 bytes already (it's size selected to be 40 bytes),
> so it should not be a problem.
>
> > Eric

Even if it is so, wouldn't it be better to be explicit about it?

Rakshasa
