Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318510AbSHLAht>; Sun, 11 Aug 2002 20:37:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318514AbSHLAht>; Sun, 11 Aug 2002 20:37:49 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:61711 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S318510AbSHLAhs>; Sun, 11 Aug 2002 20:37:48 -0400
Date: Sun, 11 Aug 2002 21:41:21 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Adam Kropelin <akropel1@rochester.rr.com>
cc: Andrew Morton <akpm@zip.com.au>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 1/21] random fixes
In-Reply-To: <20020812002739.GA778@www.kroptech.com>
Message-ID: <Pine.LNX.4.44L.0208112132570.23404-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 Aug 2002, Adam Kropelin wrote:

> fast IBM disk. Filesystem was ext3 in data=ordered mode. Test workload
> was an inbound (from the point of view of the system under test) FTP
> transfer of a 600 MB iso image. All test runs were from a clean boot
> with all unnecessary services shut down.

> machine stalled (FTP transfer halted, vmstat output paused, etc.). With
> 2.5.31-akpm, the stalls were about 3-4 seconds in length. With 2.5.31,
> the stalls were of the same duration, but slightly less frequent. With

Definately some writeout sillyness.  Why would we ever stop
writing pages to disk while a transfer is going on and then
suddenly decide to stall the system because pages are being
dirtied at a rate faster than we write them ?

If we can smooth out the writing we can keep the disks busy
all the time and should in theory perform better. I wonder
why Andrew made the writeout in 2.5 _more_ bursty ...

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

