Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317326AbSHYMRw>; Sun, 25 Aug 2002 08:17:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317329AbSHYMRw>; Sun, 25 Aug 2002 08:17:52 -0400
Received: from imo-m08.mx.aol.com ([64.12.136.163]:32194 "EHLO
	imo-m08.mx.aol.com") by vger.kernel.org with ESMTP
	id <S317326AbSHYMRv>; Sun, 25 Aug 2002 08:17:51 -0400
Date: Sun, 25 Aug 2002 08:19:37 -0400
From: chakria@netscape.net
To: linux-kernel@vger.kernel.org
Subject: Could not set Traffic Class of IPv6 header in RH 7.3 using TCP socket
Message-ID: <0E0BF6E0.6EA33A81.001DBEA3@netscape.net>
X-Mailer: Atlas Mailer 2.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
 
Am trying to set TC value of IPv6 header for TCP transmission at the application level using sockets mechanism.
The code goes like this:
 
struct sockaddr_in6 servAddr6;
UINT1 tclass = 10 /* Equivalent for DSCP value af11 */
...
...
 
servAddr6.sin6_flowinfo = htons ((tclass << 4) | IPV6_FLOWINFO_PRIORITY);
...
...
connect (sd, &servAddr6, ...);
...
 
In RH 7.1, the above code works fine for all the DSCP values set. In RH7.3, the behaviour is different.
 
I list below the behaviour phenomenon.
When tclass is assigned the values: 1, 2 or 3, the actual value set will be 0
When tclass is assigned the values: 5, 6 or 7, the actual value set will be 4
When tclass is assigned the values: 9, 10 or 11, the actual value set will be 8 and so on.
 
Otherwise, for tclass values 0, 4, 8 etc, the values are set correctly for the Prioirty field of the IPv6 header.
 
What could be the reason for the above behaviour? Could anybody give me the hint if i am doing anything wrong? The above behaviour happens in RH7.3. The same code works fine in RH 7.1
 
Also, i tried investigating the difference between RH7.1 and RH 7.3. I observed the following:
 
In RH7.1, in tcp_v6_connect() function of linux-2.4/net/ipv6/tcp_ipv6.c, a macro IP6_ECN_flow_init (label) is called which is defined as follows:
 
#ifdef CONFIG_INET_ECN
#define IP6_ECN_flow_init (label) do { \
(label) &= ~htonl (3<<20); \
} while (0)
 
#else
#define IP6_ECN_flow_init (label) do { } while (0)
#endif
 
In my machine CONFIG_INET_ECN is not defined. So, in RH7.1, the macro IP6_ECN_flow_init does nothing.
But in RH 7.3, the above definition of the macro is always defined irrespective of whether CONFIG_INET_ECN is defined or not. 
I observed that this defintion of the macro changes the Traffic Value i set before calling connect () socket call.
 
Could anybody guide me why is it like this?  Is my understanding correct regarding this? Is there any way that i can set the traffic class correctly?
 
Thanks in advance.
Kindly CC the reply to my mail ID.
 
Regards,
Chakri



__________________________________________________________________
Your favorite stores, helpful shopping tools and great gift ideas. Experience the convenience of buying online with Shop@Netscape! http://shopnow.netscape.com/

Get your own FREE, personal Netscape Mail account today at http://webmail.netscape.com/

