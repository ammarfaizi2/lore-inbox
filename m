Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261684AbUJYLk4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261684AbUJYLk4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 07:40:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261699AbUJYLk4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 07:40:56 -0400
Received: from wproxy.gmail.com ([64.233.184.205]:27033 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261684AbUJYLkr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 07:40:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=Pvez8VY9m5iISNW+p/qUJ764CdKxCNaL1jSc7oxLCXMPkXuO4wASRXRj5nNCQodjX4DzaGT/cD9HA7RjBuX1xrMNN64P+xgDw2LOwnCC9uNgJYCfODlChyHwlksXKioP4b0b1LfzGpAmh8LHQ5Z8Hrpc1Z+bUHX5Ym9CCCiO2LE=
Message-ID: <605a56ed04102504401e0f469f@mail.gmail.com>
Date: Mon, 25 Oct 2004 13:40:47 +0200
From: Arne Henrichsen <ahenric@gmail.com>
Reply-To: Arne Henrichsen <ahenric@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Problems with close() system call
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a question regarding the close() system call. I have written my
own character driver for a serial type card with 8 ports. Each port is
seen as a device by Linux. Everything works great, I can open, close,
write, read etc from/to the individual devices. But I also see some
strange things. When I for instance in my user application open and
configure each device (via ioctl) in a loop, somehow a close system
call has been initiated (not called by my user app). I can see this as
my drivers flush function get called. Who or why is this function
called without my user app even calling close()? Is it related to the
module count of each device? I print out the counter
(filp->f_count.counter), and I do not know how it gets
incremented/decremented. The release call is also supposed to get
called after the user is finished, but is never called which I guess
has something to do with the user count not being zero.

I will see in my driver:

open dev 0
ioctl dev 0
open dev 1
flush dev 0
ioctl dev 1
open dev 2
flush dev 1
etc

Could anybody shed some light on this issue please?

Thanks
Arne
