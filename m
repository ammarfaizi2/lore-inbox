Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281428AbRKMBkM>; Mon, 12 Nov 2001 20:40:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281430AbRKMBkD>; Mon, 12 Nov 2001 20:40:03 -0500
Received: from warden.digitalinsight.com ([208.29.163.2]:14325 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id <S281428AbRKMBjq>; Mon, 12 Nov 2001 20:39:46 -0500
From: David Lang <david.lang@digitalinsight.com>
To: Mike Fedyk <mfedyk@matchmail.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>,
        "David S. Miller" <davem@redhat.com>, helgehaf@idb.hist.no,
        linux-kernel@vger.kernel.org
Date: Mon, 12 Nov 2001 17:15:28 -0800 (PST)
Subject: Re: speed difference between using hard-linked and modular drives?
In-Reply-To: <20011112173014.G32099@mikef-linux.matchmail.com>
Message-ID: <Pine.LNX.4.40.0111121714200.3451-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike the point is that the module count inc/dec would need to be done for
every packet so that when you go to unload you can check the usage value,
so the check is done in the slow path, but the inc/dec is done in the fast
path.

David Lang

 On Mon, 12 Nov 2001, Mike Fedyk wrote:

> Date: Mon, 12 Nov 2001 17:30:14 -0800
> From: Mike Fedyk <mfedyk@matchmail.com>
> To: Rusty Russell <rusty@rustcorp.com.au>
> Cc: David S. Miller <davem@redhat.com>, helgehaf@idb.hist.no,
>      linux-kernel@vger.kernel.org
> Subject: Re: speed difference between using hard-linked and modular
>     drives?
>
> On Tue, Nov 13, 2001 at 10:14:22AM +1100, Rusty Russell wrote:
> > In message <20011112.152304.39155908.davem@redhat.com> you write:
> > >    From: Rusty Russell <rusty@rustcorp.com.au>
> > >    Date: Mon, 12 Nov 2001 20:59:05 +1100
> > >
> > >    (atomic_inc & atomic_dec_and_test for every packet, anyone?).
> > >
> > > We already do pay that price, in skb_release_data() :-)
> >
> > Sorry, I wasn't clear!  skb_release_data() does an atomic ops on the
> > skb data region, which is almost certainly on the same CPU.  This is
> > an atomic op on a global counter for the module, which almost
> > certainly isn't.
> >
> > For something which (statistically speaking) never happens (module
> > unload).
> >
>
> Is this in the fast path or slow path?
>
> If it only happens on (un)load, then there isn't any cost until it's needed...
>
> Mike
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
