Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269997AbUJNI0p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269997AbUJNI0p (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 04:26:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269999AbUJNI0p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 04:26:45 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:9231 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S269997AbUJNI0g
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 04:26:36 -0400
From: Herbert Xu <herbert@gondor.apana.org.au>
To: stsp@aknet.ru (Stas Sergeev)
Subject: Re: [patch] allow write() on SOCK_PACKET sockets
Cc: herbert@gondor.apana.org.au, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org
Organization: Core
In-Reply-To: <416DF644.2070906@aknet.ru>
X-Newsgroups: apana.lists.os.linux.kernel,apana.lists.os.linux.net
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.27-hx-1-686-smp (i686))
Message-Id: <E1CI0wC-0001j8-00@gondolin.me.apana.org.au>
Date: Thu, 14 Oct 2004 18:26:16 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stas Sergeev <stsp@aknet.ru> wrote:
>
> I think you are looking at a wrong place.
> You are looking into IP raw sockets code.
> Packet sockets are really the different
> layer. Please have a look into
> net/packet/af_packet.c instead.

Yes.  Sorry for the confusion.

> But I don't seem to be able to send any
> mail to you:

Should work now.
 
>> OTOH, write() and send() needs to know where the message is going
>> to.
>
> That's exactly where the packet sockets are
> different. Here's the whole point. Have a
> look into a "struct sockaddr_pkt":
> 
>              struct sockaddr_pkt
>              {
>                  unsigned short  spkt_family;
>                  unsigned char   spkt_device[14];
>                  unsigned short  spkt_protocol;
>              };

I see your point.  But I don't really like the current code that
uses the address from bind for sending.  Even though it works here
because the packet socket is symmetric wrt sending/receiving, it
is counter-intuitive for the socket API in general.

> My patch is probably dead anyway though.
> SOCK_PACKET is mentioned to be deprecated
> in man, so perhaps noone will apply any
> patches on it... Just wanted to point out

Indeed it is.

> that there is a bug/inconsistency in it.

Thanks anyway.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
