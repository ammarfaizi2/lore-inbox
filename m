Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261586AbVBWVGO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261586AbVBWVGO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 16:06:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261590AbVBWVGN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 16:06:13 -0500
Received: from bernache.ens-lyon.fr ([140.77.167.10]:3513 "EHLO
	bernache.ens-lyon.fr") by vger.kernel.org with ESMTP
	id S261589AbVBWVFz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 16:05:55 -0500
Date: Wed, 23 Feb 2005 22:05:52 +0100
From: Benoit Boissinot <benoit.boissinot@ens-lyon.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Roland McGrath <roland@redhat.com>
Subject: Re: 2.6.11-rc4-mm1
Message-ID: <20050223210552.GA14583@ens-lyon.fr>
References: <20050223014233.6710fd73.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050223014233.6710fd73.akpm@osdl.org>
User-Agent: Mutt/1.5.8i
X-Spam-Report: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 23, 2005 at 01:42:33AM -0800, Andrew Morton wrote:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11-rc4/2.6.11-rc4-mm1/
> 
> 
> - Various fixes and updates all over the place.  Things seem to have slowed
>   down a bit.
> 
> - Last, final, ultimate call: if anyone has patches in here which are 2.6.11
>   material, please tell me.
> 
> 
> 
> Changes since 2.6.11-rc3-mm1:
> 
> make-itimer_real-per-process.patch
>   make ITIMER_REAL per-process
> 
> make-itimer_prof-itimer_virtual-per-process.patch
>   make ITIMER_PROF, ITIMER_VIRTUAL per-process
>

gcc-4.0 warns with reasons on this patches:

kernel/itimer.c: In function ‘do_getitimer’:
kernel/itimer.c:61: warning: ‘val’ is used uninitialized in this
function

Signed-off-by: Benoit Boissinot <benoit.boissinot@ens-lyon.org>


--- linux/kernel/itimer.c	2005-02-23 12:16:36.000000000 +0100
+++ linux-test/kernel/itimer.c	2005-02-23 21:53:10.000000000 +0100
@@ -58,7 +58,7 @@ int do_getitimer(int which, struct itime
 			if (cputime_le(cval, utime)) { /* about to fire */
 				val = jiffies_to_cputime(1);
 			} else {
-				val = cputime_sub(val, utime);
+				val = cputime_sub(cval, utime);
 			}
 		}
 		spin_unlock_irq(&tsk->sighand->siglock);
@@ -84,7 +84,7 @@ int do_getitimer(int which, struct itime
 			if (cputime_le(cval, ptime)) { /* about to fire */
 				val = jiffies_to_cputime(1);
 			} else {
-				val = cputime_sub(val, ptime);
+				val = cputime_sub(cval, ptime);
 			}
 		}
 		spin_unlock_irq(&tsk->sighand->siglock);


