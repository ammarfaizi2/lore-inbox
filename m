Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030544AbVKPWnA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030544AbVKPWnA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 17:43:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030546AbVKPWnA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 17:43:00 -0500
Received: from nproxy.gmail.com ([64.233.182.207]:39493 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030544AbVKPWm7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 17:42:59 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cirrwaUqFQa4mL326A7Wb0CNm1EesyAAzYHcLg7i9/06GOsCqsQT+TzEJwiDfU1eKUsb/Qg0+KNnElwKgwUFExKYTb0uxSSKlxfWab8oEcpIBwZS3bDRe5dE4R3gz81mHJsL4IZPtHBMxgZxA3Pf4SkU5kjlSBT0sPr78C0baso=
Message-ID: <7fce76bf0511161442q5eef217dhe14f6ff1625437a2@mail.gmail.com>
Date: Wed, 16 Nov 2005 22:42:58 +0000
From: Lee Causier <leecausier@gmail.com>
To: Davy Durham <pubaddr2@davyandbeth.com>
Subject: Re: virtual NICs
Cc: "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <437BAB0B.1090504@davyandbeth.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <437B932F.3090607@davyandbeth.com>
	 <Pine.LNX.4.61.0511161540080.5251@chaos.analogic.com>
	 <437BAB0B.1090504@davyandbeth.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Just a quick note..

iirc, virtual interfaces are necessary in order to configure multiple
IP addresses using "ifconfig", but if you use iproute2's tools you can
add any/all IPs to one interface (the original, eg eth0, br0, vlan0001
etc) with a command like "ip addr add 12.3.45.66/28 dev eth0" and then
all the addresses are considered equal; although ifconfig will only
list one of the IPs (it appears that it is restricted to
"understanding" only one IP per interface)

Cheers,

Lee Causier.
Undergraduate
BSc Computer Science (Year 1)

On 11/16/05, Davy Durham <pubaddr2@davyandbeth.com> wrote:
> First, thanks for the prompt response.
>
> linux-os (Dick Johnson) wrote:
>
> >Of course there is extra work! Any time something has to be checked
> >(filtered), there is the overhead of the filtering. In the case of
> >two or more IP addresses, the software has to perform an ARP on two
> >or more IPs. This means that it needs to "listen" for more queries.
> >Note that machines on Ethernet, communicate using their hardware-
> >addresses i.e., the "IEEE station address". But, the initial route
> >to the target machine needs to be set up by broadcasting an IP address,
> >thereby asking everybody on the LAN if the IP address belongs to them.
> >Hopefully only one machine answers. This sequence is called ARP
> >(address resolution protocol).
> >
> >
> >
> My question was whether the one being defined to eth0 has an advantage
> over the one assigned to eth0:0 since one is real and one is virtual.
> My uninformed instinct told me to wonder if the NIC hardware itself
> somehow gets told to handle the IP assigned to eth0 and something in the
> linux software has to handle the IP assigned to eth0:0
>
> I realize that the machine will have to do more work total.  But I
> wonder if it's any more work than if the server has two NICs with two
> different IPs.
>
> >Adding more IP addresses is like adding more machines as far as
> >the source (perhaps a router) is concerned. Adding more IP addresses
> >to a single host is sometimes necessary, but it is not without
> >cost. Basically, don't do it unless it's necessary.
> >
> >
> >
> It's necessary because of the in-born inability for name based virtual
> hosting to be done over SSL (though I think this inability was
> unnecessary in that it could have been relaxed if just a little bit of
> unsecured data could be transmitted in the SSL header allowing the
> server to make some decision based on that clear data.. but that's
> another matter).
>
> Thanks again,
>   Davy
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
