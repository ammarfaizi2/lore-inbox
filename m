Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292894AbSCEFjz>; Tue, 5 Mar 2002 00:39:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292927AbSCEFjf>; Tue, 5 Mar 2002 00:39:35 -0500
Received: from ux10.cso.uiuc.edu ([128.174.5.79]:1514 "EHLO ux10.cso.uiuc.edu")
	by vger.kernel.org with ESMTP id <S292894AbSCEFj2>;
	Tue, 5 Mar 2002 00:39:28 -0500
Date: Mon, 4 Mar 2002 23:39:27 -0600 (CST)
From: binita gupta <binita@students.uiuc.edu>
X-X-Sender: <binita@ux10.cso.uiuc.edu>
To: <linux-kernel@vger.kernel.org>
Subject: IP drops re-injected packets !!!
Message-ID: <Pine.GSO.4.31.0203042336130.11928-100000@ux10.cso.uiuc.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am trying to implement an on demand routing protocol for ad-hoc
wireless networks. for this I intercept packets at the IP layer
(using netfilter), queue them in the user space and reinject them
(after route has been discovered) at the IP layer using tun device.

Everyting works fine except that IP drops the re-injected packets.
Basically "fib_validate_source" drops all the packets with local address
as the source address and this is the reason why all the reinjected
packets are being dropped. I could get away with this problem by modifying
fib_validate_source function in fin_frontend.c file as follows:

--if(res.type != RTN_UNICAST)
++if((res.type != RTN_UNICAST) && (res.type != RTN_LOCAL))

I am just wondering if this is the right fix for the problem or should
this be handled in some other way?

In any case I am not clear how the current kernel handles the reinjected
packets which are generated locally? Is this a bug in the kernel or am I
missing something here?

any clarifications will be highly appreciated.

Thanx,
-Binita

