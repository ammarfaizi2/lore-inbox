Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965134AbWGJPtO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965134AbWGJPtO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 11:49:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965115AbWGJPtN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 11:49:13 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:59628 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S965134AbWGJPtM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 11:49:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kuetSnZbwBrcEXTA4RHWXyfaQY4PvximetE4BYykvmEbYKFXjCH++LswmPjvXteYsgXjlExzO02dbciOmMABjJmceYXPfxce8BXvwekKHm64wT7IPZ3Z3XLjTtKhUeAQRvQSmLqjZPVQoOZRfqgcArIxzj6z2evXkPSpftVLQx8=
Message-ID: <d120d5000607100849k5af2ee78o2715d9a51b06c000@mail.gmail.com>
Date: Mon, 10 Jul 2006 11:49:10 -0400
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
To: "Arjan van de Ven" <arjan@infradead.org>
Subject: Re: lockdep input layer warnings.
Cc: "Dave Jones" <davej@redhat.com>, mingo@redhat.com,
       "Linux Kernel" <linux-kernel@vger.kernel.org>
In-Reply-To: <1152544371.4874.66.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060706173411.GA2538@redhat.com>
	 <d120d5000607061137r605a08f9ie6cd45a389285c4a@mail.gmail.com>
	 <1152212575.3084.88.camel@laptopd505.fenrus.org>
	 <d120d5000607061329t4868d265h6f8285c798a0e3b7@mail.gmail.com>
	 <1152544371.4874.66.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/10/06, Arjan van de Ven <arjan@infradead.org> wrote:
> On Thu, 2006-07-06 at 16:29 -0400, Dmitry Torokhov wrote:
> >
> > Well, you are right, the patch is in -rc1 and I see mutex_lock_nested
> > in the backtrace but for some reason it is still not happy. Again,
> > this is with pass-through Synaptics port and we first taking mutex of
> > the child device and then (going through pass-through port) trying to
> > take mutex of the parent.
>
> Ok it seems more drastic measures are needed; and a split of the
> cmd_mutex class on a per driver basis. The easiest way to do that is to
> inline the lock initialization (patch below) but to be honest I think
> the patch is a bit ugly; I considered inlining the entire function
> instead, any opinions on that?
>

It is ugly. Maybe we could have something like mutex_init_nolockdep()
to annotate that lockdep is confused and make it ignore such locks?

Of course there is a chance that lockdep is correct but I do not think so.

-- 
Dmitry
