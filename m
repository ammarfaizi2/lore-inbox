Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261963AbSJQRmn>; Thu, 17 Oct 2002 13:42:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261972AbSJQRmm>; Thu, 17 Oct 2002 13:42:42 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:32495 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S261963AbSJQRlv>; Thu, 17 Oct 2002 13:41:51 -0400
Subject: Re: [PATCHSET] Mobile IPv6 for 2.5.43
To: yoshfuji@linux-ipv6.org
Cc: ajtuomin@morphine.tml.hut.fi, davem@redhat.com, kuznet@ms2.inr.ac.ru,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com, pekkas@netcore.fi,
       torvalds@transmeta.com, "Venkata Jagana" <jagana@us.ibm.com>,
       yoshfuji@linux-ipv6.org
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OFAE12FFFA.084238B4-ON88256C55.0060FC98@boulder.ibm.com>
From: "Krishna Kumar" <kumarkr@us.ibm.com>
Date: Thu, 17 Oct 2002 10:46:00 -0700
X-MIMETrack: Serialize by Router on D03NM801/03/M/IBM(Release 5.0.10 |March 22, 2002) at
 10/17/2002 11:47:33 AM
MIME-Version: 1.0
Content-type: text/plain; charset=iso-2022-jp
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi yoshifuji,

> [network_mods etc.]
>
>  1. Too many hooks,
>     and many duplicate codes in ipv6 stack and mipv6 stack.
>     (prefix handler, header parser, ndisc handler etc...)

What do you mean about having too many hooks ? Eg. prefix handler, you need
to have a hook in the receive of router advertisement to do this. This is
minimum hooks :-). Also, some of the ndisc handlers evaluate to NULL code
for both regular IPv6 code (unless you have configured mobility) as well as
some components of Mobile IPv6. Eg ndisc_mipv6_mn_solicit_ha() evaluates to
NULL on HA and CN, but is a function call on every MN node. So I don't
understand your concern here.

Thanks,

- KK



                                                                                                                                          
                      YOSHIFUJI Hideaki                                                                                                   
                      / 吉藤英明               To:       ajtuomin@morphine.tml.hut.fi                                                     
                      <yoshfuji@linux-i        cc:       davem@redhat.com, kuznet@ms2.inr.ac.ru, netdev@oss.sgi.com,                      
                      pv6.org>                  linux-kernel@vger.kernel.org, pekkas@netcore.fi, torvalds@transmeta.com, Venkata          
                      Sent by:                  Jagana/Beaverton/IBM@IBMUS, yoshfuji@linux-ipv6.org                                       
                      netdev-bounce@oss        Subject:  Re: [PATCHSET] Mobile IPv6 for 2.5.43                                            
                      .sgi.com                                                                                                            
                                                                                                                                          
                                                                                                                                          
                      10/17/2002 10:18                                                                                                    
                      AM                                                                                                                  
                                                                                                                                          
                                                                                                                                          



In article <20021017162624.GC16370@morphine.tml.hut.fi> (at Thu, 17 Oct
2002 19:26:25 +0300), Antti Tuominen <ajtuomin@morphine.tml.hut.fi> says:

> The patch has been split for easier reading as follows:
>
> ipv6_tunnel.patch            6over6 tunneling
> network_mods.patch           Modifications to network code and hooks

Several comments.

[ipv6_tunnel]

I think this is almost ok.

  1. I believe s/ARPHRD_IPV6_IPV6_TUNNEL/ARPHRD_TUNNEL6/.
  2. Please put outer address to hardware address in dev.
     Note: you need to modify SIOxxx ioctls too not to overrun!

[network_mods etc.]

  1. Too many hooks,
     and many duplicate codes in ipv6 stack and mipv6 stack.
     (prefix handler, header parser, ndisc handler etc...)

more comment will come later...


> http://www.mipl.mediapoli.com/patches/mipv6_cn_support.patch
> http://www.mipl.mediapoli.com/patches/mipv6_mn_support.patch
> http://www.mipl.mediapoli.com/patches/mipv6_ha_support.patch

Well, I can't find them. I hope they'll be available when I wake up
tomorrow...

--
Hideaki YOSHIFUJI @ USAGI Project <yoshfuji@linux-ipv6.org>
GPG FP: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA









