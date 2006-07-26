Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030445AbWGZG7o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030445AbWGZG7o (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 02:59:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030446AbWGZG7o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 02:59:44 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:45699 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1030445AbWGZG7n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 02:59:43 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:organization:user-agent:mime-version:to:subject:content-type:content-transfer-encoding:from;
        b=tPuUuLgem5Vy8vyF9hO3wumciUOpOtB3gYywr0YzAxaI/tghDWMIWQ4f7ooqLU2KWkV8a1XqTBM2RqubVJOGL6s5tJz46VLyWoV0QYLF1pDSBr748qc72TVxoUSOBSSRpVGGjbBqcMZ0BMGXN3OuLhcL121YReK6iu1R7h3ihGk=
Message-ID: <44C71475.5060005@innomedia.soft.net>
Date: Wed, 26 Jul 2006 12:36:29 +0530
Reply-To: chinmaya@innomedia.soft.net
Organization: Innomedia Technologies Pvt. Ltd.
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: undisclosed-recipients:;
Subject: setsockopt -  SO_REUSEADDR
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
From: Chinmaya Mishra <chinmaya4@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I am creating a socket in kernel. It is able to bind. But after abnormal
termination of the module, I am not able to bind the socket once again. 
Here i use

.......................................................................
/* create a socket */
if ((err = sock_create(AF_INET, SOCK_DGRAM, IPPROTO_UDP, &sock)) < 0) {
    printk(KERN_INFO MODULE_NAME": Could not create a datagram socket, 
error = %d\n", -ENXIO);
    return;
}

if((err = sock->ops->setsockopt(sock, SOL_SOCKET, SO_REUSEADDR, 
(void*)&option, sizeof(option)))<0)
             printk(KERN_INFO MODULE_NAME": Error in set socket opt for 
SO_REUSEADDR \n");

memset(&addr, 0, sizeof(struct sockaddr));
addr.sin_family = AF_INET;
addr.sin_addr.s_addr = htonl(INADDR_ANY);
addr.sin_port = htons(7006);

if ((err = sock->ops->bind(sock, (struct sockaddr *)&addr, sizeof(struct 
sockaddr)))< 0)
{
    printk(KERN_INFO MODULE_NAME": Could not bind to socket, error = 
%d\n", -err);
    goto close_and_out;
}
 printk(KERN_INFO MODULE_NAME": listening on port %d\n", 7006);
...................................................................

It throwing the following error
    Error in set socket opt for SO_REUSEADDR
    Could not bind to socket, error = 98


Can you tell me what i am missing. Just I want to reuse the bind same 
address once again in the
same port.


Thanks.
Chinmaya
