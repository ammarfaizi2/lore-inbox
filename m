Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129355AbRBPMei>; Fri, 16 Feb 2001 07:34:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129384AbRBPMe3>; Fri, 16 Feb 2001 07:34:29 -0500
Received: from ausmtp02.au.ibm.COM ([202.135.136.105]:27920 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP
	id <S129355AbRBPMeW>; Fri, 16 Feb 2001 07:34:22 -0500
From: aprasad@in.ibm.com
X-Lotus-FromDomain: IBMIN@IBMAU
To: linux-kernel@vger.kernel.org
Message-ID: <CA2569F5.0045056E.00@d73mta05.au.ibm.com>
Date: Fri, 16 Feb 2001 17:56:55 +0530
Subject: query about sending udp packets in kernel mode
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

I need to send  udp packets in a kernel module. but i am unable to figure
out how to specify fill the struct msghdr to be used by the sendmsg handler
of the socket.

my skeleton is something like (by going through the kernel code:>)

struct socket *sock;
struct sockaddr_in sin;
struct msghdr msg;

sock_creat(PF_INET, SOCK_DGRAM, IPPROTO_UDP, &sock);
sin.sin_family = AF_INET;
sin.sin_port = htons((unsigned short)serv_port);
sin.sin_addr.s_addr = htonl(INADDR_ANY); /*i am not sure about this*/

msg.msg_name = &sin;
msg.msglen = sizeof(struct sockaddr_in);
msg.msg_iov = iovec_containg the message;
msg.msg_iovlen = 1;
msg.msg_control = NULL;
msg.msg_controllen=0;
msg.msg_flags =0;

sock->ops->sendmsg(sock,&msg,count,0);
________________________________________________


i am getting EFAULT.

or can anybody suggest me how to fill the address field of sin_addr in
kernel of any known remote address(corresponding inet_addr) so that
sendto/send can be used.
Any pointers will be greatly appreciated.

Thanks,
Anil.


