Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131322AbRBQLDt>; Sat, 17 Feb 2001 06:03:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131196AbRBQLDj>; Sat, 17 Feb 2001 06:03:39 -0500
Received: from quechua.inka.de ([212.227.14.2]:24925 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S131322AbRBQLDY>;
	Sat, 17 Feb 2001 06:03:24 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: query about sending udp packets in kernel mode
In-Reply-To: <CA2569F5.0045056E.00@d73mta05.au.ibm.com>
Organization: private Linux site, southern Germany
Date: Sat, 17 Feb 2001 11:44:25 +0100
From: Olaf Titz <olaf@bigred.inka.de>
Message-Id: <E14U4qu-0008Ku-00@g212.hadiko.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> sock_creat(PF_INET, SOCK_DGRAM, IPPROTO_UDP, &sock);
> sin.sin_family = AF_INET;
> sin.sin_port = htons((unsigned short)serv_port);
> sin.sin_addr.s_addr = htonl(INADDR_ANY); /*i am not sure about this*/

Needs the target IP address here.

> msg.msg_name = &sin;
> msg.msglen = sizeof(struct sockaddr_in);
> msg.msg_iov = iovec_containg the message;
> msg.msg_iovlen = 1;
> msg.msg_control = NULL;
> msg.msg_controllen=0;
> msg.msg_flags =0;

  { mm_segment_t fs=get_fs();
    set_fs(get_ds());

> sock->ops->sendmsg(sock,&msg,count,0);

    set_fs(fs); }

"count" needs to be the total length of the message. The 0 is
redundant, sendmsg() takes only three arguments since Linux 2.1 (five
under 2.0).

Olaf
