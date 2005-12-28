Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932526AbVL1KNz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932526AbVL1KNz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 05:13:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932524AbVL1KNy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 05:13:54 -0500
Received: from web8318.mail.in.yahoo.com ([202.43.219.53]:28849 "HELO
	web8318.mail.in.yahoo.com") by vger.kernel.org with SMTP
	id S932526AbVL1KNy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 05:13:54 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.co.in;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=wXNydz8petmQ5GSRCvd2Y//HXFZ0py90AQH1tXkfmqIHj1o5Mv2tQRVhFhiHbN5D/I80tqwjZstHdqaFmz5BXAJBIJCCZk0RqIVeh4brjc81dZD7iHOtct5lAkW5K9REv/BYq4tvU9ADev6spHJStM8EpMQNrhJ7iq9gLWYrwkU=  ;
Message-ID: <20051228101528.50347.qmail@web8318.mail.in.yahoo.com>
Date: Wed, 28 Dec 2005 10:15:28 +0000 (GMT)
From: Satinder <jeet_sat12@yahoo.co.in>
Subject: [Query] regarding sock_ioctl in linux kernel
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Hi everybody,


I was viewing the linux source code (version 2.6.9 )
for socket APIs.

in function sock_ioctl() [file net/socket.c.]
I found that the kernel is handling the socket pointer
without any check.
Even in 'default' case it is calling
sock->ops->ioctl() without checking whether the
sock->ops having value or not.

Is this assumed that the kernel will call the
sock_ioctl only when the socket data structure/ file
structure/socket substructure  exists, or there is
some other reason for not putting checks before
calling file operations in sock_ioctl

There may be case when someone may alloc socket in
init module and map it to file descriptor using
sock_map_fd() and increament its reference count using
fget().

And at cleanup time it releases the socket using
sock_release() without unmaping file descriptor and
decreamenting the referenece count.

and  socket->file would be NULL without freeing the
inode number when sock_release returns. So at reboot
time many network process may try to use this socket
beacause inode is not being  released. In this case
kernel may crash.?

If anyone could explain this that would be very nice.
Please keep me in cc.
TIA

Regards,
Satinder

Send instant messages to your online friends http://in.messenger.yahoo.com 
