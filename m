Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285357AbRLGBG7>; Thu, 6 Dec 2001 20:06:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285360AbRLGBGu>; Thu, 6 Dec 2001 20:06:50 -0500
Received: from mercury.Sun.COM ([192.9.25.1]:217 "EHLO mercury.Sun.COM")
	by vger.kernel.org with ESMTP id <S285358AbRLGBGq>;
	Thu, 6 Dec 2001 20:06:46 -0500
Message-ID: <3C1015EC.5B7316A0@sun.com>
Date: Thu, 06 Dec 2001 17:05:48 -0800
From: Tim Hockin <thockin@sun.com>
Organization: Sun Microsystems, Inc.
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.12C5_V i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@mandrakesoft.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        arjanv@redhat.com, saw@sw-soft.com, sparker@sparker.net
Subject: Re: [PATCH] eepro100 - need testers
In-Reply-To: <E16C81m-0003Zm-00@the-village.bc.nu> <3C10011A.A16E5287@mandrakesoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
 
> This patch got me thinking about net driver ring sizes in general.  When
> you are talking thousands of packets per second at 100 mbit, a larger
> ring size than the average 32-64 seems to make sense too.

Well, the math for teh very worst case is something like: 

100,000,000  bits/sec
/8 
= 12500000  bytes/sec
/64  bytes/ping
= 195312.5  ping/sec
/100
= 1953 ping/jiffy
rounded to 2048
/2 = 1024 rx buffers per 1/2 jiffie.  

1024 means you can withstand a wire-speed storm while interrupting twice
per jiffy.


-- 
Tim Hockin
Systems Software Engineer
Sun Microsystems, Cobalt Server Appliances
thockin@sun.com
