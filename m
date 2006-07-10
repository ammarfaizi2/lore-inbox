Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965171AbWGJP7W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965171AbWGJP7W (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 11:59:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965178AbWGJP7V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 11:59:21 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:1824 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S965171AbWGJP7U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 11:59:20 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=W7tZME3l7vSwyw2wXLpqb/f4V+gQndUZpW6f222XQS15T002zey8rOTxALgZawxVQe/liyNGa+Lx77OW3ME3e5ssXdQDNwzfjU4e+8ggIEZi24M7OMj4LmQ/my/IIWmbw2ArESLIwLpw1xhut9FH1Hoi3Rfp5RKOyX0RxW15P5k=
Message-ID: <d120d5000607100859w9960ban547886df4c0016a9@mail.gmail.com>
Date: Mon, 10 Jul 2006 11:59:19 -0400
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
To: "Arjan van de Ven" <arjan@infradead.org>
Subject: Re: lockdep input layer warnings.
Cc: "Dave Jones" <davej@redhat.com>, mingo@redhat.com,
       "Linux Kernel" <linux-kernel@vger.kernel.org>
In-Reply-To: <1152546812.4874.69.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060706173411.GA2538@redhat.com>
	 <d120d5000607061137r605a08f9ie6cd45a389285c4a@mail.gmail.com>
	 <1152212575.3084.88.camel@laptopd505.fenrus.org>
	 <d120d5000607061329t4868d265h6f8285c798a0e3b7@mail.gmail.com>
	 <1152544371.4874.66.camel@laptopd505.fenrus.org>
	 <d120d5000607100849k5af2ee78o2715d9a51b06c000@mail.gmail.com>
	 <1152546812.4874.69.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/10/06, Arjan van de Ven <arjan@infradead.org> wrote:
> On Mon, 2006-07-10 at 11:49 -0400, Dmitry Torokhov wrote:
> > On 7/10/06, Arjan van de Ven <arjan@infradead.org> wrote:
> > > On Thu, 2006-07-06 at 16:29 -0400, Dmitry Torokhov wrote:
> > > >
> > > > Well, you are right, the patch is in -rc1 and I see mutex_lock_nested
> > > > in the backtrace but for some reason it is still not happy. Again,
> > > > this is with pass-through Synaptics port and we first taking mutex of
> > > > the child device and then (going through pass-through port) trying to
> > > > take mutex of the parent.
> > >
> > > Ok it seems more drastic measures are needed; and a split of the
> > > cmd_mutex class on a per driver basis. The easiest way to do that is to
> > > inline the lock initialization (patch below) but to be honest I think
> > > the patch is a bit ugly; I considered inlining the entire function
> > > instead, any opinions on that?
> > >
> >
> > It is ugly. Maybe we could have something like mutex_init_nolockdep()
> > to annotate that lockdep is confused and make it ignore such locks?
>
> nope but there is a function to make it unique, we could put that in the
> wrapper instead of mutex_init if that makes it less ugly..
>

What function is that? BTW, I dont think that inlining will work
because it is truly recursive scanario. The only driver in question in
the backtrace provided is psmouse; there is only one call to ps2_init
there.

-- 
Dmitry
