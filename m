Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264668AbRFPVzd>; Sat, 16 Jun 2001 17:55:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264667AbRFPVzX>; Sat, 16 Jun 2001 17:55:23 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:64016 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S264669AbRFPVzT>;
	Sat, 16 Jun 2001 17:55:19 -0400
Date: Sat, 16 Jun 2001 18:54:38 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Pavel Machek <pavel@suse.cz>, John Stoffel <stoffel@casc.com>,
        Roger Larsson <roger.larsson@norran.net>,
        Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: spindown [was Re: 2.4.6-pre2, pre3 VM Behavior]
In-Reply-To: <0106162344570L.00879@starship>
Message-ID: <Pine.LNX.4.21.0106161853510.2056-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Jun 2001, Daniel Phillips wrote:

> > Does the patch below do anything good for your laptop? ;)
> 
> I'll wait for the next one ;-)

OK, here's one which isn't reversed and should work ;))

--- fs/buffer.c.orig	Sat Jun 16 18:05:29 2001
+++ fs/buffer.c	Sat Jun 16 18:05:15 2001
@@ -2550,7 +2550,8 @@
 			   if the current bh is not yet timed out,
 			   then also all the following bhs
 			   will be too young. */
-			if (time_before(jiffies, bh->b_flushtime))
+			if (++flushed > bdf_prm.b_un.ndirty &&
+					time_before(jiffies, bh->b_flushtime))
 				goto out_unlock;
 		} else {
 			if (++flushed > bdf_prm.b_un.ndirty)

cheers,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

