Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316499AbSFDHHe>; Tue, 4 Jun 2002 03:07:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316500AbSFDHHd>; Tue, 4 Jun 2002 03:07:33 -0400
Received: from mortar.viawest.net ([216.87.64.7]:64961 "EHLO
	mortar.viawest.net") by vger.kernel.org with ESMTP
	id <S316499AbSFDHHd>; Tue, 4 Jun 2002 03:07:33 -0400
Date: Tue, 4 Jun 2002 00:07:21 -0700
From: A Guy Called Tyketto <tyketto@wizard.com>
To: Dave Jones <davej@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.20-dj1
Message-ID: <20020604070721.GA2946@wizard.com>
In-Reply-To: <20020604000029.GA13899@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Operating-System: Linux/2.5.7 (i686)
X-uptime: 11:39pm  up  4:16,  2 users,  load average: 0.00, 0.00, 0.00
X-RSA-KeyID: 0xE9DF4D85
X-DSA-KeyID: 0xE319F0BF
X-GPG-Keys: see http://www.wizard.com/~tyketto/pgp.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 04, 2002 at 01:00:29AM +0100, Dave Jones wrote:
> Just a resync against 2.5.20, I'll start digging through
> the rather large patch queue next time, after pushing another
> load of this to Linus..
> 

        -dj1 oopsed on me at bootup, when kicking in the framebuffer (ATI Rage 
128/Radeon). The following patch fixed it for me. It's a variant of the patch 
sent in earlier for the same problem. -dj1 fixed pat of it, this should fix 
the rest. 

--- linux/drivers/video/fbcmap.c.bork	Mon Jun  3 19:08:43 2002
+++ linux/drivers/video/fbcmap.c	Mon Jun  3 19:09:45 2002
@@ -150,7 +150,7 @@
     else
 	tooff = from->start-to->start;
     size = to->len-tooff;
-    if (size > from->len-fromoff)
+    if (size > (int)(from->len-fromoff))
 	size = from->len-fromoff;
     if (size <= 0)
 	return;


                                                        BL.
-- 
Brad Littlejohn                         | Email:        tyketto@wizard.com
Unix Systems Administrator,             |           tyketto@ozemail.com.au
Web + NewsMaster, BOFH.. Smeghead! :)   |   http://www.wizard.com/~tyketto
  PGP: 1024D/E319F0BF 6980 AAD6 7329 E9E6 D569  F620 C819 199A E319 F0BF

