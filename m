Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261965AbTELHJV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 03:09:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261968AbTELHJV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 03:09:21 -0400
Received: from mail9.atl.registeredsite.com ([64.224.219.83]:2878 "EHLO
	mail9.atl.registeredsite.com") by vger.kernel.org with ESMTP
	id S261965AbTELHJU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 03:09:20 -0400
Subject: problems with using multicast
From: "Shantanu.Gogate" <shantanu.gogate@wibhu.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1052723893.1807.54.camel@Jughead.Wibhu>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 12 May 2003 12:48:13 +0530
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
    I am trying to use multicast in an application which. I am running
kernel 2.4.19.I have interfaces lo, and eth0 on bootup.  Here is what I
am trying to do...

When i try to create a socket which becomes a member of a multicast
group by specifying the grp address and using INADDR_ANY as the
interface to use, i am able to receive packets sent out the multicast
group. However if i specifically bind it to the address of eth0 and then
try to receive packets...i am not getting any....The only other
interfaces i have are lo. I cant explain why it is working when i use
INADDR_ANY and does not receive packets when i use the specific address
of the device....

the code for this socket init looks as follows ...i have removed error
handling for readability right now
--------------
         server_socket = socket(AF_INET, SOCK_DGRAM,0);
  
         memset(&saddr,0,sizeof(struct sockaddr_in));
         saddr.sin_family = AF_INET;
         saddr.sin_addr.s_addr = htonl(INADDR_ANY);
         saddr.sin_port = port;

        bind(server_socket, (struct sockaddr *) &saddr, sizeof(saddr);
        
on=1;
setsockopt(server_socket,SOL_SOCKET,SO_REUSEADDR,&on,sizeof(on));

        mreq.imr_multiaddr.s_addr = mcast_addr;
        mreq.imr_interface.s_addr = htonl(INADDR_ANY);
       
setsockopt(server_socket,SOL_IP,IP_ADD_MEMBERSHIP,&mreq,sizeof(mreq))

ttl = 1;
setsockopt(server_socket, IPPROTO_IP, IP_MULTICAST_TTL,&ttl,sizeof(ttl))

loop = 0;
setsockoptserver_socket,IPPROTO_IP,IP_MULTICAST_LOOP,&loop,sizeof(loop))

return server_socket;
----------------------------------      
if i replace INADDR_ANY with the actual interface address which i get
using ioctl, then i cant receive any packets... However when i see the
dump from tcpdump i can see the packets coming in, but for some reason
they are not reaching the socket which had become a member. I can also
see that the group membership was added if i do netstat -g


I would appreciate any help.

Thanks and regards,
Shantanu.

