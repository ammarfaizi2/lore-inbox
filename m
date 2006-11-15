Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030685AbWKOQoj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030685AbWKOQoj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 11:44:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030689AbWKOQoj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 11:44:39 -0500
Received: from nf-out-0910.google.com ([64.233.182.185]:49619 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1030685AbWKOQoh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 11:44:37 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VRZXsqmiBD/D7VwK66IpyKB/ephwsG79qoLimz8znpB0rnKH9QD8Lxq5w9lq+1xhm16P6uQ0X4MizUskAMGxpn38WM71+ptEj4NaI3oFb3GsyB7KgNdjwvTzDgYOyQYiozv4IOSp2BqdEFScqMExeQrnNo4bmOujAMjIAThrv7Y=
Message-ID: <d120d5000611150844s16980cf3r2fca9a71d439cbed@mail.gmail.com>
Date: Wed, 15 Nov 2006 11:44:36 -0500
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
To: "Cornelia Huck" <cornelia.huck@de.ibm.com>
Subject: Re: [Patch -mm 2/5] driver core: Introduce device_move(): move a device to a new parent.
Cc: "Kay Sievers" <kay.sievers@vrfy.org>, "Greg KH" <greg@kroah.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "Andrew Morton" <akpm@osdl.org>,
       "Martin Schwidefsky" <schwidefsky@de.ibm.com>
In-Reply-To: <20061115111136.3542aca3@gondolin.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061114113208.74ec12c4@gondolin.boeblingen.de.ibm.com>
	 <20061115065052.GC23810@kroah.com>
	 <20061115082856.195ca0ab@gondolin.boeblingen.de.ibm.com>
	 <3ae72650611150044y8e0b57k681c478dca5c6cbf@mail.gmail.com>
	 <20061115102409.6e6e5dc0@gondolin.boeblingen.de.ibm.com>
	 <1163583119.4244.6.camel@pim.off.vrfy.org>
	 <20061115111136.3542aca3@gondolin.boeblingen.de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/15/06, Cornelia Huck <cornelia.huck@de.ibm.com> wrote:
> On Wed, 15 Nov 2006 10:31:59 +0100,
> Kay Sievers <kay.sievers@vrfy.org> wrote:
>
> > We need the old DEVPATH in the environment (or something similar),
> > otherwise we can't connect the event with the new device location to the
> > current device. :)
>
> Duh. I've attached another completely untested patch below.
>
> > > Wouldn't we need something similar for kobject_rename()
> > > as well?
> >
> > Maybe kobject_rename() can go, if we have a move function which can be
> > used. In any case, the events should look identical to userspace, yes.
>
> I think kobject_move() and kobject_rename() are two different beasts.
> kobject_move() changes the topology, kobject_rename() changes an
> identifier. Shouldn't they be reported in two different ways to
> userspace?
>

Why do we need to have them at all? Devices should not "move" in the
trees - it it moves we should just treat them as old devices going
away and new devices appearing... Renames - they are only used to
rename net devices, don't they? I wonder if we could have just a
separate "alias" or "name" sysfs attribute for them and get away with
renaming of devices.

-- 
Dmitry
