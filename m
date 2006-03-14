Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750852AbWCNSpZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750852AbWCNSpZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 13:45:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751759AbWCNSpZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 13:45:25 -0500
Received: from tag.witbe.net ([81.88.96.48]:4313 "EHLO tag.witbe.net")
	by vger.kernel.org with ESMTP id S1750852AbWCNSpY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 13:45:24 -0500
From: "Paul Rolland" <rol@witbe.net>
To: "'Paul Jackson'" <pj@sgi.com>, "'Paul Rolland'" <rol@witbe.net>
Cc: <hancockr@shaw.ca>, <kernel@wildsau.enemy.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: procfs uglyness caused by "cat"
Date: Tue, 14 Mar 2006 19:45:15 +0100
Organization: Witbe.net
Message-ID: <007301c64797$6f63e7d0$b600a8c0@cortex>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
Thread-Index: AcZHkRtFFiZoAuDRTsy/hI5otJdA0gABa9OA
In-Reply-To: <20060314095940.7be639e7.pj@sgi.com>
x-ncc-regid: fr.witbe
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> main()
> {
>     char c;
>     int fd = open("/proc/uptime", 0);
>     while (read(fd, &c, 1) == 1) {
>         write(1, &c, 1);
>         sleep(1);
>     }
> }

Yes, much better, same result for 2.2.x and 2.4.31 :
bash-2.05# cat /proc/uptime; ./test2  
112049.81 111665.11
112054.89 111670.29

The result is more "correct", but I guess this makes it worse for
Herbert, as uptime_read_proc() is then called for each character...

Paul

