Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271598AbRIGHrd>; Fri, 7 Sep 2001 03:47:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271607AbRIGHrN>; Fri, 7 Sep 2001 03:47:13 -0400
Received: from castle.nmd.msu.ru ([193.232.112.53]:27404 "HELO
	castle.nmd.msu.ru") by vger.kernel.org with SMTP id <S271598AbRIGHrD>;
	Fri, 7 Sep 2001 03:47:03 -0400
Message-ID: <20010907115416.A26786@castle.nmd.msu.ru>
Date: Fri, 7 Sep 2001 11:54:16 +0400
From: Andrey Savochkin <saw@saw.sw.com.sg>
To: Julian Anastasov <ja@ssi.bg>
Cc: Wietse Venema <wietse@porcupine.org>,
        Matthias Andree <matthias.andree@stud.uni-dortmund.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: notion of a local address [was: Re: ioctl SIOCGIFNETMASK: ip aliasbug 2.4.9 and 2.2.19]
In-Reply-To: <Pine.LNX.4.33.0109070944510.1449-100000@u.domain.uli>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2i
In-Reply-To: <Pine.LNX.4.33.0109070944510.1449-100000@u.domain.uli>; from "Julian Anastasov" on Fri, Sep 07, 2001 at 10:10:01AM
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Sep 07, 2001 at 10:10:01AM +0000, Julian Anastasov wrote:
> 
> Andrey Savochkin wrote:
> 
> > > > connect a datagram socket (which won't produce any actual traffic) to
> > > > the remote host with INADDR_ANY as the local address, and then query
> > > > the local address.  If the local address is the same as the remote
> > > > address, the address is local.
> > >
> > > That will always work, even when you have multiple ethernet
> > > interfaces??
> >
> > It will work almost always, except cases where administrator set different
> > preffered sources in local routes.
> 
> 	It seems if connect() is called without bind() and the target
> is local address the selected source is the same (the preferred address
> is not used). The postfix guys simply can try this proposal (I don't

I've just checked, you're right.
In the mainstream 2.4 kernels for local routes setting the source to be equal
to the target overrides the preferred source from the route.

I personally consider it as a bug.
Why do we have preferred source field in the routes if not to override how
the kernel selects the source by itself?

	Andrey
