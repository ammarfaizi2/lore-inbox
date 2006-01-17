Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751346AbWAQJuY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751346AbWAQJuY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 04:50:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751349AbWAQJuY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 04:50:24 -0500
Received: from lucidpixels.com ([66.45.37.187]:52370 "EHLO lucidpixels.com")
	by vger.kernel.org with ESMTP id S1751346AbWAQJuV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 04:50:21 -0500
Date: Tue, 17 Jan 2006 04:50:20 -0500 (EST)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p34
To: Phil Oester <kernel@linuxace.com>
cc: linux-kernel@vger.kernel.org, apiszcz@lucidpixels.com
Subject: Re: Kernel 2.6.15.1 + NFS is 4 times slower than FTP!?
In-Reply-To: <20060117012319.GA22161@linuxace.com>
Message-ID: <Pine.LNX.4.64.0601170450020.2377@p34>
References: <Pine.LNX.4.64.0601161957300.16829@p34> <20060117012319.GA22161@linuxace.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

NFS is still twice as slow as FTP, but best with a r/w size of 8192.

DEFAULT, NO OPTIONS
# mount p34:/ /nfs/p34
$ /usr/bin/time cp 700mb.img  /p34/x/d
0.01user 1.64system 0:34.23elapsed 4%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+196minor)pagefaults 0swaps

TCP, NO CACHING
# mount p34:/ /nfs/p34 -o nfsvers=3,tcp,noac
$ /usr/bin/time cp 700mb.img  /p34/x/a
0.02user 5.25system 0:58.43elapsed 9%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+197minor)pagefaults 0swaps

UDP, NO CACHING
# mount p34:/ /nfs/p34 -o nfsvers=3,noac
$ /usr/bin/time cp 700mb.img  /p34/x/b
0.02user 5.54system 1:00.34elapsed 9%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+196minor)pagefaults 0swaps

UDP, NO CACHING (w/65535 r/w size)
# mount p34:/ /nfs/p34 -o nfsvers=3,noac,rsize=65535,wsize=65535
$ /usr/bin/time cp 700mb.img  /p34/x/c
0.01user 5.75system 0:59.89elapsed 9%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+196minor)pagefaults 0swaps

# mount p34:/ /nfs/p34 -o nfsvers=3,rsize=8192,wsize=8192
0.04user 1.78system 0:14.16elapsed 12%CPU (0avgtext+0avgdata 
0maxresident)k
0inputs+0outputs (0major+190minor)pagefaults 0swaps

UDP, NFSV3 + (w/8192 r/w size)
$ /usr/bin/time cp 700mb.img  /p34/x/g
0.04user 1.78system 0:14.16elapsed 12%CPU (0avgtext+0avgdata 
0maxresident)k
0inputs+0outputs (0major+190minor)pagefaults 0swaps

TCP, NFSV3 + (w/8192 r/w size)
0.03user 1.81system 0:14.98elapsed 12%CPU (0avgtext+0avgdata 
0maxresident)k
0inputs+0outputs (0major+190minor)pagefaults 0swaps

UDP, NFSV3 + (w/16384 r/w size)
# mount p34:/ /nfs/p34 -o nfsvers=3,rsize=16834,wsize=16384
$ /usr/bin/time cp 700mb.img  /p34/x/e
0.03user 1.75system 0:20.20elapsed 8%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+192minor)pagefaults 0swaps

UDP, NFSV3 + (w/32768 r/w size)
# mount p34:/ /nfs/p34 -o nfsvers=3,rsize=32768,wsize=32768
  /usr/bin/time cp 700mb.img  /p34/x/f
0.01user 1.59system 0:32.87elapsed 4%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+196minor)pagefaults 0swaps






On Mon, 16 Jan 2006, Phil Oester wrote:

> On Mon, Jan 16, 2006 at 08:07:02PM -0500, Justin Piszcz wrote:
>> I suppose I should try NFS with TCP, yes?
>
> Precisely.
>
> Phil
>
