Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265847AbSKBBM0>; Fri, 1 Nov 2002 20:12:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265849AbSKBBM0>; Fri, 1 Nov 2002 20:12:26 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.106]:36595 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S265847AbSKBBMZ>;
	Fri, 1 Nov 2002 20:12:25 -0500
Subject: Re: [PATCHSET] Mobile IPv6 for 2.5.45
To: "David S. Miller" <davem@redhat.com>
Cc: ajtuomin@tml.hut.fi, kkumar@beaverton.ibm.com.sgi.com,
       kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org, lpetande@tml.hut.fi,
       netdev@oss.sgi.com, "Venkata Jagana" <jagana@us.ibm.com>,
       yoshfuji@wide.ad.jp
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OFCFEE31E7.E8F27031-ON88256C65.00068E7B@boulder.ibm.com>
From: "Krishna Kumar" <kumarkr@us.ibm.com>
Date: Fri, 1 Nov 2002 17:15:09 -0800
X-MIMETrack: Serialize by Router on D03NM801/03/M/IBM(Release 5.0.10 |March 22, 2002) at
 11/01/2002 06:17:54 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Dave,

> None of the things you've listed make it desirable to put the home
> agent registration into the kernel.  All of the operations you
> describe could be invoked by the userland home agent daemon using very
> minimal glue logic in the kernel (invoked, for example, via netlink
> messages).

I had a couple of comments about putting the registration part in
userspace.
When the HA gets a registration request, it needs to perform the following
actions :
        1. perform DAD
        2. get the list of prefixes supported on the home link of the MN.
        3. create a tunnel between the HA and the MN
        4. join the solicited node multicast group of the MN's home
address.
        5. add the MN's home address to the list of proxy neigh cache entry
for the HA.
        6. Send NA on behalf of the MN
        7. add the new location of the MN in the binding cache.
        8. and finally send the Binding Registration Success/Failure
message.

In the above list, the only activities which can be done in userspace are
#7 and #8 (that I am aware of). The rest of the items can only be done in
the
kernel, atleast we need to move the support to kernel. If the HA
registration
is completely moved to userspace, it would still need these facilities (#1
to #6) in the kernel to perform the actions for registration. So even with
netlink
we still need the infrastructure in the kernel.

We can move the #7 and #8 pieces to userspace, but that is a relatively
small code, and is it worth doing that ?

Overall I feel that this should still be part of the kernel...

Thanks,

- KK



