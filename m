Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262485AbRENUec>; Mon, 14 May 2001 16:34:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262484AbRENUeW>; Mon, 14 May 2001 16:34:22 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:45249 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S262486AbRENUeI>;
	Mon, 14 May 2001 16:34:08 -0400
Message-ID: <3B00413A.B0D3620D@mandrakesoft.com>
Date: Mon, 14 May 2001 16:34:02 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5-pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: kuznet@ms2.inr.ac.ru
Cc: andrewm@uow.edu.au, davem@redhat.COM, linux-kernel@vger.kernel.org
Subject: Re: NETDEV_CHANGE events when __LINK_STATE_NOCARRIER is modified
In-Reply-To: <200105141942.XAA16515@ms2.inr.ac.ru>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kuznet@ms2.inr.ac.ru wrote:
> > Each bus should
> 
> Not all the device are bound to some "bus".

True.  Each driver author would make a decision, for what's best to
appear in their probe time printk's...


> > Are you talking about his 140k patch?
> 
> Yes!
> 
> Size of patch and "simplicity" are orthogonal things.
> It was simple like potatoe.

It was simple for existing code, I agree, but IMHO not correct WRT the
dev->name error case mentioned earlier, and also different from the rest
of the kernel driver APIs.

> > I think a key point of my patch is that drivers now follow the method of
> > other kernel drivers: perform all setup necessary, and then register the
> > device in a single operation.
> 
> Nice. I agreed. I talk about other thing: after applying Andrew's patch
> I saw good correct code. After you will fix all the devices, your patch will
> be the same 140K or more due to killing refs t dev->name announced
> to be illegal. 8)

true enough...

> >                                After register_foo(dev), all members of
> > 'dev' are assumed to be filled in and ready for use.  This is not the
> > case ....................... using dev->init()...
> 
> Sorry? Why?

Sorry -- I just rechecked the code, and I was mistaken.  dev-init() is
called earlier than I had thought..


> > Tangent - IMHO having register_netdev call dev->init is ugly and unusual
> > compared to other driver APIs in the kernel.  Your register function
> > should not call out to driver functions, it should just register a new,
> > already-set-up device in the subsystem and return.
> 
> Provided you teach me some way to generate unique identifiers, different
> of device names.

I don't understand your point here.  init_etherdev and alloc_etherdev
users get by just fine without dev->init().  My thought is that
dev->init is not needed at all -- simply require initialization before
register_netdev[ice] is called.


> > So you say a fatal bug remains in 2.4.5-pre1?  If so please elaborate...
> 
> Probably, I am looking into different code, but I found only 15 references
> to new interface.

Please let me know what bugs you find in the vanilla kernel...

Regards,

	Jeff


-- 
Jeff Garzik      | Game called on account of naked chick
Building 1024    |
MandrakeSoft     |
