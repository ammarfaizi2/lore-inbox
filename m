Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265894AbSKBIaM>; Sat, 2 Nov 2002 03:30:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265895AbSKBIaM>; Sat, 2 Nov 2002 03:30:12 -0500
Received: from netcore.fi ([193.94.160.1]:14097 "EHLO netcore.fi")
	by vger.kernel.org with ESMTP id <S265894AbSKBIaL>;
	Sat, 2 Nov 2002 03:30:11 -0500
Date: Sat, 2 Nov 2002 10:36:09 +0200 (EET)
From: Pekka Savola <pekkas@netcore.fi>
To: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
cc: kumarkr@us.ibm.com, <davem@redhat.com>, <ajtuomin@tml.hut.fi>,
       <kkumar@beaverton.ibm.com.sgi.com>, <kuznet@ms2.inr.ac.ru>,
       <linux-kernel@vger.kernel.org>, <lpetande@tml.hut.fi>,
       <netdev@oss.sgi.com>, <jagana@us.ibm.com>
Subject: Re: [PATCHSET] Mobile IPv6 for 2.5.45
In-Reply-To: <20021102.120019.45396269.yoshfuji@linux-ipv6.org>
Message-ID: <Pine.LNX.4.44.0211021031230.10197-100000@netcore.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I believe there could be more hooks in the kernel to let userspace do 
certain tasks, for example, sending router solicitations and processing 
the responses -- sure, this can be done in the userspace but means code 
duplication.  If the code in the kernel could also be called from the 
userspace, there might be less need for duplication (though this would 
result in portability issues of course).

Similar would appear to be the case some other features listed here.

On Sat, 2 Nov 2002, YOSHIFUJI Hideaki / [iso-2022-jp] 吉藤英明 wrote:
> In article <OFCFEE31E7.E8F27031-ON88256C65.00068E7B@boulder.ibm.com> (at Fri, 1 Nov 2002 17:15:09 -0800), "Krishna Kumar" <kumarkr@us.ibm.com> says:
> 
> > When the HA gets a registration request, it needs to perform the following
> > actions :
> >         1. perform DAD
> >         2. get the list of prefixes supported on the home link of the MN.
> >         3. create a tunnel between the HA and the MN
> >         4. join the solicited node multicast group of the MN's home
> > address.
> >         5. add the MN's home address to the list of proxy neigh cache entry
> > for the HA.
> >         6. Send NA on behalf of the MN
> >         7. add the new location of the MN in the binding cache.
> >         8. and finally send the Binding Registration Success/Failure
> > message.
> > 
> > In the above list, the only activities which can be done in userspace are
> > #7 and #8 (that I am aware of). The rest of the items can only be done in
> > the
> > kernel, atleast we need to move the support to kernel. If the HA
> > registration
> > is completely moved to userspace, it would still need these facilities (#1
> > to #6) in the kernel to perform the actions for registration. So even with
> > netlink
> > we still need the infrastructure in the kernel.
> 
> 1:     True:  we need some interface (and small code)
> 2:     FALSE: you CAN listen icmp6 message via raw socket.
> 3:     FALSE: you CAN create tunnel using raw socket;
>               however, we think this is implemented in kernel.
> 4,5,6: True:  we need some interface to generate proxy ND.
>               (proxy ND is already in kernel.)
> 
> For 1,4,5,6: "proxy address" on a device would be a solution.

-- 
Pekka Savola                 "Tell me of difficulties surmounted,
Netcore Oy                   not those you stumble over and fall"
Systems. Networks. Security.  -- Robert Jordan: A Crown of Swords

