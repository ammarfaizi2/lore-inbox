Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270772AbRHSUzC>; Sun, 19 Aug 2001 16:55:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270774AbRHSUyx>; Sun, 19 Aug 2001 16:54:53 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:54799 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S270772AbRHSUyj>; Sun, 19 Aug 2001 16:54:39 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Frank Dekervel <Frank.dekervel@student.kuleuven.ac.Be>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4.8/2.4.9 VM problems
Date: Sun, 19 Aug 2001 23:00:32 +0200
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <200108171310.PAA26032@lambik.cc.kuleuven.ac.be>
In-Reply-To: <200108171310.PAA26032@lambik.cc.kuleuven.ac.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010819205452Z16128-32383+429@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On August 17, 2001 03:10 pm, Frank Dekervel wrote:
> Hello,
> 
> since i upgraded to kernel 2.4.8/2.4.9, i noticed everything became noticably 
> slower, and the number of swapins/swapouts increased significantly. When i 
> run 'vmstat 1' i see there is a lot of swap activity constantly when i am 
> reading my mail in kmail. After a fresh bootup in the evening, i can get 
> everything I normally need swapped out by running updatedb or ht://dig. When 
> i do that, my music stops playing for several seconds, and it takes about 3 
> seconds before my applications repaint when i switch back to X after an 
> updatedb run.
> the last time that happent (and the last time i had problems with VM at all) 
> was in 2.4.0-testXX so i think something is wrong ...
> is it possible new used_once does not work for me (and drop_behind used to 
> work fine) ?
> 
> My system configuration : athlon 750, 384 meg ram, 128 meg swap, XFree4.1 and 
> kde2.2.

Could you please try this patch against 2.4.9 (patch -p0):

--- ../2.4.9.clean/mm/memory.c	Mon Aug 13 19:16:41 2001
+++ ./mm/memory.c	Sun Aug 19 21:35:26 2001
@@ -1119,6 +1119,7 @@
 			 */
 			return pte_same(*page_table, orig_pte) ? -1 : 1;
 		}
+		SetPageReferenced(page);
 	}
 
 	/*
