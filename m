Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280615AbRKNOcq>; Wed, 14 Nov 2001 09:32:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280608AbRKNOch>; Wed, 14 Nov 2001 09:32:37 -0500
Received: from [217.6.75.131] ([217.6.75.131]:27354 "EHLO
	mail.internetwork-ag.de") by vger.kernel.org with ESMTP
	id <S280606AbRKNOcY>; Wed, 14 Nov 2001 09:32:24 -0500
Message-ID: <3BF282A6.77A02CE9@internetwork-ag.de>
Date: Wed, 14 Nov 2001 15:41:42 +0100
From: Till Immanuel Patzschke <tip@internetwork-ag.de>
Reply-To: tip@prs.de
Organization: interNetwork AG
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Michal Ostrowski <mostrows@speakeasy.net>
CC: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org,
        paulus@samba.org, linux-ppp@vger.kernel.org
Subject: Re: [PATCH] ppp_generic causes skput:under: w/ pppoatm and vc-encaps
In-Reply-To: <3BF190F0.3FB26BD0@internetwork-ag.de> 
		<20011113.210221.55509229.davem@redhat.com> <1005747834.8776.5.camel@brick.watson.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal,

it is the receive side - (chan.hdrlen is set correctly) -- on the receive side
you'll the SKB from the device AND headroom is up to the device...
Michal Ostrowski wrote:

> If you set the hdrlen field of the ppp_channel that pppoatm registers
> (pvcc->chan.hdrlen, in pppoatm_assign_vcc()) then ppp_generic will
> always over-allocate skb space to allow for extra headers to be pushed
> in.  This mechanism was put is so that we wouldn't have to copy the
> frame in order to slap on PPPoE headers onto it.  I think it's a good
> idea to be doing this, especially if you're going to play with
> hard_header_len.
>
> If you look at pppoatm_send(),  you'll see that you do an
> skb_realloc_headroom if there's no space for the headers.   If
> pvcc->chan.hdrlen is set properly then this will be the exceptional,
> rather than the common case.
>
> > Here is my "better fix". In pppoatm, we should be increasing the
> > device header length appropriately.  ie. dev->hard_header_len needs to
> > be increased in the pppoatm driver when vc-encaps is used.
> >
> > Franks a lot,
> > David S. Miller
> > davem@redhat.com
>
> --
> Michal Ostrowski
> mostrows@speakeasy.net

--
Till Immanuel Patzschke                 mailto: tip@internetwork-ag.de
interNetwork AG                         Phone:  +49-(0)611-1731-121
Bierstadter Str. 7                      Fax:    +49-(0)611-1731-31
D-65189 Wiesbaden                       Web:    http://www.internetwork-ag.de



