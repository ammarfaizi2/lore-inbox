Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268058AbUHFOQh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268058AbUHFOQh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 10:16:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268059AbUHFOQh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 10:16:37 -0400
Received: from users.linvision.com ([62.58.92.114]:55953 "HELO bitwizard.nl")
	by vger.kernel.org with SMTP id S268058AbUHFOQQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 10:16:16 -0400
Date: Fri, 6 Aug 2004 16:16:15 +0200
From: Erik Mouw <erik@harddisk-recovery.com>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: axboe@suse.de, James.Bottomley@steeleye.com, linux-kernel@vger.kernel.org
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Message-ID: <20040806141615.GC21660@harddisk-recovery.com>
References: <200408061345.i76DjkT5005999@burner.fokus.fraunhofer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408061345.i76DjkT5005999@burner.fokus.fraunhofer.de>
User-Agent: Mutt/1.3.28i
Organization: Harddisk-recovery.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 06, 2004 at 03:45:46PM +0200, Joerg Schilling wrote:
> >Testing if at least CCS_SENSE_LEN (18) is supported...
> >Sense Data: 70 00 05 00 00 00 00 0A 00 00 00 00 24 00 00 C0 00 03
> 
> Wonderful, so you just found another bug in the Linux kernel include files.
> 
> To fix: edit sg.h in the Linux kernel source tree and fix the value for
> SG_MAX_QUEUE or if you believe you cannot change it, create a new #define
> and document it......

Uhm, it *is* documented:

In include/scsi/sg.h, line 255:

/* maximum outstanding requests, write() yields EDOM if exceeded */
#define SG_MAX_QUEUE 16

SG_MAX_QUEUE has nothing to do with inquiry length but with the maximum
number of queued commands (hence the name SG_MAX_QUEUE).

I'm sorry, but I think Jens found a genuine bug in your program. IMHO
it would increase your credits on this list if you admit it and fix the
bug. If you don't, we'll keep this kind of linux-vs-cdrecord threads on
lkml. That can't be the idea, cause we all just agreed that we wanted
to keep the amount noise on this list low.


BTW, you are right for the old SG implementations. Line 267 of
include/scsi/sg.h:

/* vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv */
/*   The older SG interface based on the 'sg_header' structure follows.   */
/* ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ */

#define SG_MAX_SENSE 16   /* this only applies to the sg_header interface */

You're free to use old and deprecated implementations but don't file
bugs against them cause they are old and deprecated for a reason.



Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
