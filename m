Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129245AbRBURSC>; Wed, 21 Feb 2001 12:18:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129273AbRBURRv>; Wed, 21 Feb 2001 12:17:51 -0500
Received: from tilde.ookhoi.dds.nl ([194.109.10.165]:30592 "HELO
	humilis.ookhoi.dds.nl") by vger.kernel.org with SMTP
	id <S129245AbRBURRj>; Wed, 21 Feb 2001 12:17:39 -0500
Date: Wed, 21 Feb 2001 18:17:01 +0100
From: Ookhoi <ookhoi@dds.nl>
To: "David S. Miller" <davem@redhat.com>
Cc: Vibol Hou <vibol@khmer.cc>, Linux-Kernel <linux-kernel@vger.kernel.org>,
        sim@stormix.com
Subject: Re: 2.4 tcp very slow under certain circumstances (Re: netdev issues (3c905B))
Message-ID: <20010221181700.N2207@humilis>
Reply-To: ookhoi@dds.nl
In-Reply-To: <HDEBKHLDKIDOBMHPKDDKMEGDEFAA.vibol@khmer.cc> <20010221104723.C1714@humilis> <14995.40701.818777.181432@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <14995.40701.818777.181432@pizda.ninka.net>; from davem@redhat.com on Wed, Feb 21, 2001 at 02:57:01AM -0800
X-Uptime: 12:06pm  up 17:41, 10 users,  load average: 0.04, 0.03, 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David!

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

Yes, the problem is fixed! Thank you very much. :-)  'great' patch!

	Ookhoi


> --- include/net/ip.h.~1~	Mon Feb 19 00:12:31 2001
> +++ include/net/ip.h	Wed Feb 21 02:56:15 2001
> @@ -190,9 +190,11 @@
>  
>  static inline void ip_select_ident(struct iphdr *iph, struct dst_entry *dst)
>  {
> +#if 0
>  	if (iph->frag_off&__constant_htons(IP_DF))
>  		iph->id = 0;
>  	else
> +#endif
>  		__ip_select_ident(iph, dst);
>  }
