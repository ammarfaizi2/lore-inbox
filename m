Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262503AbUDHUIH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 16:08:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262518AbUDHUHq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 16:07:46 -0400
Received: from imr1.ericy.com ([198.24.6.9]:46821 "EHLO imr1.ericy.com")
	by vger.kernel.org with ESMTP id S262503AbUDHTzV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 15:55:21 -0400
Message-ID: <019e01c41da3$36aae260$0348858e@D4SF2B21>
From: "Mathieu Giguere" <Mathieu.Giguere@ericsson.ca>
To: <linux-kernel@vger.kernel.org>, "David S. Miller" <davem@redhat.com>
Cc: <ak@muc.de>, <netdev@oss.sgi.com>
Subject: RE: IPv4 and IPv6 stack multi-FIB, scalable in the million of entries.
Date: Thu, 8 Apr 2004 15:53:50 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Hi,

     Just run the join script on your favorite 2.4 kernel.

 RTNETLINK answers: Cannot allocate memory
 RTNETLINK answers: Cannot allocate memory
 RTNETLINK answers: Cannot allocate memory
 [root@tom tmp]# ip -6 route | wc -l
    4094
 [root@tom tmp]#


     And after 4094 IPv6 routes you will the get the same.

     For the PMTU, the info can't be retain in the route himself.  The PTMU
 is base on DIP not on the current network routing.  So it must be kept in a
 separate hash struct with expire time.  _BUT_ you must not flush all the
 entries each time a route is added or  deleted like in the current
 implementation.

 /mathieu


 -------------------------------
 #!/bin/csh
 echo #!/bin/sh
 set addr1=0
 set addr2=1
 while ($addr1 < 256)
   while ($addr2 < 256)
     echo ip -f inet6 route add 2000:${addr1}::${addr2}/128 dev eth0
     @ addr2++
   end
   set addr2=0
   @ addr1++
 end


 ----- Original Message ----- 
 From: "David S. Miller" <davem@redhat.com>
 To: "Mathieu Giguere" <Mathieu.Giguere@ericsson.ca>
 Cc: <ak@muc.de>; <netdev@oss.sgi.com>; <linux-kernel@vger.kernel.org>
 Sent: Thursday, April 08, 2004 2:33 PM
 Subject: Re: IPv4 and IPv6 stack multi-FIB, scalable in the million of
 entries.


 > On Thu, 8 Apr 2004 14:10:43 -0400
 > "Mathieu Giguere" <Mathieu.Giguere@ericsson.ca> wrote:
 >
 > > The main goal to remove the routing cache is to avoid to have 4096
 routes
 > > limitation
 >
 > This 4K routes limitation is news to everyone who works on this
 > code.
 >
 > When nexthop changes we _MUST_ flush PMTU etc. information because that
 > could have changed.  If however, such information is locked into the
 > route itself, it will propagate immediately into the routing cache
 > entry once recreated.
 >
 > You seem to be talking about a lot of non-problems, but this may because
 > you're not providing enough details.
 >

