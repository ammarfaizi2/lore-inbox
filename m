Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262662AbSK0NrW>; Wed, 27 Nov 2002 08:47:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262664AbSK0NrW>; Wed, 27 Nov 2002 08:47:22 -0500
Received: from [211.167.76.68] ([211.167.76.68]:13478 "HELO soulinfo")
	by vger.kernel.org with SMTP id <S262662AbSK0NrV>;
	Wed, 27 Nov 2002 08:47:21 -0500
Date: Wed, 27 Nov 2002 21:52:23 +0800
From: hugang <hugang@soulinfo.com>
To: Rik van Riel <riel@conectiva.com.br>
Cc: tux@sentinel.dk, linux-kernel@vger.kernel.org
Subject: Re: Limiting max cpu usage per user (old Conectiva patch)
Message-Id: <20021127215223.429d5ae6.hugang@soulinfo.com>
In-Reply-To: <Pine.LNX.4.44L.0211271008370.4103-100000@imladris.surriel.com>
References: <3DE49A66.4020208@sentinel.dk>
	<Pine.LNX.4.44L.0211271008370.4103-100000@imladris.surriel.com>
X-Mailer: Sylpheed version 0.8.5claws126 (GTK+ 1.2.10; )
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
=?ISO-8859-1?Q?=CA=D5=BC=FE=C8=CB=A3=BA: ?= Rik van Riel <riel@conectiva.com.br>
=?ISO-8859-1?Q?=B3=AD=CB=CD=A3=BA: ?= tux@sentinel.dk
=?ISO-8859-1?Q?=B3=AD=CB=CD=A3=BA: ?= linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Nov 2002 10:08:56 -0200 (BRST)
Rik van Riel <riel@conectiva.com.br> wrote:

>  It's on my patches page:
> 
>  	http://surriel.com/patches/
> 
>  cheers,
The patch is works. Here is the test.
w.c
-------
#include <stdio.h>
main()
{
while(1);
}

-------
start 5 w as normal user..
start 5 w as root user.

Enabel the fairsched 
echo 1 > /proc/sys/kernel/fairsched
  PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME COMMAND
  976 root      20   0   248  248   204 R    13.1  0.0   0:28 w
  974 root      20   0   248  248   204 R    12.9  0.0   0:28 w
  975 root      20   0   248  248   204 R    12.9  0.0   0:28 w
  973 root      17   0   248  248   204 R    12.5  0.0   0:29 w
  972 root      14   0   248  248   204 R    11.9  0.0   0:30 w
  968 hugang    20   0   252  252   208 R     7.1  0.0   0:18 w
  970 hugang    20   0   252  252   208 R     7.1  0.0   0:17 w
  967 hugang    20   0   252  252   208 R     5.9  0.0   0:19 w
  969 hugang    20   0   252  252   208 R     5.9  0.0   0:17 w
  966 hugang    14   0   252  252   208 R     5.9  0.0   0:20 w

Disabel the fairsched
echo 0 > /proc/sys/kernel/fairsched
  969 hugang    16   0   252  252   208 R     9.7  0.0   0:20 w
  970 hugang    16   0   252  252   208 R     9.7  0.0   0:19 w
  966 hugang    16   0   252  252   208 R     9.5  0.0   0:23 w
  974 root      16   0   248  248   204 R     9.5  0.0   0:32 w
  968 hugang    16   0   252  252   208 R     9.5  0.0   0:20 w
  975 root      16   0   248  248   204 R     9.5  0.0   0:32 w
  976 root      16   0   248  248   204 R     9.5  0.0   0:32 w
  972 root      16   0   248  248   204 R     9.5  0.0   0:34 w
  967 hugang    16   0   252  252   208 R     9.1  0.0   0:21 w
  973 root      16   0   248  248   204 R     8.9  0.0   0:33 w

-- 
		- Hu Gang
