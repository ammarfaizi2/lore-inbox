Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261448AbUBWMYO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 07:24:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261695AbUBWMYO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 07:24:14 -0500
Received: from mta02-svc.ntlworld.com ([62.253.162.42]:27228 "EHLO
	mta02-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id S261448AbUBWMYM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 07:24:12 -0500
Date: Mon, 23 Feb 2004 12:24:10 +0000
From: Graham Swallow <Information-Cascade@ntlworld.com>
To: linux-kernel@vger.kernel.org
Subject: /proc/kmsg  blocks with O_NONBLOCK, read() should return 0 with EAGAIN
Message-Id: <20040223122410.6eb44df1.Information-Cascade@ntlworld.com>
X-Mailer: Sylpheed version 0.7.1 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

/proc/kmsg  blocks with O_NONBLOCK, read() should return 0 with EAGAIN

	fd = open( "/proc/kmsg", O_RDONLY|O_NONBLOCK );
	...
	poll() -- says read it

	len = read(fd,buff,len); // first read is fine
	...
	len = read(fd,buff,len); // second read blocks

I call read() a second time, because I'm feeling lucky,
(this is library code, which also reads from sockets).

I expected it to return 0 with errno==EAGAIN.
Instead it waits:  do_syslog(2,buf,count); 

I'm not on this list, so please raise a ticket, linux-2.4.23,

   thanks
--
   Graham
   Information-Cascade (at) ntlworld.com
