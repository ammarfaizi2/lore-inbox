Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286712AbRL1Dnd>; Thu, 27 Dec 2001 22:43:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286723AbRL1DnW>; Thu, 27 Dec 2001 22:43:22 -0500
Received: from sgie000400.kiv-webservice.de ([195.226.81.253]:36359 "EHLO
	irc.kiv-host.de") by vger.kernel.org with ESMTP id <S286712AbRL1DnH>;
	Thu, 27 Dec 2001 22:43:07 -0500
Message-ID: <4353BABFDF95D311BFC30004AC4CB22AAE3436@sdar000001.kiv-da.de>
From: "Stolle, Martin (KIV)" <MStolle@kiv.de>
To: "'Mike Galbraith '" <mikeg@wen-online.de>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: Informix 7.3 and Linux Kernel 2.4
Date: Fri, 28 Dec 2001 04:42:00 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2.4.9, buffer heads in /proc/slabinfo looks like

inode_cache        39855  40440    480 5055 5055    1 :  124   62
dentry_cache       13326  14490    128  483  483    1 :  252  126
filp                 541    680     96   17   17    1 :  252  126
names_cache            3      3   4096    3    3    1 :   60   30
buffer_head       691683 977920     96 24445 24448    1 :  252  126
mm_struct            120    120    160    5    5    1 :  252  126
vm_area_struct      4299   4425     64   75   75    1 :  252  126
fs_cache             177    177     64    3    3    1 :  252  126
files_cache          117    117    416   13   13    1 :  124   62
signal_act           120    120   1312   40   40    1 :   60   30


buffer head grows always bigger and bigger.

btw, 

I use raw partitions for storing the data.


Tomorrow you'll get the data for 2.4.17, I have to wait, because people
there
is a financial software on the database and the users want to enter the last
bookings
for the year 2001.


-----Original Message-----
From: Mike Galbraith
To: Stolle, Martin (KIV)
Cc: linux-kernel
Sent: 12/27/2001 8:42 AM
Subject: Re: Informix 7.3 and Linux Kernel 2.4

On Thu, 27 Dec 2001, Stolle, Martin (KIV) wrote:

> At first, Informix works quite well, but after a while, especially
> after some traffic on the computer (reading the harddisk by "find",
> do a "update statistics" under informix or some exports, the system
> starts thrashing.
>
> I found out, that it starts thrashing with kswapd using 50% of
processor
> power and oninit using another 50%, when low memory runs short.

(sounds like much zone_normal unfreeable creating persistant imbalance)

> >From then, the system is very very slow.
> The problem isn't so dramatic with kernel releases <=2.4.9, but with
higher
> releases, including 2.4.17, it is not tolerable.
> 2.4.17 does not swap to disk, but is still very slow, but kswapd is
always
> active (without swapping to disk!).

What does /proc/slabinfo look like with 2.4.17?  (zillion buffer heads?)

	-Mike
