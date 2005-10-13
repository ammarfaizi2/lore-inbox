Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751596AbVJMSlz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751596AbVJMSlz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Oct 2005 14:41:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751598AbVJMSlz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Oct 2005 14:41:55 -0400
Received: from zproxy.gmail.com ([64.233.162.202]:58423 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751524AbVJMSlz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Oct 2005 14:41:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=ZB0UuqJONT88nys8S4Wopfp1FPEShw9fEGKxWbMYV/X+nmBQZMGh+uDJn/IZg3fC8+UMrN2T8a4CyqD1l4WxUbR6d0KsUDyeeah3WRPcIebISDpTuRET+Ekn2LqfCjGIgQihPzAP9XVJPkkuiMWeDHnqXYHS1MORyNnqXocp+fI=
Message-ID: <6fc1f4490510131141y15114b88qaa176d2f2af69b8c@mail.gmail.com>
Date: Thu, 13 Oct 2005 20:41:42 +0200
From: Aviv Grafi <agrafi@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: multiple sendmsg and single user-kernel switch
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
 I want to use the sendto (or sendmsg) for sending raw packets on a raw
 socket directly to the NIC (passing the kernel protocol stack).
 In addition to that i need so send a lot of packets (100-200Kpps) so i
 have to do that fast.
 Currently the kernel-user switching is killing me and i want to batch
 some packets before calling send() - to reduce the user-kernel switch
 overhead.
 Passing a batched buffer to the sendto() cause a probelm - the NIC have
 to get one message at a time because it has to calculate the L2 CRC for
 each packet (or msg). so batched buffer is not acceptable.

 I would like to get some help please. any one have any idea how to
 reduce the user-kernel overhead (or sending a batched buffer so the
 kernel will call sendto for each buffer)?

 Thanks,
 Aviv
