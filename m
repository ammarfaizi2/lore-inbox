Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132224AbRDNN6K>; Sat, 14 Apr 2001 09:58:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132301AbRDNN6B>; Sat, 14 Apr 2001 09:58:01 -0400
Received: from 4dyn187.delft.casema.net ([195.96.105.187]:15109 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S132224AbRDNN5t>; Sat, 14 Apr 2001 09:57:49 -0400
Message-Id: <200104141357.PAA15976@cave.bitwizard.nl>
Subject: Re: Linux-Kernel Archive: No 100 HZ timer !
In-Reply-To: <Pine.LNX.4.10.10104121448520.4564-100000@master.linux-ide.org>
 from Andre Hedrick at "Apr 12, 2001 02:52:22 pm"
To: Andre Hedrick <andre@linux-ide.org>
Date: Sat, 14 Apr 2001 15:57:38 +0200 (MEST)
CC: schwidefsky@de.ibm.com, linux-kernel@vger.kernel.org
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andre Hedrick wrote:
> 
> Okay but what will be used for a base for hardware that has critical
> timing issues due to the rules of the hardware?
> 
> I do not care but your drives/floppy/tapes/cdroms/cdrws do:
> 
> /*
>  * Timeouts for various operations:
>  */
> #define WAIT_DRQ        (5*HZ/100)      /* 50msec - spec allows up to 20ms */
> #ifdef CONFIG_APM
> #define WAIT_READY      (5*HZ)          /* 5sec - some laptops are very slow */
> #else
> #define WAIT_READY      (3*HZ/100)      /* 30msec - should be instantaneous */
> #endif /* CONFIG_APM */
> #define WAIT_PIDENTIFY  (10*HZ) /* 10sec  - should be less than 3ms (?), if all ATAPI CD is closed at boot */
> #define WAIT_WORSTCASE  (30*HZ) /* 30sec  - worst case when spinning up */
> #define WAIT_CMD        (10*HZ) /* 10sec  - maximum wait for an IRQ to happen */
> #define WAIT_MIN_SLEEP  (2*HZ/100)      /* 20msec - minimum sleep time */

May I make a coding-style suggestion (which is ugly on one hand, neat
on the other):

#define mSec   *Hz/1000     /* Convert millisecs to jiffies */
#define Sec    *Hz          /* Convert secs to jiffies */


#define WAIT_DRQ        (50 mSec)   /* spec allows up to 20ms */
#ifdef CONFIG_APM
#define WAIT_READY      ( 5 Sec)    /* some laptops are very slow */
#else
#define WAIT_READY      (30 mSec)   /* should be instantaneous */
#endif /* CONFIG_APM */
#define WAIT_PIDENTIFY  (10 Sec)    /* should be less than 3ms (?), if all ATAPI CD is closed at boot */
#define WAIT_WORSTCASE  (30 Sec)    /* worst case when spinning up */
#define WAIT_CMD        (10 Sec)    /* maximum wait for an IRQ to happen */
#define WAIT_MIN_SLEEP  (20 mSec)   /* minimum sleep time */


I think that this is more readable than the above original. 

Also note that the numbers are not really repeated in the comments. If
someone changes the numbers, but not the comments, it may confuse
someone quite some time before he/she notices that the number that
is used is not the same as the one in the comment. 


				Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 
