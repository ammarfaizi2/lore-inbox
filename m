Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265242AbSLMSBL>; Fri, 13 Dec 2002 13:01:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265211AbSLMSBL>; Fri, 13 Dec 2002 13:01:11 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:3834 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S265205AbSLMSBJ>;
	Fri, 13 Dec 2002 13:01:09 -0500
Message-ID: <3DFA21C5.867C6320@us.ibm.com>
Date: Fri, 13 Dec 2002 10:07:01 -0800
From: Nivedita Singhvi <niv@us.ibm.com>
X-Mailer: Mozilla 4.78 [en] (Win98; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew McGregor <andrew@indranet.co.nz>
CC: Bogdan Costescu <bogdan.costescu@iwr.uni-heidelberg.de>,
       "David S. Miller" <davem@redhat.com>, dlstevens@us.ibm.com,
       matti.aarnio@zmailer.org, alan@lxorguk.ukuu.org.uk,
       stefano.andreani.ap@h3g.it, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org
Subject: Re: R: Kernel bug handling TCP_RTO_MAX?
References: <Pine.LNX.4.44.0212131233220.11129-100000@kenzo.iwr.uni-heidelbe
	 rg.de> <19000000.1039780134@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew McGregor wrote:

> In a closed network, why not have SOCK_STREAM map to something faster than
> TCP anyway?  That is, if I connect(address matching localnet), SOCK_STREAM
> maps to (eg) SCTP.  That would be a far more dramatic performance hack!
> 
> Andrew

Not that simple. SCTP (if that is what Matti was referring to) is 
a SOCK_STREAM socket, with a protocol of IPPROTO_SCTP. I'm just
getting done implementing a testsuite against the SCTP API.

i.e. You have to know you want an SCTP socket at the time you
open the socket. You certainly have no idea whether youre on
a closed network or not, for that matter, the app may want to talk
on multiple interfaces etc. (Most hosts will have one interface
on a public net)..

Currently, Linux SCTP doesn't yet support TCP style i.e SOCK_STREAM
sockets, we only do udp-style sockets (SOCK_SEQPACKET).  We will be
putting in SOCK_STREAM support next, but understand that performance
is not something that has been addressed yet, and a performant SCTP
is still some ways away (though I'm sure Jon and Sridhar will be 
working their tails off to do so  ;)). 

But dont expect SCTP to be the surreptitious underlying layer
carrying TCP traffic, if thats an expectation that anyone has :)

Solving this problem without application involvement is a 
more limited scenario..

thanks,
Nivedita
