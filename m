Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272520AbRIFTar>; Thu, 6 Sep 2001 15:30:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272523AbRIFTai>; Thu, 6 Sep 2001 15:30:38 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:54545 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S272521AbRIFTaW>; Thu, 6 Sep 2001 15:30:22 -0400
Subject: Re: notion of a local address [was: Re: ioctl SIOCGIFNETMASK: ip alias
To: wietse@porcupine.org (Wietse Venema)
Date: Thu, 6 Sep 2001 20:34:15 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), wietse@porcupine.org (Wietse Venema),
        saw@saw.sw.com.sg (Andrey Savochkin),
        matthias.andree@gmx.de (Matthias Andree), ak@suse.de (Andi Kleen),
        linux-kernel@vger.kernel.org
In-Reply-To: <20010906172316.E0B74BC06C@spike.porcupine.org> from "Wietse Venema" at Sep 06, 2001 01:23:16 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15f4ul-0000J5-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Alan Cox:
> > How for example do you propose to answer the question for the case
> > Q: "is this local" A: "it depends on the sender"
> > With netfilter and transparent proxying active this is entirely possible
> 
> Please explain the relevance for a real-world, SMTP based, MTA.

Certainly

> If an MTA receives a delivery request for user@[ip.address] then
> the MTA has to decide if it is the final destination. This is
> required by the SMTP RFC.

Lets take an absolutely clear every day of the week scenario. I have a 
mail server with two connections, eth0 is through a corporate firewall
out on to the internet. We have an ip address and name visible to the
world. Say example.com and 192.193.194.165. eth1 is the private office
network and contains private address space not visible to the outside
world. Indeed in some cases the choice of the private address space might
be considered security sensitive, but say its 10.0.0.*

You get 
RCPT root@[10.0.0.1]

is that local valid mail.

If it is from the outside world then the answer is "never heard of them,
not me". If it is from the private network the answer is "yes fine"

If you accept 10.0.0.1 from the outside you are leaking information. It
might not be 10.* it might be something like an ibm internal address range
revealing your company was bought by ibm before the press releases, it might
indicate connection to a military network ..

> In order to enable SMTP RFC compliance, Linux has to provide the
> MTA with the necessary information.  Requiring the sysadmin to

Strict RFC compliance isn't a real world goal. I doubt any mailer implements 
SEND, SOML or SAML for example. I definitely agree that the #Number and
[a.b.c.d] forms are important though, and that you need to be able to
answer the question. However you need to answer it "is this my address
from the viewpoint of the peer on this connection". I don't see why 
user configured data isnt a solution. For the 99.9% of normal cases 
SIOCGIFCONF is going to give the right data. People doing clever things
will have to set up config files. simple easy - hard possible.

> If an MTA receives a mail relaying request for user@domain.name
> then it would be very useful if Linux could provide the MTA with
> the necessary information to distinguish between local subnetworks

Define "local". Same ASN ?, by OSPF - "directly plugged into this host"
certainly doesn't cut.

> and the rest of the world. Requiring the local sysadmin to enumerate
> all local subnetwork blocks by hand is not practical.
> 
> I will ignore denigrating comments about competing IP stacks.

Reread my mail. Now think about when the API in question was designed.
The 4.* BSD world up 4.4BSD supported a much smaller subset of the possible
configurations than current stacks do. Needless to say it should not be
suprising that the API's available still reflect that limitation. That
always happens. Thats why sockets are broken for 0 length datagrams and
the C language is bad at unicode. It happens everywhere, and its not
denigrating anything.

Its unfortunate you have to go around labelling everything as "competing"
and "denigrating". You also appear confused still about the 127/8 issue.
You say "you didnt ask it to", well you certainly did, since you bound
to INADDR_ANY. Since 127/8 is looped back I don't think you can reasonably
argue that it is not one of your addresses.

Alan
