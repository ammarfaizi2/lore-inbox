Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264973AbSKERQ4>; Tue, 5 Nov 2002 12:16:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264974AbSKERQ4>; Tue, 5 Nov 2002 12:16:56 -0500
Received: from atlrel8.hp.com ([156.153.255.206]:47249 "HELO atlrel8.hp.com")
	by vger.kernel.org with SMTP id <S264973AbSKERQy>;
	Tue, 5 Nov 2002 12:16:54 -0500
Message-ID: <3DC7FE87.AA879F83@hp.com>
Date: Tue, 05 Nov 2002 10:23:19 -0700
From: Khalid Aziz <khalid_aziz@hp.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Padraig Brady <padraig.brady@corvil.com>
Cc: Paul.Clements@steeleye.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.5] Retrieve configuration information from kernel
References: <Pine.LNX.4.10.10210291204590.28595-100000@clements.sc.steeleye.com> <3DBED111.96A3A1E8@hp.com> <3DBFB7AE.6030306@corvil.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Padraig Brady wrote:
> 
> Khalid Aziz wrote:
> > Paul Clements wrote:
> >
> >>Have you considered compressing the config info in order to reduce
> >>the space wastage in the loaded kernel image? Could easily be 10's of KB
> >>(not that that's a lot these days). The info would then be retrieved via
> >>"gunzip -c", et al. instead of a simple "cat".
> >
> > I wanted to start with a simple implementation first. There are a couple
> > of things that can be done in future to further improve meory usage: (1)
> > Drop "CONFIG_" and "# CONFIG_" from each line and add it back when
> > printing from /proc/ikconfig and extract-ikconfig script, (2) Compress
> > the resulting configuration. Something to do in near future :)
> 
> $ wc -c /usr/src/linux-2.4/.config
>    38092 /usr/src/linux-2.4/.config

That charcater count includes all the comments as well. It may not be
much but it is not insignificant.

# wc -c .config
  22174 .config
# grep "^#\? \?CONFIG_"  .config | wc -c
  20623

> $ gzip -c /usr/src/linux-2.4/.config | wc -c
>    10305
> $ sed '/^ *$/d;/^#/d;s/^CONFIG_//'  /usr/src/linux-2.4/.config | wc -c
>    17267
> $ sed '/^ *$/d;/^#/d;s/^CONFIG_//'  /usr/src/linux-2.4/.config | gzip | wc -c
>     6155

Dropping "CONFIG_" and "# CONFIG_" will definitely reduce memory
requirements. We do not want to drop the lines "# CONFIG_* is not set".
If you do that, you end up having to answer lots of questions when
running "make oldconfig".
 
> 
> Also it seems like it would be more useful to have the config in the
> kernel image rather than (just) proc?

It IS in the kernel image. Use scripts/extract-ikconfig to extract it
from the kernel image file. And if you only need it to be in kernel
image, you can choose to not have it under /proc.

--
Khalid 

====================================================================
Khalid Aziz                                Linux and Open Source Lab
(970)898-9214                                        Hewlett-Packard
khalid@hp.com                                       Fort Collins, CO

"The Linux kernel is subject to relentless development" 
				- Alessandro Rubini
