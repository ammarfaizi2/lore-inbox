Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265836AbSKBA1H>; Fri, 1 Nov 2002 19:27:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265835AbSKBA1H>; Fri, 1 Nov 2002 19:27:07 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:65202 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S265836AbSKBA1F>;
	Fri, 1 Nov 2002 19:27:05 -0500
From: "Venkata Jagana" <jagana@us.ibm.com>
Importance: Normal
Sensitivity: 
Subject: Re: [PATCHSET] Mobile IPv6 for 2.5.45
To: "David S. Miller" <davem@redhat.com>
Cc: yoshfuji@wide.ad.jp, kkumar@beaverton.ibm.com, kuznet@ms2.inr.ac.ru,
       ajtuomin@tml.hut.fi, lpetande@tml.hut.fi, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.3 (Intl) 21 March 2000
Message-ID: <OF5B9EF40F.E3D52B05-ON88256C65.000191C7@boulder.ibm.com>
Date: Fri, 1 Nov 2002 16:32:13 -0800
X-MIMETrack: Serialize by Router on D03NM036/03/M/IBM(Release 5.0.10 |March 22, 2002) at
 11/01/2002 05:32:21 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Hello Dave,

>Just like a router changes and monitors routes, a home agent daemon
>would change and monitor mipv6 state.  So for the same reason we don't
>put OSPF routing databases into the kernel, we do not put the home
>agent registration into the kernel :-)

I absolutely understand your concerns about keeping the Home Agent
registration in the kernel. However, I still believe that keeping
this code in userspace would cause problems for handoffs. (btw, this
code will never get executed on a regular host - only routers configured
as Home Agents would be running this code as a module).

Currently, when a Home Agent receives a registration request during the
Mobile Node's handoff mechanism, it needs to respond in a reasonably
quick time period so that the sessions on the MN can continue without
experiencing delays. Longer delays could be harmful for applications
such as VoIP, for which the latencies are quite critical.

By moving this registration process to userspace, we have no control
over when the home registration would complete, since there are no
guarantees when the home agent daemon would run. BTW, according to
ongoing discussions at Mobile IP WG, it is believed that even few
hundred millisecs of latencies are not acceptable to critical apps,
during which time the IP packet transfer is completely stopped.
With such latency issues, I still believe that moving the registration
to userspace would create issues for the MN.

Thanks,
Venkat

----------------------------------------------------------------
Venkata R Jagana
IBM Linux Technology Centre, Beaverton
jagana@us.ibm.com
Tel: (503) 578 3430 T/L 775-3430



