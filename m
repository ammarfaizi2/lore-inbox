Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130073AbRBUWbs>; Wed, 21 Feb 2001 17:31:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130092AbRBUWbj>; Wed, 21 Feb 2001 17:31:39 -0500
Received: from foobar.napster.com ([64.124.41.10]:24588 "EHLO
	foobar.napster.com") by vger.kernel.org with ESMTP
	id <S130073AbRBUWbY>; Wed, 21 Feb 2001 17:31:24 -0500
Message-ID: <3A94418D.A0DD99BF@napster.com>
Date: Wed, 21 Feb 2001 14:30:37 -0800
From: Jordan Mendelson <jordy@napster.com>
Organization: Napster, Inc.
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-ac17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: ookhoi@dds.nl, Vibol Hou <vibol@khmer.cc>,
        Linux-Kernel <linux-kernel@vger.kernel.org>, sim@stormix.com
Subject: Re: 2.4 tcp very slow under certain circumstances (Re: netdev issues 
 (3c905B))
In-Reply-To: <HDEBKHLDKIDOBMHPKDDKMEGDEFAA.vibol@khmer.cc>
		<20010221104723.C1714@humilis> <14995.40701.818777.181432@pizda.ninka.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" wrote:
> 
> Ookhoi writes:
>  > We have exactly the same problem but in our case it depends on the
>  > following three conditions: 1, kernel 2.4 (2.2 is fine), 2, windows ip
>  > header compression turned on, 3, a free internet access provider in
>  > Holland called 'Wish' (which seemes to stand for 'I Wish I had a faster
>  > connection').
>  > If we remove one of the three conditions, the connection is oke. It is
>  > only tcp which is affected.
>  > A packet on its way from linux server to windows client seems to get
>  > dropped once and retransmitted. This makes the connection _very_ slow.
> 
> :-( I hate these buggy systems.
> 
> Does this patch below fix the performance problem and are the windows
> clients win2000 or win95?

I wanted to see if this would fix the problem I was seeing with Win9x
users on PPP w/ compression dialing up to Earthlink in the bay area
(there are others, but it's the only one I can reproduce).

I compiled 2.4.1 with this change and for some odd reason, the kernel
started dropping packets and became unusable (couldn't ssh in) after
around 4050 connections were opened. I tested it also with 2.4.1-ac20
and had the same problem right around 4050 connections.

This is on a VA Linux box with dual eepro100's (one used) connected to a
Cisco 6509.



> --- include/net/ip.h.~1~        Mon Feb 19 00:12:31 2001
> +++ include/net/ip.h    Wed Feb 21 02:56:15 2001
> @@ -190,9 +190,11 @@
> 
>  static inline void ip_select_ident(struct iphdr *iph, struct dst_entry *dst)
>  {
> +#if 0
>         if (iph->frag_off&__constant_htons(IP_DF))
>                 iph->id = 0;
>         else
> +#endif
>                 __ip_select_ident(iph, dst);
>  }
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
