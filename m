Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132500AbREHNCN>; Tue, 8 May 2001 09:02:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132503AbREHNCE>; Tue, 8 May 2001 09:02:04 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:25868 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132500AbREHNBw>; Tue, 8 May 2001 09:01:52 -0400
Subject: Re: [RFC] Direct Sockets Support??
To: knicholson@corp.iready.com (Ken Nicholson)
Date: Tue, 8 May 2001 14:04:45 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk ('Alan Cox'), Venkateshr@ami.com,
        pollard@tomcat.admin.navo.hpc.mil, linux-kernel@vger.kernel.org
In-Reply-To: <034670D62D19D31180990090277A37B701811D72@mercury.corp.iready.com> from "Ken Nicholson" at May 07, 2001 06:55:08 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14x7AW-0005bf-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> A couple of concerns I have:
>  * How to pin or pagelock the application buffer without
> making a kernel transition.

You need to pin them in advance. And pinning pages is _expensive_ so you dont
want to keep pinning/unpinning pages

>  * Assuming the memory can be locked down, how can a list 
> of physical memory ranges be obtained (necessary to support 
> scatter/gather DMA? Is kiobufs suitable with it's page-alignment 
> constraints? If kiobufs will work, how can the kernel transition be 
> avoided?

kiovecs will do that. It might be a little heavyweight but that should improve
in 2.5 as we move to a slightly lighter model

> WinSock Direct seems to address these concerns.  These issues
> become important at 1Gb and 10Gb speeds.

1Gbit - not really, 10Gbit yes
