Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132963AbRDKT33>; Wed, 11 Apr 2001 15:29:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132968AbRDKT3U>; Wed, 11 Apr 2001 15:29:20 -0400
Received: from elf.ihep.su ([194.190.161.106]:52233 "EHLO elf.ihep.su")
	by vger.kernel.org with ESMTP id <S132963AbRDKT3D>;
	Wed, 11 Apr 2001 15:29:03 -0400
Date: Wed, 11 Apr 2001 23:28:36 +0400
From: "Eugene B. Berdnikov" <berd@elf.ihep.su>
To: kuznet@ms2.inr.ac.ru
Cc: linux-kernel@vger.kernel.org, davem@redhat.com
Subject: Re: Bug report: tcp staled when send-q != 0, timers == 0.
Message-ID: <20010411232836.C19364@elf.ihep.su>
In-Reply-To: <20010411223536.A19364@elf.ihep.su> <200104111904.XAA10804@ms2.inr.ac.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4us
In-Reply-To: <200104111904.XAA10804@ms2.inr.ac.ru>; from kuznet@ms2.inr.ac.ru on Wed, Apr 11, 2001 at 11:04:04PM +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello.

On Wed, Apr 11, 2001 at 11:04:04PM +0400, kuznet@ms2.inr.ac.ru wrote:
> >  In my experiments linux simply sets mss=mtu-40 at the start of ethernet
> >  connections. I do not know why, but belive it's ok. How the version of
> >  kernel and configuration options can affect mss later?
[...]
> The problem begins f.e. when mss is less and packet arrives on ethernet.
> It eats the same 1.5k of memory, but carries only ~mss bytes of tcp payload.
> See? We do not know this forward, advertise large window, have not enough
> rcvbuf to get it filled and cannot do anything but dropping new packets.

 However, I can't understand the dependency upon the kernel version, etc...

 Let me steak on this question again. In my experiments I found the
 dependency on the keepalive setting for connection on 2.2.17:

   mtu 382 + keepalive yes -> loss
   mtu 382 + keepalive no  -> ok

 I made 2 tries for each setting. Does your model of "mss/mtu bug" cover
 such a picture? If the answer is "yes", I am almost satisfied. :-)

 If this behaviour is not deterministic, and is driven by probability,
 does it mean that I can get other results with large number of tests?
-- 
 Eugene Berdnikov
