Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265865AbTF3SYQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jun 2003 14:24:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265867AbTF3SYQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jun 2003 14:24:16 -0400
Received: from [66.212.224.118] ([66.212.224.118]:7432 "EHLO
	hemi.commfireservices.com") by vger.kernel.org with ESMTP
	id S265865AbTF3SYL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jun 2003 14:24:11 -0400
Date: Mon, 30 Jun 2003 14:27:18 -0400 (EDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
X-X-Sender: zwane@montezuma.mastecende.com
To: Con Kolivas <kernel@kolivas.org>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] patch-O1int-0306302317 for 2.5.73 interactivity
In-Reply-To: <200307010029.19423.kernel@kolivas.org>
Message-ID: <Pine.LNX.4.53.0306301405230.2299@montezuma.mastecende.com>
References: <200307010029.19423.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Jul 2003, Con Kolivas wrote:

> Buried deep in another mail thread was the latest implementation of my O1int 
> patch so I've brought it to the surface to make it clear this one is 
> significantly different from past iterations.
> 
> Summary:
> Decreases audio skipping with loads.
> Smooths out X performance with load.

I tried this with normal developer box type load on a slow box ie;

2x 400MHz 512MB source/build fs' on UW2 SCSI
kernel: 2.5.72-mm3

2x make -j2 bzImage
bk pull (linux-2.5 repo)
cvs import of 2.5 tree
navigating bk revtool (this normally causes pauses)
read disk benchmark just to thrash IDE about a bit ;)

Still a few MP3 pauses (due to bk revtool mainly) but mouse/keyboard 
response was good, there is however a vast improvement over 2.5.73 
stock (2-5s pauses with no keyboard/mouse response) for my particular 
workload.

zwane@montezuma ~ {0:0} uptime
 14:18:06  up 54 min, 25 users,  load average: 7.33, 6.58, 5.59
zwane@montezuma ~ {0:0} vmstat 1
   procs                      memory      swap          io     system      cpu
 r  b  w   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id
 3  3  1  27444   3628   4012 108068    4   11  5837  1680  841   994 58 22 20
 1  5  0  27428   4920   8184 107924    8    0 11292   948 1551  3081 49 51  0
 3  3  1  27432   3832   7764 107664    0    8 13084  1440 1503  2192 52 45  3
 1  5  0  27432  14552  20992  83772  332    0 16320   844 1632  2721 56 44  0
 0  6  0  24500  15568  31548  91088  224    0 17160     0 1552  2423 67 33  0
 2  4  1  24504   2916  33428  96788   32    0 21912   580 1703  2969 62 38  0
 4  2  2  24508   3284  25688  98812    0    4 23248  2164 1575  2507 74 26  0
 2  4  1  24512   2780  18984 103752    0    8 22412   796 1606  2693 76 24  0
 6  2  0  24516   4012  13324 107712    0    4 20224  1604 1738  2916 69 31  0
 6  1  1  24528   2196  14836 108172    0    8 20188  2472 2260  4051 58 42  0

-- 
function.linuxpower.ca
