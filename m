Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287617AbSALWkh>; Sat, 12 Jan 2002 17:40:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287619AbSALWk1>; Sat, 12 Jan 2002 17:40:27 -0500
Received: from a178d15hel.dial.kolumbus.fi ([212.54.8.178]:31759 "EHLO
	porkkala.jlaako.pp.fi") by vger.kernel.org with ESMTP
	id <S287617AbSALWkO>; Sat, 12 Jan 2002 17:40:14 -0500
Message-ID: <3C40BAF0.63D51527@kolumbus.fi>
Date: Sun, 13 Jan 2002 00:38:40 +0200
From: Jussi Laako <jussi.laako@kolumbus.fi>
X-Mailer: Mozilla 4.79 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: arjan@fenrus.demon.nl
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Additions to full lowlatency patch
In-Reply-To: <m16PWFF-000OVeC@amadeus.home.nl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

arjan@fenrus.demon.nl wrote:
> 
> Did you audit all uses of this function ? It sort of looks like you're 
> doing "hey there's a udelay lets add a schedule".. ok that's a bit rude 
> but I'm not totally convinced that this function isn't called with 
> spinlocks helt...

I have not done deeper research on the codepaths, but I have tested the
drivers after change and they work. I tried to look for for/while {
usleep(n); } timeout waits and no dangerous looking spinlocks held or
interrupts disabled.

I'm ready to do more extensive work to fix similar cases if I get
theoretical "OK" for the changes. I won't continue if people point out that
this is wrong way(tm).

The patch is quick hack for my own use and for review and shouldn't be used
unless proven correct. It's just my first try to hack linux kernel... :)

I just dislike

while (!hardware_completed()) usleep(1000);

-style code in some drivers (a bit extreme example).


 - Jussi Laako

-- 
PGP key fingerprint: 161D 6FED 6A92 39E2 EB5B  39DD A4DE 63EB C216 1E4B
Available at PGP keyservers

